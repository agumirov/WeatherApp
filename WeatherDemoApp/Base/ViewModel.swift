//
//  ViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol ViewModel: AnyObject {
    
    associatedtype CoordinatorType
    var coordinator: CoordinatorType { get set }
}
