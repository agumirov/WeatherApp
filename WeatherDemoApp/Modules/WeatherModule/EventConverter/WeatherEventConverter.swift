//
//  EventConverter.swift
//  WeatherDemoApp
//
//  Created by G G on 16.05.2023.
//

import Foundation

enum WeatherEventConverter {
    static func convert(event: WeatherViewEvent) -> WeatherViewModelInputEvent {
        switch event {
        case .showWeather:
            return .fetchWeatherData
        case .searchSelected:
            return .routeToSearch
        }
    }
}
