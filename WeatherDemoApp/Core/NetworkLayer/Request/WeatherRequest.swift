//
//  WeatherRequest.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

struct WeatherRequest: RequestType {
    
    let geoData: GeoModelDomain
    let httpMethod: HTTPMethod = .get
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org")
        else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    let path: String = "data/2.5/forecast"
    
    var config: RequestConfig {
        return .withParameters(
            bodyParameters: nil,
            urlParameters: [
                "lat": geoData.latitude,
                "lon": geoData.longitude,
                "units": "metric",
                "appid": APIKey.key,
                "limit": 5
            ]
        )
    }
    
    init(geoData: GeoModelDomain) {
        self.geoData = geoData
    }
}
