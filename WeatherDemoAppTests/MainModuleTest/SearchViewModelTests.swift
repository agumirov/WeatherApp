//
//  SearchViewModelTest.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
import UIKit
import RxSwift
import XCTest
@testable import WeatherDemoApp

class SearchViewModelTests: XCTest {
    
    private let viewModel = SearchViewModelBuilder.buildViewModel()
    private let disposeBag = DisposeBag()
    
    func testSearchViewModelOutput() {
        let repository = RepositoryFactory.buildGeoRepository()
        let viewModel = SearchViewModelImpl(geoRepository: repository)
        let mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                         country: "FR",
                                         latitude: 43.0226905,
                                         longitude: -0.4126314)
        var output: SearchViewModelOutput = .abortSearch
        var outputEvent: SearchViewModelOutput?
        viewModel.output
            .subscribe(onNext: { event in
                outputEvent = event
            })
            .disposed(by: disposeBag)
        
        viewModel.sendEvent(.cancelSearch)
        XCTAssertEqual(output, outputEvent)
        
        viewModel.sendEvent(.showWeather(geoData: mockGeoData))
        output = .routeToWeatherModule(mockGeoData)
        XCTAssertEqual(output, outputEvent)
    }
    
    func testSearchViewModelSuccessState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a success state")
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .waitingForInput:
                    print("==================== \(state) ====================")
                case let .sucess(cities):
                    XCTAssertNotNil(cities, "cities was nil in a success state")
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("ViewModel reached a failure state")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.sendEvent(.showCities(value: "London"))
    }
    
    func testSearchViewModelErrorState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a failure state")
        let viewModel = SearchViewModelBuilder.buildViewModel()
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .waitingForInput:
                    print("==================== \(state) ====================")
                case .sucess(_):
                    XCTFail("ViewModel reached a success state")
                case .failure(_):
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.sendEvent(.showCities(value: "London"))
    }
}
