//
//  ErrorScreen.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import UIKit


final class ModalViewController: UIViewController {
    
    // MARK: - Properties
    private let smileImage = UIImageView()
    private let labelMessage = UILabel()
    private let filledButton = UIButton()
    private let modalView = ModalView()
    private var action: () -> Void
    
    // MARK: - Init
    init(labelText: String, action: @escaping () -> Void) {
        self.labelMessage.text = labelText
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        modalViewSetup()
        smileImageSetup()
        labelMessageSetup()
        filledButtonSetup()
    }
}

extension ModalViewController {
    
    private func modalViewSetup() {
        view.addSubview(modalView)
        
        modalView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Resources.Constraints.labelHorizontalInsets)
            make.height.equalTo(modalView.snp.width)
            make.centerY.equalToSuperview()
        }
    }
    
    private func smileImageSetup() {
        modalView.addSubview(smileImage)
        
        smileImage.image = UIImage(named: "Cloud")
        
        smileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
                .inset(24)
        }
    }
    
    private func labelMessageSetup() {
        modalView.addSubview(labelMessage)
        
        
        labelMessage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
                .inset(Resources.Constraints.labelHorizontalInsets)
            make.top.equalTo(smileImage.snp.bottom)
                .offset(Resources.labelTop)
        }
    }
    
    private func filledButtonSetup() {
        modalView.addSubview(filledButton)
        
        filledButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        filledButton.setTitle("Закрыть", for: .normal)
        filledButton.contentEdgeInsets = UIEdgeInsets(top: 25,
                                         left: 0,
                                         bottom: 25,
                                         right: 0)
        
        filledButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
                .inset(Resources.Constraints.labelHorizontalInsets)
            make.top.equalTo(labelMessage.snp.bottom)
                .offset(Resources.buttonTop)
        }
    }
    
    @objc private func buttonDidTap() {
        action()
    }
}

fileprivate extension Resources {
    
    // Constraints
    static let cornerRadius = 32.0
    
    static let smileImageMaxSize = 120.0
    
    static let labelTop = 24.0
    static let labelHorizontalInsets = 16.0
    
    static let buttonTop = 41.0
    
    
    // Strings
    static let filledButtonTitle = "Закрыть"
}



