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
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
