//
//  WeatherViewModelTest.swift
//  WeatherDemoAppTests
//
//  Created by G G on 23.05.2023.
//

import Foundation
import UIKit
import RxSwift
import XCTest
@testable import WeatherDemoApp

class WeatherViewModelTests: XCTestCase {
    
    private let viewModel = WeatherViewModelBuilder.buildViewModel()
    private let disposeBag = DisposeBag()
    
    func testViewModelOutput() {
        let viewModel = WeatherViewModelBuilder.buildViewModel()
        let output: WeatherViewModelOutput = .showSearchScreen
        var outputEvent: WeatherViewModelOutput?
        viewModel.output
            .subscribe(onNext: { event in
                outputEvent = event
            })
            .disposed(by: disposeBag)
        viewModel.sendEvent(.searchSelected)
        XCTAssertEqual(output, outputEvent)
    }
    
    func testViewModelSuccessState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a success state")
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .fetchingData:
                    print("==================== \(state) ====================")
                case let .success(weatherModel, date, weekWeather):
                    XCTAssertNotNil(weatherModel, "weatherModel was nil in a success state")
                    XCTAssertNotNil(date, "date was nil in a success state")
                    XCTAssertNotNil(weekWeather, "weekWeather was nil in a success state")
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("ViewModel reached a failure state")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.sendEvent(.viewDidLoad)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewModelErrorState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a failure state")
        let viewModel = WeatherViewModelBuilder.buildViewModelWithMockRepo()
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .fetchingData:
                    print("==================== \(state) ====================")
                case .success(_, _, _):
                    XCTFail("ViewModel reached a sucess state")
                case .failure(_):
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.sendEvent(.viewDidLoad)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
