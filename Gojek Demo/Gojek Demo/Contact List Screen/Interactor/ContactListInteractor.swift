//
//  ContactListInteractor.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactListInteractor: ContactListInteractorInputProtocol {
    
    weak var presenter: ContactListInteractorOutputProtocol?
    var remoteDataFetcher: ContactListRemoteDataFetcherInputProtocol?
    
    func retrieveContactList() {
        self.remoteDataFetcher?.retrieveContactList()
    }
    
    func getContactDetails(forContact contact: Contact) {
        self.remoteDataFetcher?.getContactDetails(forContact: contact)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactListInteractor: ContactListRemoteDataFetcherOutputProtocol {
    
    func onContactsRetrieved(_ contacts: [Contact]) {
        self.presenter?.didRetrieveContacts(contacts)
    }
    
    func contactDetailsRetrieved(contact: Contact) {
        self.presenter?.didContactDetailsRetrieved(contact: contact)
    }
    
    func onError(_ error: CustomError?) {
        self.presenter?.onError(error)
    }
}
