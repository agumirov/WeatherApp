//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

class WeatherViewModelImpl: WeatherViewModel {
    
    var state: Observable<State> {
        _state.asObservable()
    }
    private var _state = PublishRelay<State>()
    
    var output: Observable<OutputEvents> {
        _output.asObservable()
    }
    private var _output = PublishRelay<WeatherViewModelOutput>()
    
    private let disposeBag = DisposeBag()
    private var input: Input
    private let weatherRepository: WeatherRepository // тоже должны быть ивенты?
    private let weatherStorageManager: WeatherStorageManager
    
    struct Input {
        var geoData: GeoModelDomain?
    }
    
    init(input: Input,
         weatherRepository: WeatherRepository,
         weatherStorageManager: WeatherStorageManager
    ) {
        self.input = input
        self.weatherRepository = weatherRepository
        self.weatherStorageManager = weatherStorageManager
    }
    
    private func getWeatherData(geoData: GeoModelDomain?) async throws -> WeatherModelDomain {
        let task = Task {
            let data = try? await weatherRepository.getWeatherData(geoData: geoData)
            return data
        }
        guard let result = await task.value else { throw Errors.fetchDataError }
        return result
    }
}

extension WeatherViewModelImpl {
    
    enum State {
        case fetchingData
        case sucess(weatherModel: WeatherModelDomain,
                    date: String, weekWeather: [WeekModelDomain])
        case failure(Error)
    }
    
    enum OutputEvents {
        case showSearchScreen
    }
    
    enum Errors: String, Error {
        case fetchDataError = "Fetched data is nil"
    }
    
    func sendEvent(_ event: WeatherViewEvent) {
        switch event {
        case .searchSelected:
            self._output.accept(.showSearchScreen)
        case .viewDidLoad:
            setState(.fetchingData)
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let weatherData = try await self.getWeatherData(geoData: input.geoData)
                    let (date, weekWeather) = prepareData(date: weatherData.date,
                                                          weekWeather: weatherData.list)
                    await MainActor.run {
                        setState(.sucess(weatherModel: weatherData, date: date,
                                         weekWeather: weekWeather))
                    }
                } catch let error {
                    DispatchQueue.main.async { [weak self] in
                        self?.setState(.failure(error))
                    }
                }
            }
        }
    }
    
    private func prepareData(date: Double, weekWeather: [WeatherList]) -> (String, [WeekModelDomain]) {
        
        let date: String = {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            
            let date = Date(timeIntervalSince1970: date)
            let text = dateFormatter.string(from: date)
            return text
        }()
        
        let list: [WeekModelDomain] = {
            
            var weekDayData: [WeekModelDomain] = []
            var currentDate = NSDate.now
            let weatherList = weekWeather
            
            for weekDay in weatherList {
                
                let calendar = Calendar.current
                let date = calendar.dateComponents([.day], from: Date(timeIntervalSince1970: weekDay.dt))
                let dateDay = date.day
                let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
                let nextDay = calendar.dateComponents([.day], from: nextDayDate ?? .distantFuture).day
                
                if dateDay == nextDay {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEE"
                    
                    weekDayData.append(WeekModelDomain(weather: weekDay))
                    currentDate = nextDayDate ?? .distantFuture
                }
            }
            return weekDayData
        }()
        
        return (date, list)
    }
    
    private func setState(_ state: State) {
        self._state.accept(state)
    }
}
