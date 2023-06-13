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
import SnapKit

class WeatherErrorView: UIView {
    
    // MARK: - Properties
    private lazy var _event = PublishRelay<Event>()
    private let modalView = ModalView()
    private let errroButton = UIButton()
    private let errorMessage = UILabel()
    private let disposeBag = DisposeBag()
    
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
        setupModalView()
        setupErrorMessage()
        errroButtonSetup()
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
    
    private func setupModalView() {
        addSubview(modalView)
        modalView.layer.cornerRadius = 16
        modalView.clipsToBounds = true
        modalView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(modalView.snp.width)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupErrorMessage() {
        modalView.addSubview(errorMessage)
        errorMessage.font = UIFont(name: Resources.Font.regular,
                                   size: 20)
        errorMessage.textAlignment = .center
        errorMessage.textColor = .black
        errorMessage.text = "Произошла ошибка, повторите поиск"
        errorMessage.numberOfLines = 3
        errorMessage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func errroButtonSetup() {
        modalView.addSubview(errroButton)
        errroButton.addTarget(self, action: #selector(retrySearch), for: .touchUpInside)
        errroButton.setTitle("Повторить", for: .normal)
        errroButton.backgroundColor = .systemBlue
        errroButton.layer.cornerRadius = 16
        errroButton.contentEdgeInsets = UIEdgeInsets(top: 25,
                                                     left: 0,
                                                     bottom: 25,
                                                     right: 0)
        
        errroButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Resources.Constraints.labelHorizontalInsets)
            make.top.equalTo(errorMessage.snp.bottom).offset(60)
        }
    }
    
    @objc private func retrySearch() {
        _event.accept(.retrySearch)
    }
}

final class ModalView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let squarePath = UIBezierPath(roundedRect: bounds,
                                      cornerRadius: 32)
        squarePath.lineWidth = 2.0
        UIColor.white.setFill()
        squarePath.fill()
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
