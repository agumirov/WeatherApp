//
//  WeekDayDomainModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation

class WeekModelDomain: NSObject, NSCoding {
    
    let weatherImage: String
    let day: Double
    let temperature: String
    let weekDay: String
    
    init(weather: WeatherData) {
        self.day = weather.dt
        self.weekDay = DateService.convertTimestampToStringDay(weather.dt)
        self.weatherImage = "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "10d").png"
        self.temperature = "\(Int(weather.main["temp"] ?? 0.0))°C"
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(weatherImage, forKey: "weatherImage")
        coder.encode(day, forKey: "day")
        coder.encode(temperature, forKey: "temperature")
        coder.encode(weekDay, forKey: "weekDay")
    }
    
    required init?(coder: NSCoder) {
        self.weatherImage = coder.decodeObject(forKey: "weatherImage") as? String ?? ""
        self.day = coder.decodeDouble(forKey: "day")
        self.temperature = coder.decodeObject(forKey: "temperature") as? String ?? ""
        self.weekDay = coder.decodeObject(forKey: "weekDay") as? String ?? ""
    }
}
