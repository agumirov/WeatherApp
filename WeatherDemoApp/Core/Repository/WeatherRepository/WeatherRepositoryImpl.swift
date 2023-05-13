//
//  WeatherRepositoryImpl.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

class WeatherRepositoryImpl: WeatherRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelDomain {
        let apiModel = try await networkService.getWeatherData(geoData: geoData)
        
        let date: String = {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            
            let date = Date(timeIntervalSince1970: apiModel.list.first?.dt ?? 0.0)
            let text = dateFormatter.string(from: date)
            return text
        }()
        
        let list: [WeekDayModelDomain] = {
            
            var weekDayData: [WeekDayModelDomain] = []
            var currentDate = NSDate.now
            let weatherList = apiModel.list
            
            for weekDay in weatherList {
                
                let calendar = Calendar.current
                let date = calendar.dateComponents([.day], from: Date(timeIntervalSince1970: weekDay.dt))
                let dateDay = date.day
                let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)
                let nextDay = calendar.dateComponents([.day], from: nextDayDate ?? .distantFuture).day
                
                if dateDay == nextDay {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEEE"
                    
                    weekDayData.append(WeekDayModelDomain(weather: weekDay))
                    currentDate = nextDayDate ?? .distantFuture
                }
            }
            return weekDayData
        }()
        
        let weatherModel = WeatherModelDomain(location: geoData,
                                              weather: apiModel,
                                              date: date,
                                              list: list)
        
        return weatherModel
    }
}
