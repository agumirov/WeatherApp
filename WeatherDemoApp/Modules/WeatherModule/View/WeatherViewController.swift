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
    
    var viewModel: WeatherViewModel
    
    private let container = WeatherViewContainer()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        bindViewModel()
        setupUI()
        viewModel.handleEvent(event: .showWeather)
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
    
    
    private func setupUI() {
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.state
            .asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                self.render(state: state)
            })
            .disposed(by: disposeBag)
        
        container.event
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .searchSelected:
                    self.viewModel.handleEvent(event: .searchSelected)
                case .none:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

extension WeatherViewController {
    
    enum WeatherEvent {
        case searchSelected
        case showWeather
    }
    
    enum WeatherState {
        case initial
        case loading
        case success
        case error
    }
    
    func render(state: WeatherState) {
        switch state {
        case .loading:
            container.render(state: .loading)
        case .success:
            guard let data = viewModel.weatherData else { return }
            container.render(state: .success(data))
        case .error:
            container.render(state: .error)
        case .initial:
            container.render(state: .initial)
        }
    }
}
