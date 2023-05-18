//
//  WeatherModelDomain.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

struct WeatherModelDomain {
    let list: [WeatherList]
    let icon: String
    let date: Double
    let temperature: Double
    let humidity: Double
    let pressure: Double
    let windspeed: Double
    let visibility: Double
    let name: String
    let country: String
}

extension WeatherModelDomain {
    init(
        location: GeoModelDomain,
        weather: WeatherModelAPI
    ) {
        self.icon = weather.list.first?.weather.first?.icon ?? "10d"
        self.date = weather.list.first?.dt ?? 0.0
        self.humidity = weather.list.first?.main["humidity"] ?? 0.0
        self.pressure = weather.list.first?.main["pressure"] ?? 0.0
        self.temperature = weather.list.first?.main["temp"] ?? 0.0
        self.windspeed = weather.list.first?.wind["speed"] ?? 0.0
        self.visibility = weather.list.first?.visibility ?? 0.0
        self.country = location.country
        self.name = location.name
        self.list = weather.list
    }
}
