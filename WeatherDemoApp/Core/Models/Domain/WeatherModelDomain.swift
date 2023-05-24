//
//  WeatherModelDomain.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

struct WeatherModelDomain: Equatable {
    let list: [WeekModelDomain]
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
        self.list = weather.list.compactMap { WeekModelDomain(weather: $0) }
    }
    
    init(coreDataModel: WeatherModelCD) {
        self.list = coreDataModel.list.compactMap { $0 as? WeekModelDomain }
        self.icon = coreDataModel.icon
        self.date = coreDataModel.date
        self.temperature = coreDataModel.temperature
        self.humidity = coreDataModel.humidity
        self.pressure = coreDataModel.pressure
        self.windspeed = coreDataModel.windspeed
        self.visibility = coreDataModel.visibility
        self.name = coreDataModel.city
        self.country = coreDataModel.country
    }
}

#if DEBUG
extension WeatherModelDomain {
    static var mock: WeatherModelDomain {
        .init(
            list: [], icon: "",
            date: 0, temperature: 0,
            humidity: 0, pressure: 0,
            windspeed: 0, visibility: 0,
            name: "Mock", country: "Mock"
        )
    }
    
//    static func mock(
//        list:  [WeekModelDomain] = [] , icon: String,
//        date: Double, temperature: Double,
//        humidity: Double, pressure: Double,
//        windspeed: Double, visibility: Double,
//        name: String, country: String
//    ) -> WeatherModelDomain {
//        .init(list: list, icon: icon,
//              date: date, temperature: temperature,
//              humidity: humidity, pressure: pressure,
//              windspeed: windspeed, visibility: visibility,
//              name: name, country: country)
//    }
}
#endif
