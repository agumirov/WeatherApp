//
//  RequestConfig.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

enum RequestConfig {
    
    case withParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?
    )
    
    case withParametersAndHeaders(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        headers: HTTPHeaders?
    )
}
