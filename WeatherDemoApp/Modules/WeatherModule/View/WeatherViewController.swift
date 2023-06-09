//
//  WeatherViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 04.05.2023.
//

import Foundation
import UIKit
import RxSwift

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: WeatherViewModel
    private let container = WeatherViewContainer()
    private let disposeBag = DisposeBag()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        bindViewModel()
        setupUI()
        viewModel.sendEvent(.viewDidLoad)
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(hexString: "#30A2C5").cgColor,
            UIColor(hexString: "#000000").cgColor
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        
        viewModel.state
            .subscribe(onNext: {[weak self] state in
                guard let self = self else { return }
                let viewState = WeatherStateConverter.convert(state: state)
                self.render(state: viewState)
            })
            .disposed(by: disposeBag)
        
        container.event
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .searchSelected:
                    self?.viewModel.sendEvent(.searchSelected)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Events
extension WeatherViewController {
    
    enum WeatherEvent {
        case searchSelected
        case viewDidLoad
    }
    
    enum WeatherState: Equatable {
        
        static func == (lhs: WeatherState, rhs: WeatherState) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial),
                 (.loading, .loading),
                 (.success, .success),
                 (.error, .error):
                return true
            default:
                return false
            }
        }
        
        case initial
        case loading
        case success(weatherModel: WeatherModelDomain,
                     date: String,
                     weekWeather: [WeekModelDomain])
        case error
    }
    
    func render(state: WeatherState) {
        switch state {
        case .loading:
            container.render(state: .loading)
        case let .success(weatherData, date, weekWeather):
            container.render(state: .success(weatherModel: weatherData,
                                             date: date,
                                             weekWeather: weekWeather))
        case .error:
            container.render(state: .error)
        case .initial:
            container.render(state: .initial)
        }
    }
}
