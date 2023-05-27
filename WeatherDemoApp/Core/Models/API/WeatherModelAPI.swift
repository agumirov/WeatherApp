//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import CoreData

struct WeatherModelAPI: Codable, Equatable {
    static func == (lhs: WeatherModelAPI, rhs: WeatherModelAPI) -> Bool {
        return lhs.list == rhs.list
    }
    
    let list: [WeatherData]
}

struct Weather: Codable, Equatable {
    let description: String
    let icon: String
}

struct WeatherData: Codable, Equatable {
    let dt: Double
    let main: [String: Double]
    let weather: [Weather]
    let wind: [String: Double]
    let visibility: Double
    
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
            return lhs.dt == rhs.dt &&
                   lhs.main == rhs.main &&
                   lhs.weather == rhs.weather &&
                   lhs.wind == rhs.wind &&
                   lhs.visibility == rhs.visibility
    }
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
