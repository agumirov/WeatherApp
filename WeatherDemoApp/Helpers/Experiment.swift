//
//  Experiment.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation

protocol Interactor {}

class Presenter <I: Interactor> {
    var interactor: I?
}

protocol ConcreteInteractor: Interactor {
    func foo()
}

class ConcreteInteractorImplementation: ConcreteInteractor {
    func foo() {}
    
    func bar() {}
}

class ConcretePresenter <I>: Presenter<I> where I: ConcreteInteractor {
    func foo() {
        interactor?.foo()
    }
}
