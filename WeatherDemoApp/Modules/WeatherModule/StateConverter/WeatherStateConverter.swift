//
//  EventConverter.swift
//  WeatherDemoApp
//
//  Created by G G on 16.05.2023.
//

import Foundation

enum WeatherStateConverter {
    static func convert(state: WeatherViewModelState) -> WeatherViewState {
        switch state {
        case .fetchingData:
            return .loading
        case let .success(weatherData, date, weekWeather):
            return .success(weatherModel: weatherData, date: date, weekWeather: weekWeather)
        case .failure:
            return .error
        }
    }
}
