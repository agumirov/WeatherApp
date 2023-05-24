//
//  RepositoryTests.swift
//  WeatherDemoAppTests
//
//  Created by G G on 24.05.2023.
//

import Foundation

import XCTest
@testable import WeatherDemoApp

class RepositoryTests: XCTestCase {
    
    func testRepository() async {
        let expectation = ["weather requested", "data saved"]
        let repository = makeRepository { result in
            XCTAssertEqual(expectation, result)
        }
        _ = try? await repository.getWeatherData(geoData: .mock)
    }
}

extension RepositoryTests {
    func makeRepository(completion: @escaping ([String]) -> Void ) -> WeatherRepository {
        var result: [String] = []
        let networkService = MockNetworkService(geoCompletion: {
            result.append("geo requested")
        }, weatherCompletion: {
            result.append("weather requested")
        })
        
        let storageManager = MockStorageManager {
            result.append("data saved")
            completion(result)
        } fetchDataCompletion: {
            result.append("data fetched")
            completion(result)
        }
        
        let repository = WeatherRepositoryImpl(networkService: networkService,
                                               weatherStorageManager: storageManager)
        return repository
    }
}
