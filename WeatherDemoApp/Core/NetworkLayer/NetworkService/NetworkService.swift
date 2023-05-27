//
//  NetworkService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation


protocol NetworkService: AnyObject {
    func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelAPI
    func getGeoData(cityName: String) async throws -> [GeoModelAPI]
}
