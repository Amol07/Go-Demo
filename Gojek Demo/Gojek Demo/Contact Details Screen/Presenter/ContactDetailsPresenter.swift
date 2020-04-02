//
//  ContactDetailsPresenter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactDetailsPresenter: ContactDetailsPresenterProtocol {
    weak var view: ContactDetailsViewProtocol?
    var interactor: ContactDetailsInteractorInputProtocol?
    var router: ContactDetailsRouterProtocol?
    
    private weak var delegate: ContactDetailsDelegate?
    
    init(delegate: ContactDetailsDelegate?) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.view?.contact = self.interactor?.contact
    }
    
    func markFavourite() {
        self.view?.showLoading()
        self.interactor?.markFavourite()
    }
    
    func makeCall() {
        
    }
    
    func sendMessage() {
        
    }
    
    func sendEmail() {
        
    }
    
    func editContact() {
        
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactDetailsPresenter: ContactDetailsInteractorOutputProtocol {
    
    func contactMarked(isFavourite: Bool) {
        self.view?.hideLoading()
        self.view?.contactMarked(isFavourite: isFavourite)
        self.delegate?.contactMarkedFavourite()
    }
    
    func onError(_ error: CustomError?) {
        self.view?.hideLoading()
        self.view?.showError(error)
    }
}
