//
//  LocationModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation

struct GeoModelAPI: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
        case country
    }
}
