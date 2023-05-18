//
//  FlowFactory.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

protocol FlowFactory {
    func startMainFlow(isStoredDataAvailable: Bool) -> UIViewController
}
