//
//  ContactEditInteractor.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactEditInteractor: ContactEditInteractorInputProtocol {
    
    weak var presenter: ContactEditInteractorOutputProtocol?
    
    var remoteDataFetcher: ContactEditRemoteDataFetcherInputProtocol?
    
    var contact: Contact
    var tempContact: Contact
    
    required init(contact: Contact) {
        self.contact = contact
        self.tempContact = contact.copy() as? Contact ?? Contact()
    }
    
    func saveContact(type: ContactSaveType) {
        switch type {
        case .new:
            self.remoteDataFetcher?.addContact(contact: self.tempContact)
        case .existing:
            self.remoteDataFetcher?.saveContact(contact: self.tempContact)
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactEditInteractor: ContactEditRemoteDataFetcherOutputProtocol {
    
    func contactSavedSuccessfully(contact: Contact) {
        self.contact.firstName = contact.firstName
        self.contact.lastName = contact.lastName
        self.contact.phoneNumber = contact.phoneNumber
        self.contact.email = contact.email
        self.presenter?.edited(contact: contact)
    }
    
    func onError(_ error: CustomError?) {
        self.presenter?.onError(error)
    }
}
