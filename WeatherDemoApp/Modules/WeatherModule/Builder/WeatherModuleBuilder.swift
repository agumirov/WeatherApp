//
//  WeatherModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit

enum WeatherModuleBuilder {
    
    static func buildWeatherModule(
        geoData: GeoModelDomain
    ) -> (WeatherViewController, WeatherViewModel) {
        let weatherRepository = WeatherRepositoryImpl(networkService:
                                                        DIContainer.standart.resolve())
        
        let viewModel = WeatherViewModelImpl(
            geoData: geoData,
            weatherRepository: weatherRepository
        )
        
        let view = WeatherViewController(viewModel: viewModel)
        
        return (view, viewModel)
    }
}
