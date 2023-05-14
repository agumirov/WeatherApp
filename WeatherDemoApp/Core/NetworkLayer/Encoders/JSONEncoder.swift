//
//  JSONEncoder.swift
//  WeatherDemoApp
//
//  Created by G G on 14.05.2023.
//

import Foundation

enum JSONEncoder {
    
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw EncoderError.encodingFailed
        }
    }
}
