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
    
    func viewDidLoad() {
        
    }
    
    func markFavourite() {
        
    }
    
    func makeCall() {
        
    }
    
    func sendMessage() {
        
    }
    
    func sendEmail() {
        
    }
    
    func editContact() {
        
    }
}

extension ContactDetailsPresenter: ContactDetailsInteractorOutputProtocol {
    
    func contactMarked(isFavourite: Bool) {
        
    }
    
    func onError(_ error: CustomError?) {
        
    }
}
