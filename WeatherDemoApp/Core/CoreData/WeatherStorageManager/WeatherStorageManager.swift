//
//  WeatherStorageManager.swift
//  WeatherDemoApp
//
//  Created by G G on 17.05.2023.
//

import Foundation

protocol WeatherStorageManager {
    func saveData(weatherModel: WeatherModelDomain)
    func fetchData() -> [WeatherModelCD]
}
