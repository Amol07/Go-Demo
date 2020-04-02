//
//  ContactListViewController.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {
    var presenter: ContactListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactsListViewController: ContactListViewProtocol {
    
    func loadComplete() {
        
    }
    
    func showError(_ error: CustomError?) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
