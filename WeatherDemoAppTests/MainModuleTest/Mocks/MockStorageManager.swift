//
//  MockStorageManager.swift
//  WeatherDemoAppTests
//
//  Created by G G on 24.05.2023.
//

import Foundation
@testable import WeatherDemoApp

typealias SaveDataCompletion = () -> Void
typealias FetchDataCompletion = () -> Void

class MockStorageManager: WeatherStorageManager {
    
    let saveDataCompletion: SaveDataCompletion
    let fetchDataCompletion: FetchDataCompletion
    
    init(saveDataCompletion: @escaping SaveDataCompletion,
         fetchDataCompletion: @escaping FetchDataCompletion
    ) {
        self.saveDataCompletion = saveDataCompletion
        self.fetchDataCompletion = fetchDataCompletion
    }
    
    func saveData(weatherModel: WeatherDemoApp.WeatherModelDomain) throws {
        saveDataCompletion()
    }
    
    func fetchData() throws -> [WeatherDemoApp.WeatherModelCD] {
        fetchDataCompletion()
        return .init()
    }
}
