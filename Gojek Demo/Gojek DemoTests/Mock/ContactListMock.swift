//
//  ContactListMock.swift
//  Gojek DemoTests
//
//  Created by Amol Prakash on 05/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit
@testable import Gojek_Demo

class MockContactListView: ContactListViewProtocol {
    var presenter: ContactListPresenterProtocol?
    var loadingComplete = false
    var isError = false
    var shown = false
    var hide = false
    
    func loadComplete() {
        self.loadingComplete = true
    }
    
    func showError(_ error: CustomError?) {
        self.isError = true
    }
    
    func showLoading() {
        self.shown = true
    }
    
    func hideLoading() {
        self.hide = true
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}


class MockContactListPresenter: ContactListInteractorOutputProtocol {
    var contacts: [Contact]?
    var contact: Contact?
    var error: CustomError?
    
    func didRetrieveContacts(_ contacts: [Contact]) {
        self.contacts = contacts
    }
    
    func didContactDetailsRetrieved(contact: Contact) {
        self.contact = contact
    }
    
    func onError(_ error: CustomError?) {
        self.error = error
    }
}

class MockContactListInteractor: ContactListInteractorInputProtocol, ContactListRemoteDataFetcherOutputProtocol {
    weak var presenter: ContactListInteractorOutputProtocol?
    
    var remoteDataFetcher: ContactListRemoteDataFetcherInputProtocol?
    
    func retrieveContactList() {
        self.remoteDataFetcher?.retrieveContactList()
    }
    
    func getContactDetails(forContact contact: Contact) {
        self.remoteDataFetcher?.getContactDetails(forContact: contact)
    }
    
    func onContactsRetrieved(_ contacts: [Contact]) {
        self.presenter?.didRetrieveContacts(contacts)
    }
    
    func contactDetailsRetrieved(contact: Contact) {
        self.presenter?.didContactDetailsRetrieved(contact: contact)
    }
    
    func onError(_ error: CustomError?) {
        self.presenter?.onError(error)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

class MockContactListDataFetcher: ContactListRemoteDataFetcherInputProtocol {
    weak var interactor: ContactListRemoteDataFetcherOutputProtocol?

    func retrieveContactList() {
        self.interactor?.onContactsRetrieved(getContactList())
    }

    func getContactDetails(forContact contact: Contact) {
        self.interactor?.contactDetailsRetrieved(contact: contact)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

class MockContactListRouter: ContactListRouterProtocol {
    var addScreenCalled = false
    var detailScreenCalled = false

    static func createContactListModule() -> UIViewController {
        return UIViewController()
    }
    
    func showContactDetailScreen(from view: ContactListViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactDetailsDelegate?) {
        self.detailScreenCalled = true
    }
    
    func presentContactAddScreen(from view: ContactListViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactEditDelegate?) {
        self.addScreenCalled = true
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

func getContactList() -> [Contact] {
    
    let contact = Contact()
    contact.contactId = 12121
    contact.firstName = "Amol"
    contact.lastName = "Prakash"
    contact.email = "amolprakash06@gmail.com"
    contact.phoneNumber = "+919560887157"
    contact.isFavorite = false
    
    let contact1 = Contact()
    contact1.contactId = 12122
    contact1.firstName = "Amit"
    contact1.lastName = "Gupta"
    contact1.email = "amit.gupta@gmail.com"
    contact1.phoneNumber = "+919560887156"
    contact1.isFavorite = false
    
    let contact2 = Contact()
    contact2.contactId = 12123
    contact2.firstName = "Bhuvan"
    contact2.lastName = "Kumar"
    contact2.email = "bhuvankumar@gmail.com"
    contact2.phoneNumber = "+919560887155"
    contact2.isFavorite = true
    
    let contact3 = Contact()
    contact3.contactId = 12124
    contact3.firstName = "Dummy"
    contact3.lastName = "Data"
    contact3.email = "dummydata@gmail.com"
    contact3.phoneNumber = "+919560887154"
    contact3.isFavorite = false
    
    return [contact, contact1, contact2, contact3]
}

var conatct: Contact = {
    let contact = Contact()
    contact.contactId = 121211
    contact.firstName = "Hello"
    contact.lastName = "World"
    contact.email = "helloworld@gmail.com"
    contact.phoneNumber = "+919453567835"
    contact.isFavorite = false
    return contact
}()
