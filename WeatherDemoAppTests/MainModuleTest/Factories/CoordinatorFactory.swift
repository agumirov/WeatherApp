//
//  CoordinatorFactory.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
@testable import WeatherDemoApp


enum CoordinatorFactory {
    static func buildCoordinator() -> MainFlowCoordinator {
        let mainFlowNavigation = MainFlowNavigation()
        let coordinator = MainFlowCoordinator(navigationController: mainFlowNavigation)
        return coordinator
    }
}
