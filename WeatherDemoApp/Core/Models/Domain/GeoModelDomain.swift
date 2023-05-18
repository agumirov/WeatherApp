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

extension GeoModelDomain {
    init(from apiModel: GeoModelAPI) {
        self.name = apiModel.name
        self.country = apiModel.country
        self.latitude = apiModel.latitude
        self.longitude = apiModel.longitude
    }
    
    init(from coreDataModel: GeoModelCD) {
        self.name = coreDataModel.city
        self.country = coreDataModel.country
        self.latitude = Double(truncating: coreDataModel.latitude)
        self.longitude = Double(truncating: coreDataModel.longitude)
    }
}
