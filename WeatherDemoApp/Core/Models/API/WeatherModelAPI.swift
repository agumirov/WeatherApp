//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import CoreData

struct WeatherModelAPI: Codable {
    let list: [WeatherData]
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct WeatherData: Codable {
    let dt: Double
    let main: [String: Double]
    let weather: [Weather]
    let wind: [String: Double]
    let visibility: Double
}

#if DEBUG

extension WeatherModelAPI {
    static var mock: WeatherModelAPI {
        .init(list: [.mock, .mock, .mock])
    }
}

extension WeatherData {
    static var mock: WeatherData {
        .init(dt: 777, main: [:], weather: [], wind: [:], visibility: 777)
    }
}

#endif
