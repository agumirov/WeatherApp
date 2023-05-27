//
//  WeatherErrorView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 04.05.2023.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class WeatherErrorView: UIView {
    
    // MARK: - Properties
    private var _event = PublishRelay<Event>()
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.text = "Error message here"
        label.font = UIFont(
            name: Resources.Font.regular,
            size: Resources.Font.title3
        )
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradient()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupUI() {
        addSubview(errorMessage)
        
        errorMessage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(hexString: "#30A2C5").cgColor,
            UIColor(hexString: "#000000").cgColor
        ]
        layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Events
extension WeatherErrorView {
    
    enum Event {
        case retrySearch
    }
    
    var event: Observable<Event> {
        _event.asObservable()
    }
}
