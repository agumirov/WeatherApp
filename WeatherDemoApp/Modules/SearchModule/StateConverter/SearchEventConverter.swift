//
//  SearchEventConverter.swift
//  WeatherDemoApp
//
//  Created by G G on 16.05.2023.
//

import Foundation

enum SearchStateConverter {
    static func convert(event: SearchViewModelState) -> SearchViewState {
        switch event {
        case .waitingForInput:
            return .initial
        case let .sucess(cities):
            return .loaded(cities: cities)
        case .failure(_):
            return .failure
        }
    }
}
