//
//  SearchViewModelFactory.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
@testable import WeatherDemoApp

enum SearchViewModelBuilder {
    static func buildViewModel() -> SearchViewModel {
        let repository = RepositoryFactory.buildGeoRepository()
        let viewModel = SearchViewModelImpl(geoRepository: repository)
        return viewModel
    }
}
