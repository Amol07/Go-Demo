//
//  ContactListRouter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}

class ContactListRouter: ContactListRouterProtocol {
    
    static func createContactListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ContactsNavigationController")
        if let view = navController.children.first as? ContactsListViewController {
            let presenter: ContactListPresenterProtocol & ContactListInteractorOutputProtocol = ContactListPresenter()
            let interactor: ContactListInteractorInputProtocol & ContactListRemoteDataFetcherOutputProtocol = ContactListInteractor()
            let remoteDataFetcher: ContactListRemoteDataFetcherInputProtocol = ContactListRemoteDataFetcher()
            let router: ContactListRouterProtocol = ContactListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataFetcher = remoteDataFetcher
            remoteDataFetcher.interactor = interactor
            return navController
        }
        return UIViewController()
    }
    
    private static func createContactDetailModule(withContact contact: Contact, andDelegate delegate: ContactDetailsDelegate?) -> UIViewController {
        guard let detailsVc = mainStoryboard.instantiateViewController(identifier: "ContactDetailsViewController") as? ContactDetailsViewController else { return UIViewController() }
        let presenter: ContactDetailsPresenterProtocol & ContactDetailsInteractorOutputProtocol = ContactDetailsPresenter(delegate: delegate)
        let interactor: ContactDetailsInteractorInputProtocol & ContactDetailsRemoteDataFetcherOutputProtocol = ContactDetailsInteractor(contact: contact)
        let remoteDataFetcher: ContactDetailsRemoteDataFetcherInputProtocol = ContactDetailsRemoteDataFetcher()
        let router: ContactDetailsRouterProtocol = ContactDetailsRouter()
        
        detailsVc.presenter = presenter
        presenter.view = detailsVc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataFetcher = remoteDataFetcher
        remoteDataFetcher.interactor = interactor
        return detailsVc
    }
    
    func showContactDetailScreen(from view: ContactListViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactDetailsDelegate?) {
        let detailVc = type(of: self).createContactDetailModule(withContact: contact, andDelegate: delegate)
        if let view = view as? UIViewController {
            view.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
    
    func presentContactAddScreen(from view: ContactListViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactEditDelegate?) {
        let addVc = ContactDetailsRouter.createEditScreenModule(contact: contact, saveType: .new, andDelegate: delegate)
        if let view = view as? UIViewController {
            view.navigationController?.present(addVc, animated: true, completion: nil)
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
