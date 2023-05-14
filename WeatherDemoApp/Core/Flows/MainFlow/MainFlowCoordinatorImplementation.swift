//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class MainFlowCoordinatorImplementation<N>: AppCoordinator<N> where N: MainFlowNavigation {
    
    private let disposeBag = DisposeBag()
    
    override init(navigationController: N) {
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        let storedData = StoreManager.shared.fetchData()
        
        if storedData.isEmpty {
            showSearchScreen()
        } else {
            
            for data in storedData {
                print(data)
            }
            guard let storedData = storedData.last else { return }
            showWeatherScreen(geoData: GeoModelDomain(name: storedData.city ?? "",
                                                      country: storedData.country ?? "",
                                                      latitude: storedData.latitude as! Double,
                                                      longitude: storedData.longitude as! Double))
        }
    }
}

extension MainFlowCoordinatorImplementation: MainFlowCoordinator {
    
    //    func finish
    //    showMainScreen
    func showWeatherScreen(geoData: GeoModelDomain) {
        
        let view = WeatherModuleBuilder.buildWeatherModule(
            geoData: geoData,
            coordinator: self
        )
        
        navigationController?.viewControllers = [view]
    }
    
    func showSearchScreen() {
        let view = SearchModuleBuilder.buildSearchModule(coordinator: self)
        navigationController?.pushViewController(view, animated: false)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
