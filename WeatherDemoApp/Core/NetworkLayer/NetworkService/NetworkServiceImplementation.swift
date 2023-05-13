//
//  NetworkServiceImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation

class NetworkServiceImplementation: NetworkService {
    
    func getGeoData(cityName: String) async throws -> [GeoModelAPI] {
        let data = try await makeRequest(request:
                                            GeoRequest(type: .cityName(cityName: cityName)))
        let model = try buildModel(data: data) as [GeoModelAPI]
        return model
    }
    
    func getWeatherData(geoData: GeoModelDomain) async throws -> WeatherModelAPI {
        let data = try await makeRequest(request: WeatherRequest(geoData: geoData))
        let model = try buildModel(data: data) as WeatherModelAPI
        return model
    }
}

extension NetworkServiceImplementation {
    
    private func makeRequest<Request: RequestType>(request: Request) async throws -> Data {
        
        guard let request = try? RequestBuilder<Request>
            .buildRequest(request: request)
        else { throw NetworkServiceErrors.badRequest }
        
        let task = URLSession.shared
        let response = try await task.data(for: request)
        
        return response.0
    }
    
    private func buildModel<T: Decodable>(data: Data) throws -> T {
        
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(T.self, from: data) else {
            throw NetworkServiceErrors.decodeFail
        }
        
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
