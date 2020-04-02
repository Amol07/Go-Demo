//
//  ContactDetailsRemoteDataFetcher.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactDetailsRemoteDataFetcher: ContactDetailsRemoteDataFetcherInputProtocol {
    weak var interactor: ContactDetailsRemoteDataFetcherOutputProtocol?
    
    func markFavourite(contact: Contact) {
        guard let param = ["favorite": contact.isFavorite, "id": contact.contactId as Any] as? [String : AnyHashable], let contactId = contact.contactId else {
            self.interactor?.onError(.badParamRequest)
            return
        }
        let url = Endpoints.Contacts.favourite("\(contactId)").url
        APIClient<Contact>.clientRequest(with: url, params: param, type: .put) { [weak self] contact, error in
            guard let contact = contact else {
                self?.interactor?.onError(error)
                return
            }
            self?.interactor?.markFavouriteSuccessful(contact: contact)
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
