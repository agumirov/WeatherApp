//
//  Encoder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

enum Encoder {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(
        urlParameters: Parameters?,
        jsonParameters: Parameters?,
        urlRequest: inout URLRequest
    ) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { throw  EncoderError.parametersNil}
                try URLEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let jsonParameters = jsonParameters else { throw  EncoderError.parametersNil}
                try JSONEncoder.encode(urlRequest: &urlRequest, with: jsonParameters)
                
            case .urlAndJsonEncoding:
                guard let urlParameters = urlParameters else { throw  EncoderError.parametersNil}
                guard let jsonParameters = jsonParameters else { throw  EncoderError.parametersNil}
                
                try URLEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONEncoder.encode(urlRequest: &urlRequest, with: jsonParameters)
            }
        } catch {
            throw EncoderError.encodingFailed
        }
    }
}

public enum EncoderError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
