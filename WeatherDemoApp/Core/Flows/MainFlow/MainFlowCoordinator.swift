//
//  MainCoordinatorProtocol.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainFlowCoordinator: Coordinator {
//
    func showWeatherScreen(geoData: GeoModelDomain)
    
    func showSearchScreen()
    
    func pop()
}
