//
//  NetworkServiceImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation

class NetworkServiceImplementation {
    
    private func makeRequest<Request: RequestType, Model: Decodable>(request: Request) async throws -> Model {
        
        guard let request = try? RequestBuilder<Request>.buildRequest(request: request) else {
            throw NetworkServiceErrors.badRequest }
        
        let task = URLSession.shared
        let response = try await task.data(for: request)
        
        let decoder = JSONDecoder()
        let data = response.0
        guard let model = try? decoder.decode(Model.self, from: data) else {
            throw NetworkServiceErrors.decodeFail
        }
        
        return model
    }
}

extension NetworkServiceImplementation: NetworkService {
    func getGeoData(cityName: String) async throws -> [GeoModelAPI] {
        let model = try await makeRequest(request: GeoRequest(type: .cityName(cityName: cityName))) as [GeoModelAPI]
        return model
    }
    
    func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelAPI {
        let model = try await makeRequest(request: WeatherRequest(geoData: geoData)) as WeatherModelAPI
        return model
    }
}

enum NetworkServiceErrors: String, Error {
    case badRequest = "Request is nil or unavailable"
    case badData = "Data is empty"
    case locationIsNil = "Location is nil or empty"
    case emptyWeatherModel = "weather model is empty or nil"
    case decodeFail = "decoding from data failed"
}
