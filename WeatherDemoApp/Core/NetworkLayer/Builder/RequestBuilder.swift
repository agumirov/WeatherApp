//
//  RequestBuilder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

enum RequestBuilder<Request: RequestType> {
    
    static func buildRequest(request: Request) throws -> URLRequest {
        var configuredRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                           cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        configuredRequest.httpMethod = request.httpMethod.rawValue
        
        do {
            switch request.config {
                
            case let .withParameters(bodyParameters, urlParameters):
                try self.configParameters(
                    bodyParameters: bodyParameters,
                    urlParameters: urlParameters,
                    encoder: .urlEncoding,
                    urlRequest: &configuredRequest
                )
                
            case let .withParametersAndHeaders(bodyParameters, urlParameters, headers):
                try self.configParameters(
                    bodyParameters: bodyParameters,
                    urlParameters: urlParameters,
                    encoder: .urlEncoding,
                    urlRequest: &configuredRequest
                )
                additionalHeader(
                    additionalHeaders: headers,
                    urlRequest: &configuredRequest
                )
            }
            return configuredRequest
        } catch {
            throw error
        }
    }
    
    
    private static func configParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        encoder: Encoder,
        urlRequest: inout URLRequest
    ) throws {
        do {
            try encoder.encode(
                urlParameters: urlParameters,
                jsonParameters: bodyParameters,
                urlRequest: &urlRequest
            )
        } catch {
            throw error
        }
    }
    
    private static func additionalHeader(
        additionalHeaders: HTTPHeaders?,
        urlRequest: inout URLRequest
    ) {
        guard let headers = additionalHeaders else { return }
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
