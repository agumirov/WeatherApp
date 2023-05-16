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
    
    var input: WeatherViewModelInput
    var output: WeatherViewModelOuput
    private let disposeBag = DisposeBag()
    private let geoData: GeoModelDomain
    private let weatherRepository: WeatherRepository // тоже должны быть ивенты?
    
    struct Input: WeatherViewModelInput {
        var event = PublishRelay<WeatherViewEvent>()
    }
    
    struct Output: WeatherViewModelOuput {
        var state = PublishRelay<WeatherViewState>()
        var event = PublishRelay<WeatherViewModelImpl.OutputEvents>()
    }
    
    init(
        geoData: GeoModelDomain,
        weatherRepository: WeatherRepository
    ) {
        self.weatherRepository = weatherRepository
        self.geoData = geoData
        self.input = Input()
        self.output = Output()
        
        bindInputs()
    }
    
    private func bindInputs() {
        self.input.event
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                let event = WeatherEventConverter.convert(event: event)
                self.handleEvent(event: event)
            })
            .disposed(by: disposeBag)
    }
    
    private func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelDomain {
        let task = Task {
            let data = try? await weatherRepository.getWeatherData(geoData: geoData)
            return data
        }
        guard let result = await task.value else { throw Errors.fetchDataError }
        return result
    }
}

extension WeatherViewModelImpl {
    
    enum InputEvents {
        case fetchWeatherData
        case sendWeatherDataToOutput(WeatherModelDomain)
        case routeToSearch
    }
    
    enum OutputEvents {
        case showSearchScreen
    }
    
    enum Errors: String, Error {
        case fetchDataError = "Fetched data is nil"
    }
    
    private func handleEvent(event: InputEvents) {
        
        switch event {
        case .fetchWeatherData:
            self.output.state.accept(.loading)
            Task {
                let weatherData = try await self.getWeatherData(geoData: self.geoData)
                handleEvent(event: .sendWeatherDataToOutput(weatherData))
            }
            
        case .routeToSearch:
            self.output.state.accept(.loading)
            self.output.event.accept(.showSearchScreen)
            self.output.state.accept(.initial)
            
        case let .sendWeatherDataToOutput(weatherData):
            DispatchQueue.main.async {
                self.output.state.accept(.success(weatherData))
            }
        }
    }
}
