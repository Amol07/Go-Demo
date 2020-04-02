//
//  ContactListProtocols.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ContactListViewProtocol: class {
    var presenter: ContactListPresenterProtocol? { get set }
    // PRESENTER -> VIEW
    func loadComplete()
    func showError(_ error: CustomError?)
    func showLoading()
    func hideLoading()
}

protocol ContactListRouterProtocol: class {
    static func createContactListModule() -> UIViewController
    // PRESENTER -> ROUTER
}

protocol ContactListPresenterProtocol: class {
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

protocol ContactListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: [Contact])
    func onError(_ error: CustomError?)
}

protocol ContactListInteractorInputProtocol: class {
    var presenter: ContactListInteractorOutputProtocol? { get set }
    var remoteDataFetcher: ContactListRemoteDataFetcherInputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func retrieveContactList()
}

protocol ContactListRemoteDataFetcherInputProtocol: class {
    var interactor: ContactListRemoteDataFetcherOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactList()
}

protocol ContactListRemoteDataFetcherOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: [Contact])
    func onError(_ error: CustomError?)
}
