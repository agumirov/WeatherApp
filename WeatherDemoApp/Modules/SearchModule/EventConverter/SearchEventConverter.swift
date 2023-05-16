//
//  SearchEventConverter.swift
//  WeatherDemoApp
//
//  Created by G G on 16.05.2023.
//

import Foundation

enum SearchEventConverter {
    static func convert(event: SearchViewEvent) -> ViewModelInputEvents {
        switch event {
        case let .showWeather(geoData):
            return .showFullWeatherData(geoData: geoData)
        case let .showCities(value):
            return .fetchData(cityName: value)
        case .cancelSearch:
            return .cancelSearchIfPossible
        }
    }
}
