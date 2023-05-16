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
    
    var input: SearchViewModelInput
    var output: SearchViewModelOutput
    
    struct Input: SearchViewModelInput {
        var event = PublishRelay<SearchViewEvent>()
    }
    
    struct Output: SearchViewModelOutput {
        var state = BehaviorRelay<SearchViewState>(value: .initial)
        var event = PublishRelay<ViewModelOutputEvents>()
    }
    
    private var geoRepository: GeoRepository
    private var disposeBag = DisposeBag()
    
    init(geoRepository: GeoRepository) {
        self.geoRepository = geoRepository
        self.input = Input()
        self.output = Output()
        bindInputs()
    }
    
    private func bindInputs() {
        self.input.event
            .asObservable()
            .subscribe { [weak self] event in
                let event = SearchEventConverter.convert(event: event)
                self?.handleEvent(event: event)
            }
            .disposed(by: disposeBag)
    }
    
    private func searchCall(cityName: String) async throws -> [GeoModelDomain] {
        
        let task = Task {
            let cities = try? await geoRepository.getGeoData(cityName: cityName)
            return cities
        }
        
        guard let result = await task.value else { throw Errors.fetchDataError }
        return result
    }
}

extension SearchViewModelImpl {
    
    enum InputEvents {
        case fetchData(cityName: String)
        case showFetchResult([GeoModelDomain])
        case showFullWeatherData(geoData: GeoModelDomain)
        case cancelSearchIfPossible
    }
    
    enum OutputEvents {
        case routeToWeatherModule(GeoModelDomain)
        case abortSearch
    }
    
    enum Errors: String, Error {
        case fetchDataError = "Fetched data is nil"
    }
    
    func handleEvent(event: InputEvents) {
        
        switch event {
        case let .fetchData(cityName):
            Task {
                let result = try await searchCall(cityName: cityName)
                await MainActor.run {
                    handleEvent(event: .showFetchResult(result))
                }
            }
            
        case let .showFetchResult(cities):
            setState(.loaded(cities: cities))
            
        case let .showFullWeatherData(geoData):
            sendOuputEvent(.routeToWeatherModule(geoData))
            setState(.initial)
            
        case .cancelSearchIfPossible:
            sendOuputEvent(.abortSearch)
            setState(.initial)
        }
    }
    
    private func sendOuputEvent(_ event: OutputEvents) {
        self.output.event.accept(event)
    }
    
    private func setState(_ state: SearchViewState) {
        self.output.state.accept(state)
    }
}
