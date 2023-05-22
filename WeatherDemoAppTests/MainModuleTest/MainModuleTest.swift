//
//  MainModuleTest.swift
//  WeatherDemoAppTests
//
//  Created by G G on 19.05.2023.
//

import XCTest
@testable import WeatherDemoApp

import UIKit
import RxSwift

class MainModuleTest: XCTestCase {
    
    var viewModel: WeatherViewModel!
    var weatherView: WeatherViewController!
    var coordinator: MainFlowCoordinator<MainFlowNavigation>!
    var repository: WeatherRepository!
    var storageManager: WeatherStorageManager!
    var mockNetworkService: NetworkService!
    var mainFlowNavigation: MainFlowNavigation!
    var disposeBag: DisposeBag!
    var mockGeoData: GeoModelDomain!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                     country: "FR",
                                     latitude: 43.0226905,
                                     longitude: -0.4126314)
        
        storageManager = WeatherStorageManagerImpl()
        mainFlowNavigation = MainFlowNavigation()
        mockNetworkService = MockNetworkService()
        repository = WeatherRepositoryImpl(networkService: mockNetworkService,
                                           weatherStorageManager: storageManager)
        
        coordinator = MainFlowCoordinator(navigationController: mainFlowNavigation)
        
        viewModel = WeatherViewModelImpl(
            input: .init(geoData: mockGeoData),
            weatherRepository: repository,
            weatherStorageManager: storageManager
        )
        weatherView = WeatherViewController(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        disposeBag = nil
        mockGeoData = nil
        storageManager = nil
        mainFlowNavigation = nil
        mockNetworkService = nil
        repository = nil
        coordinator = nil
        viewModel = nil
        weatherView = nil
    }
    
    func testAPICalls() async {
        let modelAPI = try? await mockNetworkService.getWeatherData(geoData: mockGeoData)
        XCTAssertNotNil(modelAPI)
    }
    
    func testCoreDataSave() async {
        let weatherModel = try? await repository.getWeatherData(geoData: mockGeoData)
        let storedData = GeoModelDomain(from: storageManager.fetchData().last!)
        let weatherModelNil = try? await repository.getWeatherData(geoData: nil)
        XCTAssertEqual(weatherModel?.name, mockGeoData.name)
        XCTAssertEqual(mockGeoData.name, storedData.name)
        XCTAssertEqual(weatherModel?.name, storedData.name)
        XCTAssertEqual(weatherModelNil?.name, storedData.name)
    }
    
    func testViewModelOutput() {
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
    
    func testCoordinator() {
        coordinator.start(isStoredDataAvailable: false)
        XCTAssert(mainFlowNavigation.visibleViewController is SearchViewController)
        
        coordinator.start(isStoredDataAvailable: true)
        XCTAssert(mainFlowNavigation.visibleViewController is WeatherViewController)
    }
    
    func testViewModelSuccess() {
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
    
    func testConvertTimestampToFullStringDate() {
        // Arrange
        let timestamp = 1634619600.0 // This is "Tuesday, October 19, 2021" in GMT.
        let expectedDateString = "вторник, 19 октября 2021 г."
        // Force the date formatter to use US English style.
        DateService.dateFormatter.locale = Locale(identifier: "en_US")

        // Act
        let dateString = DateService.convertTimestampToFullStringDate(timestamp)

        // Assert
        XCTAssertEqual(dateString, expectedDateString, "Expected date string to be \(expectedDateString) but got \(dateString).")
    }
}
