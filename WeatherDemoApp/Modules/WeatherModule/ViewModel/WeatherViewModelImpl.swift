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
            let data = try await weatherRepository.getWeatherData(geoData: geoData)
            return data
        }
        guard let result = try await task.value else { throw Errors.fetchDataError }
        return result
    }
}

extension WeatherViewModelImpl {
    
    enum State {
        case fetchingData
        case success(weatherModel: WeatherModelDomain,
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
                        setState(.success(weatherModel: weatherData, date: date,
                                          weekWeather: weekWeather))
                    }
                } catch let error {
                    DispatchQueue.main.async { [weak self] in
                        self?.setState(.failure(error))
                        self?._output.accept(.showSearchScreen)
                    }
                }
            }
        }
    }
    
    private func prepareData(date: Double, weekWeather: [WeatherList]) -> (String, [WeekModelDomain]) {
        
        let date: String = DateService.convertTimestampToFullStringDate(date)
        
        let list: [WeekModelDomain] = {
            var weekDayData: [WeekModelDomain] = []
            var currentDate = Date()
            let weatherList = weekWeather
            
            for weekDay in weatherList {
                let dateDay = DateService.getDayComponent(fromDate: Date(timeIntervalSince1970: weekDay.dt))
                let nextDayDate = DateService.calculateNextDay(fromDate: currentDate)
                let nextDay = DateService.getDayComponent(fromDate: nextDayDate)
                
                if dateDay == nextDay {
                    weekDayData.append(WeekModelDomain(weather: weekDay))
                    currentDate = nextDayDate
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
