//
//  GeoModelDomain.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 11.05.2023.
//

import Foundation

struct GeoModelDomain: Codable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}

extension GeoModelDomain: Equatable {
    init(from apiModel: GeoModelAPI) {
        self.name = apiModel.name
        self.country = apiModel.country
        self.latitude = apiModel.latitude
        self.longitude = apiModel.longitude
    }
}

#if DEBUG
extension GeoModelDomain {
    static var mock: GeoModelDomain {
        .init(name: "Mock", country: "Mock", latitude: 0.0, longitude: 0.0)
    }
    
    static func mock(name: String,
                     latitude: Double,
                     longitude: Double,
                     country: String
    ) -> GeoModelDomain {
        .init(name: "Mock", country: "Mock", latitude: 0.0, longitude: 0.0)
    }
}
#endif
