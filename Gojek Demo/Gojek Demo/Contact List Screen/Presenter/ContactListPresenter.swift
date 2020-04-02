//
//  ContactListPresenter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var router: ContactListRouterProtocol?
    
    var isGroupedList = true
    var letterIndexArray = [String]()
    
    private var groupedContacts = [[Contact]]()
    private var contacts = [Contact]()
        
    func viewDidLoad() {
        self.interactor?.retrieveContactList()
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        if self.isGroupedList {
            return self.groupedContacts[section].count
        } else {
            return self.contacts.count
        }
    }
    
    func numberOfSection() -> Int {
        if self.isGroupedList {
            return self.groupedContacts.count
        } else {
            return 1
        }
    }
    
    func sectionIndexTitles() -> [String] {
        return self.letterIndexArray
    }
    
    func titleForHeader(in section: Int) -> String {
        if self.isGroupedList {
            return String(self.groupedContacts[section].first?.firstName.prefix(1) ?? "")
        } else {
            return ""
        }
    }
    
    func contactAt(indexPath: IndexPath) -> Contact {
        if self.isGroupedList {
            return self.groupedContacts[indexPath.section][indexPath.row]
        } else {
            return self.contacts[indexPath.row]
        }
    }
    
    func selectedRowAt(indexPath: IndexPath) {
    }
    
    func addContact() {
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    func didRetrieveContacts(_ contacts: [Contact]) {
        self.contacts = contacts.sorted { $0.firstName < $1.firstName }
        if self.isGroupedList {
            self.groupedContacts = self.createGroupedContactList(self.contacts)
        }
        self.view?.hideLoading()
        self.view?.loadComplete()
    }
    
    func onError(_ error: CustomError?) {
        self.view?.hideLoading()
        self.view?.showError(error)
    }
}

extension ContactListPresenter {
    
    func createGroupedContactList(_ contacts: [Contact]) -> [[Contact]] {
        let groupContactArray = contacts.reduce([[Contact]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.firstName.prefix(1) == $1.firstName.prefix(1) {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                self.letterIndexArray.append(String([$1].first?.firstName.prefix(1) ?? "Z"))
                collection += [[$1]]
            }
            return collection
        }
        return groupContactArray
    }
}
