//
//  ViewModelTests.swift
//  WeatherDemoAppTests
//
//  Created by G G on 24.05.2023.
//

import Foundation

import XCTest
import RxSwift
import RxCocoa
@testable import WeatherDemoApp

class WeatherViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testViewModelSuccessState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a success state")
        let data = WeatherModelDomain.mock
        let viewModel = makeViewModelWithStateObserver(withError: false) { state in
            switch state {
            case .fetchingData:
                break
            case let .success(weatherModel, _, _):
                XCTAssertEqual(weatherModel, data)
                expectation.fulfill()
            case .failure(_):
                XCTFail("ViewModel reached failure state")
            }
        }
        viewModel.sendEvent(.viewDidLoad)
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelFailureState() {
        let expectation = XCTestExpectation(description: "The ViewModel should reach a failure state")
        let viewModel = makeViewModelWithStateObserver(withError: true) { state in
            switch state {
            case .fetchingData:
                break
            case .success:
                XCTFail("ViewModel reached success state")
            case .failure(_):
                expectation.fulfill()
            }
        }
        viewModel.sendEvent(.viewDidLoad)
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelOuput() {
        let expectation = WeatherViewModelOutput.showSearchScreen
        let viewModel = makeViewModelWithOutputObserver(withError: false) { ouput in
            XCTAssertEqual(expectation, ouput)
        }
        viewModel.sendEvent(.searchSelected)
    }
}

extension WeatherViewModelTests {
    func makeViewModelWithStateObserver(
        withError: Bool,
        completion: @escaping (WeatherViewModelState) -> Void
    ) -> WeatherViewModel {
        let viewModel: WeatherViewModel = WeatherViewModelImpl(
            input: .init(geoData: .mock),
            weatherRepository: MockWeatherRepository(withError: withError)
        )
        viewModel.state
            .subscribe (onNext: { state in
                completion(state)
            })
            .disposed(by: disposeBag)
        
        return viewModel
    }
    
    func makeViewModelWithOutputObserver(
        withError: Bool,
        completion: @escaping (WeatherViewModelOutput) -> Void
    ) -> WeatherViewModel {
        let viewModel: WeatherViewModel = WeatherViewModelImpl(
            input: .init(geoData: .mock),
            weatherRepository: MockWeatherRepository(withError: withError)
        )
        viewModel.output
            .subscribe (onNext: { output in
                completion(output)
            })
            .disposed(by: disposeBag)
        
        return viewModel
    }
}
