//
//  SearchScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

typealias SearchViewState = SearchViewController.State
typealias SearchViewEvent = SearchViewController.Event
typealias SearchViewModelState = SearchViewModelImpl.State
typealias SearchViewModelOutput = SearchViewModelImpl.OutputEvent

protocol SearchViewModel {
    var output: Observable<SearchViewModelOutput> { get }
    var state: Observable<SearchViewModelState> { get }
    func sendEvent(_ event: SearchViewEvent)
}
