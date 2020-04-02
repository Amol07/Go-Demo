//
//  ContactListPresenter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var router: ContactListRouterProtocol?
        
    func viewDidLoad() {
        self.interactor?.retrieveContactList()
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    func didRetrieveContacts(_ contacts: [Contact]) {
        self.view?.loadComplete()
    }
    
    func onError(_ error: CustomError?) {
        self.view?.showError(error)
    }
}
