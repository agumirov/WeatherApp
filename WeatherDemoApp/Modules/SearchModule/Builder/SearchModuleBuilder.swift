//
//  SearchModuleBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit
import RxSwift

typealias SearchModule = (view: SearchViewController, output: Observable<SearchViewModelOutput>)

enum SearchModuleBuilder {
    
    struct Dependencies {
        let networkService: NetworkService
    }
    
    struct PayLoad {}
    
    static func buildSearchModule(dependencies: Dependencies,
                                  payload: PayLoad) -> SearchModule {
        
        let geoRepository = GeoRepositoryImpl(networkService: dependencies.networkService)
        
        let viewModel = SearchViewModelImpl(
            geoRepository: geoRepository
        )
        
        let view = SearchViewController(viewModel: viewModel)
        
        return (view: view, output: viewModel.output)
    }
}
