//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

class WeatherViewModelImpl: ViewModel, WeatherViewModel {
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType
    
    var weatherData: WeatherModelDomain?
    
    private let geoData: GeoModelDomain
    
    private let weatherRepository: WeatherRepository
    
    var state: BehaviorRelay<WeatherViewController.WeatherState> = BehaviorRelay(value: .initial)
    
    init(
        geoData: GeoModelDomain,
        coordinator: CoordinatorType,
        weatherRepository: WeatherRepository
    ) {
        self.coordinator = coordinator
        self.weatherRepository = weatherRepository
        self.geoData = geoData
    }
    
    func viewDidLoad() {}
    
    private func getWeatherData(geoData: GeoModelDomain) {
        Task {
            let data = try? await weatherRepository.getWeatherData(geoData: geoData)
            await MainActor.run { [weak self] in
                self?.weatherData = data
                self?.state.accept(.success)
            }
        }
    }
}

extension WeatherViewModelImpl {
    
    func handleEvent(event: WeatherViewController.WeatherEvent) {
        state.accept(.loading)
        switch event {
        case .searchSelected:
            self.coordinator.showSearchScreen()
            self.state.accept(.initial)
        case .showWeather:
            getWeatherData(geoData: geoData)
        }
    }
}
