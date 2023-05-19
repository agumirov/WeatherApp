//
//  MainModuleTest.swift
//  WeatherDemoAppTests
//
//  Created by G G on 19.05.2023.
//

import XCTest
import RxSwift
@testable import WeatherDemoApp

final class MainModuleTest: XCTestCase {

    var viewModel: WeatherViewModel!
    var view: WeatherViewController!
    var coordinator: MainFlowCoordinator<MainFlowNavigation>!
    var mockModelDomain: WeatherModelDomain!
    var repository: WeatherRepository!
    var storageManager: WeatherStorageManager!
    var networkService: NetworkService!
    var mainFlowNavigation: MainFlowNavigation!
    var disposeBag: DisposeBag!
    var mockGeoData: GeoModelDomain!
    var weatherRepository: WeatherRepository!
    
    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        mockGeoData = GeoModelDomain(name: "Aste-Béon",
                                     country: "FR",
                                     latitude: 43.0226905,
                                     longitude: -0.4126314)
        
        networkService = NetworkServiceImplementation()
        storageManager = WeatherStorageManagerImpl()
        mainFlowNavigation = MainFlowNavigation()
        
        repository = WeatherRepositoryImpl(networkService: networkService,
                                           weatherStorageManager: storageManager)
        
        coordinator = MainFlowCoordinator(navigationController: mainFlowNavigation)
        
        viewModel = WeatherViewModelImpl(
            input: .init(geoData: mockGeoData),
            weatherRepository: repository,
            weatherStorageManager: storageManager
        )
        view = WeatherViewController(viewModel: viewModel)
        weatherRepository = WeatherRepositoryImpl(networkService: networkService,
                                                  weatherStorageManager: storageManager)
    }

    override func tearDownWithError() throws {
        networkService = nil
        storageManager = nil
        mainFlowNavigation = nil
        repository = nil
        coordinator = nil
        viewModel = nil
        view = nil
    }

    func testAPICalls() async {
        var modelAPI: WeatherModelAPI?
        modelAPI = try? await self.networkService.getWeatherData(geoData: self.mockGeoData)
        XCTAssertNotNil(modelAPI)
    }
    
    func testCoreDataSave() async {
        let _ = try? await weatherRepository.getWeatherData(geoData: mockGeoData)
        let storedData = GeoModelDomain(from: storageManager.fetchData().last!)
        XCTAssertEqual(mockGeoData, storedData)
    }
    
    func testViewModelOutput() {
        let output: WeatherViewModelOutput = .showSearchScreen
        var outputEvent: WeatherViewModelOutput?
        viewModel.output
            .subscribe { event in
                outputEvent = event
            }
            .disposed(by: disposeBag)
        XCTAssertEqual(output, outputEvent)
    }
    
    func testViewModelSuccessState() {
        viewModel.state
            .subscribe(onNext: { state in
                switch state {
                case .fetchingData:
                    print(state)
                case let .sucess(weatherModel, date, weekWeather):
                    print(weatherModel)
                case .failure(_):
                    print(state)
                }
            })
            .disposed(by: disposeBag)
        viewModel.sendEvent(.viewDidLoad)
        wait(for: [], timeout: 10)
    }
}
