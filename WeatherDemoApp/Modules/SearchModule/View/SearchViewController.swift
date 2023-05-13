//
//  DetailViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel
     
    private let container = SearchViewContainer()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindState()
        setupGradient()
    }
    
    private func setupUI() {
        
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindState() {
        
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
                case let .citySelected(geoData):
                    self.viewModel.handleEvent(event: .showWeather(geoData: geoData))
                case let .showCityList(value):
                    self.viewModel.handleEvent(event: .showCities(value: value))
                case .cancelSearch:
                    self.viewModel.handleEvent(event: .pop)
                }
            })
            .disposed(by: disposeBag)
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
}

extension SearchViewController {
    
    func render(state: State) {
        switch state {
        case .initial:
            container.render(state: state)
        case let .loaded(cities):
            container.render(state: .loaded(cities: cities))
        case .loading:
            container.render(state: state)
        case .failure:
            container.render(state: state)
        }
    }
    
    enum State {
        case initial
        case loaded(cities: [GeoModelDomain])
        case loading
        case failure
    }
    
    enum Event {
        case showWeather(geoData: GeoModelDomain)
        case showCities(value: String)
        case pop
    }
}
