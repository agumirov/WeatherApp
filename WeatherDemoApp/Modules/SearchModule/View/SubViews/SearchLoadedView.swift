//
//  SearchSucessView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 05.05.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchLoadedView: UIView {
    
    // MARK: - Properties
    private var cities: [GeoModelDomain] = []
    private var _event = PublishRelay<Event>()
    private let disposeBag = DisposeBag()
    private let searchView = SearchView()
    private let searchField = UITextField()
    private let closeButton = UIButton()
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(CollectionViewCell.self,
                            forCellWithReuseIdentifier: CollectionViewCell.cellId)
        return collection
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        collectionConfig()
        bindText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupUI() {
        setupsearchView()
        setupCloseButton()
        setupsearchField()        
        collectionConfig()
    }
}

// MARK: - Setup UI elements
extension SearchLoadedView {
    
    private func setupsearchView() {
        addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(snp.centerY)
        }
    }
    
    private func setupCloseButton() {
        searchView.addSubview(closeButton)
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.rx.tap
            .bind { [weak self] in
                self?._event.accept(.cancelSearch)
            }
            .disposed(by: disposeBag)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(28)
            make.right.equalToSuperview()
                .inset(23)
        }
    }
    
    private func setupsearchField() {
        searchView.addSubview(searchField)
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchField.leftView = padding
        searchField.leftViewMode = .always
        searchField.placeholder = "Search Location".uppercased()
        searchField.layer.cornerRadius = 20
        searchField.backgroundColor = .systemGray4
        
        searchField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
                .inset(55)
            make.top.equalTo(closeButton.snp.bottom)
                .inset(12)
            make.height.equalTo(44)
        }
    }
    
    private func collectionConfig() {
        searchView.addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 10, left: 10,
                                               bottom: 0, right: 10)
        
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom)
                .offset(30)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - CollectionView Delegate
extension SearchLoadedView: UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cities.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.cellId,
            for: indexPath
        ) as? CollectionViewCell
        else { return UICollectionViewCell()}
        cell.configureCell(city: cities[indexPath.row].name, country: cities[indexPath.row].country)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 20, height: 40)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _event.accept(.citySelected(city: cities[indexPath.row]))
    }
}

// MARK: - Events and States handling
extension SearchLoadedView {
    
    enum Event {
        case citySelected(city: GeoModelDomain)
        case searchDidChange(text: String)
        case cancelSearch
    }
    
    var event: Observable<Event> {
        _event.asObservable()
    }
    
    func render(cities: [GeoModelDomain]) {
        self.cities = cities
        collection.reloadData()
    }
    
    private func bindText() {
        searchField.rx.text
            .asObservable()
            .subscribe(onNext: {[weak self] text in
                guard let text = text, let self = self else { return }
                if text.isEmpty { return }
                self._event.accept(.searchDidChange(text: text))
            })
            .disposed(by: disposeBag)
    }
}
