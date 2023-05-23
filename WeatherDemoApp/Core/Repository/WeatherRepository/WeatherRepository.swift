//
//  WeatherRepository.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

protocol WeatherRepository {
    func getWeatherDataFromStorage() async throws -> WeatherModelDomain
    func getWeatherDataFromNetwork(geoData: GeoModelDomain?) async throws -> WeatherModelDomain
}
