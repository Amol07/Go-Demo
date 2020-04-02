//
//  ContactListRemoteDataFetcher.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactListRemoteDataFetcher: ContactListRemoteDataFetcherInputProtocol {
    weak var interactor: ContactListRemoteDataFetcherOutputProtocol?
    
    func retrieveContactList() {
        APIClient<[Contact]>.clientRequest(with: Endpoints.Contacts.fetch.url, params: nil, type: .get) { [weak self] contacts, error in
            guard let contacts = contacts else {
                self?.interactor?.onError(error)
                return
            }
            self?.interactor?.onContactsRetrieved(contacts)
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
