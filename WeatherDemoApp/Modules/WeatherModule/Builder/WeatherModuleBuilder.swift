//
//  WeatherModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit
import RxSwift

typealias WeatherModule = (view: WeatherViewController, output: Observable<WeatherViewModelOutput>)

enum WeatherModuleBuilder {
    
    struct Dependencies {
        let networkService: NetworkService
        let weatherStorageManager: WeatherStorageManager
    }
    
    struct Payload {
        let geoData: GeoModelDomain?
    }
    
    static func buildWeatherModule(payLoad: Payload, dependencies: Dependencies) -> WeatherModule {
        let weatherRepository = WeatherRepositoryImpl(
            networkService: dependencies.networkService,
            weatherStorageManager: dependencies.weatherStorageManager
        )
        
        let viewModel = WeatherViewModelImpl(
            input: .init(geoData: payLoad.geoData),
            weatherRepository: weatherRepository
        )
        
        let view = WeatherViewController(viewModel: viewModel)
        return WeatherModule(view, viewModel.output)
    }
}
