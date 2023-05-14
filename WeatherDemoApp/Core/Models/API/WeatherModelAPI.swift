//
//  WeatherModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import CoreData

struct WeatherModelAPI: Codable {
    let list: [WeatherList]
}

struct Weather: Codable {
    let description: String
    let icon: String
}

class WeatherList: NSObject, Codable {
    let dt: Double
    let main: [String: Double]
    let weather: [Weather]
    let wind: [String: Double]
    let visibility: Double
}
