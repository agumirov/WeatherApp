//
//  EventConverter.swift
//  WeatherDemoApp
//
//  Created by G G on 16.05.2023.
//

import Foundation

enum WeatherStateConverter {
    static func convert(state: ViewModelState) -> WeatherViewState {
        switch state {
        case .fetchingData:
            return .loading
        case let .sucess(weatherData):
            return .success(weatherData)
        case .failure:
            return .error
        }
    }
}
