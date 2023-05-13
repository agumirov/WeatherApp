//
//  GeoRequest.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation


struct GeoRequest: RequestType {
    
    enum GeoRequestType {
        case cityName(cityName: String)
        case zipCode(code: Double)
    }
    
    var type: GeoRequestType
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org")
        else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch type {
        case .cityName:
            return "geo/1.0/direct"
        case .zipCode:
            return "/geo/1.0/zip"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var config: RequestConfig {
        switch type {
            
        case let .cityName(cityName):
            return .withParameters(
                bodyParameters: nil,
                urlParameters: [
                    "q": cityName,
                    "appid": APIKey.key,
                    "limit": 5
                ])
            
        case let .zipCode(code):
            return .withParameters(
                bodyParameters: nil,
                urlParameters: [
                    "zip": code,
                    "appid": APIKey.key,
                    "limit": 5
                ])
        }
    }
    
    init(type: GeoRequestType) {
        self.type = type
    }
}
