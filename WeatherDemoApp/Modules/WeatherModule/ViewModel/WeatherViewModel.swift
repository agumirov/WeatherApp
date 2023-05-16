//
//  MainScreenViewModel1.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

typealias WeatherViewState = WeatherViewController.WeatherState
typealias WeatherViewEvent = WeatherViewController.WeatherEvent
typealias WeatherViewModelOutput = WeatherViewModelImpl.OutputEvents
typealias ViewModelState = WeatherViewModelImpl.State

protocol WeatherViewModel: AnyObject {
    var output: Observable<WeatherViewModelOutput> { get }
    var state: Observable<ViewModelState> { get }
    func sendEvent(_ event: WeatherViewEvent)
}
