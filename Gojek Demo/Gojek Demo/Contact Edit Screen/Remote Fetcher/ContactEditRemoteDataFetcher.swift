//
//  ContactEditRemoteDataFetcher.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactEditRemoteDataFetcher: ContactEditRemoteDataFetcherInputProtocol {
    weak var interactor: ContactEditRemoteDataFetcherOutputProtocol?
    
    func saveContact(contact: Contact) {
        guard let contactId = contact.contactId, let phoneNo = contact.phoneNumber, let email = contact.email else {
            self.interactor?.onError(.badParamRequest)
            return
        }
        var param = [ApiConstants.firstName: "\(contact.firstName)", ApiConstants.lastName: "\(contact.lastName)", ApiConstants.phoneNumber: "\(phoneNo)", ApiConstants.email: "\(email)"]
        if let imageData = contact.imageData {
            param["profile_pic"] = imageData.base64EncodedString()
        }
        let url =  Endpoints.Contacts.edit("\(contactId)").url
        APIClient<Contact>.clientRequest(with: url, params: param, type: .put) { [weak self] contact, error in
            guard let contact = contact else {
                self?.interactor?.onError(error)
                return
            }
            self?.interactor?.contactSavedSuccessfully(contact: contact)
        }
    }
    
    func addContact(contact: Contact) {
        guard let phoneNo = contact.phoneNumber, let email = contact.email else {
            self.interactor?.onError(.badParamRequest)
            return
        }
        let param = [ApiConstants.firstName: "\(contact.firstName)", ApiConstants.lastName: "\(contact.lastName)", ApiConstants.phoneNumber: "\(phoneNo)", ApiConstants.email: "\(email)"]
        let url =  Endpoints.Contacts.add.url
        APIClient<Contact>.clientRequest(with: url, params: param, type: .post) { [weak self] contact, error in
            guard let contact = contact else {
                self?.interactor?.onError(error)
                return
            }
            self?.interactor?.contactSavedSuccessfully(contact: contact)
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
