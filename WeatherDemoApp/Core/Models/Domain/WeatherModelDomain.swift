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
    init(location: GeoModelDomain, weather: WeatherModelAPI) {
        guard let firstWeatherData = weather.list.first else {
            fatalError("Weather data is empty.")
        }
        self.icon = firstWeatherData.weather.first?.icon ?? "10d"
        self.date = firstWeatherData.dt
        self.humidity = firstWeatherData.main["humidity"] ?? 0.0
        self.pressure = firstWeatherData.main["pressure"] ?? 0.0
        self.temperature = firstWeatherData.main["temp"] ?? 0.0
        self.windspeed = firstWeatherData.wind["speed"] ?? 0.0
        self.visibility = firstWeatherData.visibility
        self.country = location.country
        self.name = location.name
        self.list = weather.list
    }
}
