//
//  Request.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 09.05.2023.
//

import Foundation

protocol RequestType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var config: RequestConfig { get }
}
