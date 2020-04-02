//
//  ContactListViewController.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    var presenter: ContactListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func addContact(_ sender: Any) {
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactsListViewController: ContactListViewProtocol {
    
    func loadComplete() {
        self.tableView.reloadData()
    }
    
    func showError(_ error: CustomError?) {
        // Handle error
        self.showAlert(title: "Error", message: error?.errorDescription ?? "Something went wrong. Please try again later.") { (alert, index) in
        }
    }
    
    func showLoading() {
        // Show spinner
        self.activityIndicatorView.startAnimating()
        
    }
    
    func hideLoading() {
        // Remove spinner
        self.activityIndicatorView.stopAnimating()
    }
}

extension ContactsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let presenter = self.presenter else { return 1 }
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else { return ContactsTableViewCell() }
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let contact = presenter.contactAt(indexPath: indexPath)
        cell.configure(contact: contact)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.presenter?.sectionIndexTitles()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter?.titleForHeader(in: section)
    }
}

extension ContactsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.selectedRowAt(indexPath: indexPath)
    }
}
