//
//  ContactDetailsRouter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactDetailsRouter: ContactDetailsRouterProtocol {
    
    func present(viewController: UIViewController, from view: ContactDetailsViewProtocol?) {
        
    }
    
    func dismiss(controller: UIViewController) {
        
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
