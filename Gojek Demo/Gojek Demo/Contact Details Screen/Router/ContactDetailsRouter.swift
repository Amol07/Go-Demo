//
//  ContactDetailsRouter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactDetailsRouter: ContactDetailsRouterProtocol {
    
    static func createEditScreenModule(contact: Contact, saveType: ContactSaveType, andDelegate delegate: ContactEditDelegate?) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "EditContactNavigationController")
        if let view = navController.children.first as? ContactEditViewController {
            let presenter: ContactEditPresenterProtocol & ContactEditInteractorOutputProtocol = ContactEditPresenter(type: saveType, delegate: delegate)
            let interactor: ContactEditInteractorInputProtocol & ContactEditRemoteDataFetcherOutputProtocol = ContactEditInteractor(contact: contact)
            let remoteDataFetcher: ContactEditRemoteDataFetcherInputProtocol = ContactEditRemoteDataFetcher()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataFetcher = remoteDataFetcher
            remoteDataFetcher.interactor = interactor
            return navController
        }
        return UIViewController()
    }
    
    func presentContactEditScreen(from view: ContactDetailsViewProtocol?, forContact contact: Contact, andDelegate delegate: ContactEditDelegate?) {
        if let view = view as? ContactDetailsViewController {
            let navVc = type(of: self).createEditScreenModule(contact: contact, saveType: .existing, andDelegate: delegate)

            view.navigationController?.present(navVc, animated: true, completion: nil)
        }
    }
    
    func present(viewController: UIViewController, from view: ContactDetailsViewProtocol?) {
        if let view = view as? ContactDetailsViewController {
            view.present(viewController, animated: true, completion: nil)
        }
    }
    
    func dismiss(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
