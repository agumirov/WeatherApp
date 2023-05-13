//
//  Encoder.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

enum Encoder {
    
    case urlEncoding
    
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
