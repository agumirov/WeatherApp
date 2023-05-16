//
//  SearchModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit

enum SearchModuleBuilder {
    
    struct Dependencies {
        static let networkService: NetworkService = DIContainer.standart.resolve()
    }
    
    struct PayLoad {
        
    }
    
    static func buildSearchModule() -> (SearchViewController, SearchViewModel) {
        
        let geoRepository = GeoRepositoryImpl(networkService: Dependencies.networkService)
        
        let viewModel = SearchViewModelImpl(
            geoRepository: geoRepository
        )
        
        let view = SearchViewController(viewModel: viewModel)
        
        return (view, viewModel)
    }
}
