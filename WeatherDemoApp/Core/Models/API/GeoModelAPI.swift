//
//  LocationModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation

struct GeoModelAPI: Codable, Equatable {
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

#if DEBUG
extension GeoModelAPI {
    static var mock: GeoModelAPI {
        .init(name: "London", latitude: 51.5073219, longitude: -0.1276474, country: "GB")
    }

    static func mock(name: String,
                     latitude: Double,
                     longitude: Double,
                     country: String
    ) -> GeoModelAPI {
        .init(name: name, latitude: latitude, longitude: longitude, country: country)
    }
}

extension Array where Element == GeoModelAPI {
    static var mock: GeoModelAPI {
        .init(name: "London", latitude: 51.5073219, longitude: -0.1276474, country: "GB")
    }
}
#endif
