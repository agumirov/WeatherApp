//
//  SearchModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit

enum SearchModuleBuilder {
    
    static func buildSearchModule(
        coordinator: MainFlowCoordinator
    ) -> UIViewController {
        
        let geoRepository = GeoRepositoryImpl(networkService: DIContainer.standart.resolve())
        
        let viewModel = SearchViewModelImpl(
            coordinator: coordinator,
            geoRepository: geoRepository
        )
        
        let view = SearchViewController(viewModel: viewModel)
        
        return view
    }
}
