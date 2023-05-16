//
//  DetailViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModelImpl: SearchViewModel {
    
    var output: Observable<SearchViewModelOutput> {
        _output.asObservable()
    }
    private var _output = PublishRelay<OutputEvent>()
    
    var state: Observable<SearchViewModelState> {
        _state.asObservable()
    }
    private var _state: BehaviorRelay<State> = .init(value: .waitingForInput)
    private var geoRepository: GeoRepository
    private var disposeBag = DisposeBag()
    
    init(geoRepository: GeoRepository) {
        self.geoRepository = geoRepository
    }
        
    private func searchCall(cityName: String) async throws -> [GeoModelDomain] {
        
        let task = Task {
            let cities = try? await geoRepository.getGeoData(cityName: cityName)
            return cities
        }
        
        guard let result = await task.value else {
            setState(.failure(Errors.fetchDataError))
            return []
        }
        return result
    }
}

// States/Events
extension SearchViewModelImpl {
    
    enum State {
        case waitingForInput
        case sucess([GeoModelDomain])
        case failure(Error)
    }
    
    enum OutputEvent {
        case routeToWeatherModule(GeoModelDomain)
        case abortSearch
    }
    
    enum Errors: String, Error {
        case fetchDataError = "Fetched data is nil"
    }
    
    func sendEvent(_ event: SearchViewEvent) {
        switch event {
            
        case let .showWeather(geoData):
            _output.accept(.routeToWeatherModule(geoData))
            
        case let .showCities(value):
            Task {
                do {
                    let cities = try await searchCall(cityName: value)
                    setState(.sucess(cities))
                } catch let error {
                    setState(.failure(error))
                }
            }
            
        case .cancelSearch:
            sendOuput(.abortSearch)
        }
    }
    
    private func sendOuput(_ event: OutputEvent) {
        _output.accept(event)
    }
    
    private func setState(_ state: State) {
        DispatchQueue.main.async { [weak self] in
            self?._state.accept(state)
        }
    }
}
