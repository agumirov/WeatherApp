//
//  WeatherRepository.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

protocol WeatherRepository {
    func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelDomain
}
