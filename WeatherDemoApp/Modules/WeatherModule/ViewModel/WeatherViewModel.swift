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
typealias WeatherViewModelInputEvent = WeatherViewModelImpl.InputEvents
typealias WeatherViewModelOutputEvent = WeatherViewModelImpl.OutputEvents

protocol WeatherViewModel: AnyObject {
    var input: WeatherViewModelInput { get }
    var output: WeatherViewModelOuput { get }
}

protocol WeatherViewModelInput {
    var event: PublishRelay<WeatherViewEvent> { get set }
}

protocol WeatherViewModelOuput {
    var state: PublishRelay<WeatherViewState> { get set }
    var event: PublishRelay<WeatherViewModelOutputEvent> { get set }
}
