//
//  ContactListProtocols.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ContactListViewProtocol: AnyObject {
    var presenter: ContactListPresenterProtocol? { get set }
    // PRESENTER -> VIEW
    func loadComplete()
    func showError(_ error: CustomError?)
    func showLoading()
    func hideLoading()
}

protocol ContactListRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createContactListModule() -> UIViewController
    func showContactDetailScreen(from view: ContactListViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactDetailsDelegate?)
}

protocol ContactListPresenterProtocol: AnyObject {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactListInteractorInputProtocol? { get set }
    var router: ContactListRouterProtocol? { get set }
    
    var letterIndexArray: [String] { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func addContact()
    func titleForHeader(in section: Int) -> String
    func sectionIndexTitles() -> [String]
    func numberOfRows(inSection section: Int) -> Int
    func numberOfSection() -> Int
    func contactAt(indexPath: IndexPath) -> Contact
    func selectedRowAt(indexPath: IndexPath)
}

protocol ContactListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: [Contact])
    func didContactDetailsRetrieved(contact: Contact)
    func onError(_ error: CustomError?)
}

protocol ContactListInteractorInputProtocol: AnyObject {
    var presenter: ContactListInteractorOutputProtocol? { get set }
    var remoteDataFetcher: ContactListRemoteDataFetcherInputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func retrieveContactList()
    func getContactDetails(forContact contact: Contact)
}

protocol ContactListRemoteDataFetcherInputProtocol: AnyObject {
    var interactor: ContactListRemoteDataFetcherOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactList()
    func getContactDetails(forContact contact: Contact)
}

protocol ContactListRemoteDataFetcherOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: [Contact])
    func contactDetailsRetrieved(contact: Contact)
    func onError(_ error: CustomError?)
}
