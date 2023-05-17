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
        var geoData: GeoModelDomain
    }
    
    init(input: Input,
         weatherRepository: WeatherRepository,
         weatherStorageManager: WeatherStorageManager
    ) {
        self.input = input
        self.weatherRepository = weatherRepository
        self.weatherStorageManager = weatherStorageManager
    }
    
    private func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelDomain {
        let task = Task {
            let data = try? await weatherRepository.getWeatherData(geoData: geoData)
            return data
        }
        guard let result = await task.value else { throw Errors.fetchDataError }
        return result
    }
    
//    private func checkStoredData() {
//
////        let storedData = StorageManager.shared.fetchData()
//
//        if storedData.isEmpty {
//            sendEvent(.searchSelected)
//        } else {
//
//            for data in storedData {
//                print(data)
//            }
//            guard let storedData = storedData.last else { return }
//            self.input = .init(geoData: storedData)
//            sendEvent(.viewDidLoad)
//        }
//    }
}

extension WeatherViewModelImpl {
    
    enum State {
        case fetchingData
        case sucess(WeatherModelDomain)
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
                    await MainActor.run {
                        setState(.sucess(weatherData))
                    }
                } catch let error {
                    setState(.failure(error))
                }
            }
        }
    }
    
    private func setState(_ state: State) {
        self._state.accept(state)
    }
}
