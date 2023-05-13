//
//  GeoRepository.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

protocol GeoRepository: AnyObject {
    func getGeoData(cityName: String) async throws -> [GeoModelDomain]
}
