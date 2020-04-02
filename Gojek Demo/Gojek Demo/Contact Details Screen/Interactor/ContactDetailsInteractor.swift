//
//  ContactDetailsInteractor.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactDetailsInteractor: ContactDetailsInteractorInputProtocol {
    weak var presenter: ContactDetailsInteractorOutputProtocol?
    var remoteDataFetcher: ContactDetailsRemoteDataFetcherInputProtocol?
    var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func markFavourite() {
        self.contact.isFavorite.toggle()
        self.remoteDataFetcher?.markFavourite(contact: self.contact)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactDetailsInteractor: ContactDetailsRemoteDataFetcherOutputProtocol {
    
    func markFavouriteSuccessful(contact: Contact) {
        self.contact = contact
        self.presenter?.contactMarked(isFavourite: contact.isFavorite)
    }
    
    func onError(_ error: CustomError?) {
        self.presenter?.onError(error)
    }
}
