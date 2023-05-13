//
//  DetailViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModelImpl: SearchViewModel, ViewModel {
    
    var state: RxRelay.BehaviorRelay<SearchViewController.State> = BehaviorRelay(value: .initial)
    
    var geoRepository: GeoRepository
    
    var cities: [GeoModelDomain] = []
    
    var data: [WeatherModelAPI] = []
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType
    
    init(
        coordinator: CoordinatorType,
        geoRepository: GeoRepository
    ) {
        self.coordinator = coordinator
        self.geoRepository = geoRepository
    }
    
    private func searchCall(cityName: String) {
        Task {
            guard let cities = try? await geoRepository.getGeoData(cityName: cityName) else {
                state.accept(.failure)
                return
            }
            await MainActor.run {
                self.cities = cities
            }
        }
    }
    
    private func showWeather(geoData: GeoModelDomain) {
        coordinator.showWeatherScreen(geoData: geoData)
    }
    
    private func cancelSearch() {
        coordinator.pop()
    }
    
    func handleEvent(event: SearchViewController.Event) {
        switch event {
        case let .showWeather(geoData):
            self.state.accept(.loading)
            showWeather(geoData: geoData)
        case let .showCities(value: value):
            searchCall(cityName: value)
            self.state.accept(.loaded(cities: cities))
        case .pop:
            cancelSearch()
        }
    }
}
