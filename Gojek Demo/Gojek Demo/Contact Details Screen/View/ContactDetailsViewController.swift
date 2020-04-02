//
//  ContactDetailsViewController.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    var presenter: ContactDetailsPresenterProtocol?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ContactDetailsViewController: ContactDetailsViewProtocol {
    
    func contactMarked(isFavourite: Bool) {
        
    }
    
    func showError(_ error: CustomError?) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
