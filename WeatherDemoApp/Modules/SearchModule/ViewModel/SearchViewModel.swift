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
typealias ViewModelInputEvents = SearchViewModelImpl.InputEvents
typealias ViewModelOutputEvents = SearchViewModelImpl.OutputEvents

protocol SearchViewModel {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}

protocol SearchViewModelInput {
    var event: PublishRelay<SearchViewEvent> { get set }
}

protocol SearchViewModelOutput {
    var state: BehaviorRelay<SearchViewState> { get set }
    var event: PublishRelay<ViewModelOutputEvents> { get set }
}
