//
//  ContactEditProtocols.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol ContactEditViewProtocol: AnyObject {
    var presenter: ContactEditPresenterProtocol? { get set }
    // PRESENTER -> VIEW
    
    func setTitle(_ title: String)
    func contactSavedSuccessfully()
    func showError(_ error: CustomError?)
    func showLoading()
    func hideLoading()
}

// Presenter to presenter communication
protocol ContactEditDelegate: AnyObject {
    func didAdded(contact: Contact)
    func didEditedSuccessfully()
}

extension ContactEditDelegate {
    func didAdded(contact: Contact) {}
    func didEditedSuccessfully() {}
}

protocol ContactEditPresenterProtocol: AnyObject {
    var view: ContactEditViewProtocol? { get set }
    var interactor: ContactEditInteractorInputProtocol? { get set }
    
    var phoneNumber: String? { get }
    var email: String? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    
    var contactSaveType: ContactSaveType { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func saveContact()
    func editingChanged(in inputType: UpdateInputType, with text: String)
}

protocol ContactEditInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func edited(contact: Contact)
    func onError(_ error: CustomError?)
}

protocol ContactEditInteractorInputProtocol: AnyObject {
    var presenter: ContactEditInteractorOutputProtocol? { get set }
    var remoteDataFetcher: ContactEditRemoteDataFetcherInputProtocol? { get set }
    var contact: Contact { get set }
    var tempContact: Contact { get set }
    // PRESENTER -> INTERACTOR
    func saveContact(type: ContactSaveType)
}

protocol ContactEditRemoteDataFetcherInputProtocol: AnyObject {
    var interactor: ContactEditRemoteDataFetcherOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func saveContact(contact: Contact)
    func addContact(contact: Contact)
}

protocol ContactEditRemoteDataFetcherOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func contactSavedSuccessfully(contact: Contact)
    func onError(_ error: CustomError?)
}
