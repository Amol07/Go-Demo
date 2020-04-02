//
//  ContactDetailsProtocols.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

protocol ContactDetailsViewProtocol: AnyObject {
    var presenter: ContactDetailsPresenterProtocol? { get set }
    var contact: Contact? { get set }
    // PRESENTER -> VIEW
    func contactMarked(isFavourite: Bool)
    func showError(_ error: CustomError?)
    func showLoading()
    func hideLoading()
}

// Presenter to presenter communication
protocol ContactDetailsDelegate: AnyObject {
    func contactMarkedFavourite()
}

protocol ContactDetailsPresenterProtocol: AnyObject {
    var view: ContactDetailsViewProtocol? { get set }
    var interactor: ContactDetailsInteractorInputProtocol? { get set }
    var router: ContactDetailsRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func markFavourite()
    func makeCall()
    func sendMessage()
    func sendEmail()
    func editContact()
}

protocol ContactDetailsRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    func present(viewController: UIViewController, from view: ContactDetailsViewProtocol?)
    func dismiss(controller: UIViewController)
}

protocol ContactDetailsInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func contactMarked(isFavourite: Bool)
    func onError(_ error: CustomError?)
}

protocol ContactDetailsInteractorInputProtocol: AnyObject {
    var presenter: ContactDetailsInteractorOutputProtocol? { get set }
    var remoteDataFetcher: ContactDetailsRemoteDataFetcherInputProtocol? { get set }
    var contact: Contact { get set }
    // PRESENTER -> INTERACTOR
    func markFavourite()
}

protocol ContactDetailsRemoteDataFetcherInputProtocol: AnyObject {
    var interactor: ContactDetailsRemoteDataFetcherOutputProtocol? { get set }
    // INTERACTOR -> REMOTEDATAMANAGER
    func markFavourite(contact: Contact)
}

protocol ContactDetailsRemoteDataFetcherOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func markFavouriteSuccessful(contact: Contact)
    func onError(_ error: CustomError?)
}
