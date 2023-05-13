//
//  WeekDayDomainModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

struct WeekDayModelDomain {
    let weatherImage: String
    let day: String
    let temperature: String
}

extension WeekDayModelDomain {
    init(weather: WeatherList) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.day = "\(dateFormatter.string(from: Date(timeIntervalSince1970: weather.dt)))"
        self.weatherImage = "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "10d").png"
        self.temperature = "\(Int(weather.main["temp"] ?? 0.0))°C"
    }
}
