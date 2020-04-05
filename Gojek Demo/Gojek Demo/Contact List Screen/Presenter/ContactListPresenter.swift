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
        return self.isGroupedList ? self.groupedContacts[section].count: self.contacts.count
    }
    
    func numberOfSection() -> Int {
        return self.isGroupedList ? self.groupedContacts.count : 1
    }
    
    func sectionIndexTitles() -> [String] {
        return self.letterIndexArray
    }
    
    func titleForHeader(in section: Int) -> String {
        return self.isGroupedList ? self.letterIndexArray[section] : ""
    }
    
    func contactAt(indexPath: IndexPath) -> Contact {
        return self.isGroupedList ? self.groupedContacts[indexPath.section][indexPath.row] : self.contacts[indexPath.row]
    }
    
    func selectedRowAt(indexPath: IndexPath) {
        self.view?.showLoading()
        self.interactor?.getContactDetails(forContact: self.contactAt(indexPath: indexPath))
    }
    
    func addContact() {
        self.router?.presentContactAddScreen(from: self.view, forContact: Contact(), andDelegate: self)
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
        } else {
            self.letterIndexArray.removeAll()
        }
        self.view?.hideLoading()
        self.view?.loadComplete()
    }
    
    func didContactDetailsRetrieved(contact: Contact) {
        self.view?.hideLoading()
        self.router?.showContactDetailScreen(from: self.view, forContact: contact, andDelegate: self)
    }
    
    func onError(_ error: CustomError?) {
        self.view?.hideLoading()
        self.view?.showError(error)
    }
}

extension ContactListPresenter: ContactEditDelegate {
    
    func didAdded(contact: Contact) {
        self.contacts.append(contact)
        self.didRetrieveContacts(self.contacts)
    }
}

extension ContactListPresenter: ContactDetailsDelegate {
    
    func contactInfoDidChange(isSortingRequired: Bool) {
        isSortingRequired ? self.didRetrieveContacts(self.contacts) : self.view?.loadComplete()
    }
    
    func contactMarkedFavourite() {
        self.view?.loadComplete()
    }
}

extension ContactListPresenter {
    
    private func createGroupedContactList(_ contacts: [Contact]) -> [[Contact]] {
        let groupedDictionary = Dictionary(grouping: contacts, by: { !($0.firstName.isEmpty || Int($0.firstName.prefix(1)) != nil) ? String($0.firstName.prefix(1)) : "#"})
        self.letterIndexArray = groupedDictionary.keys.sorted()
        return groupedDictionary.values.sorted { contacts1, contacts2 -> Bool in
            guard let firstName1 = contacts1.first?.firstName, let firstName2 = contacts2.first?.firstName else { return false }
            return firstName1 < firstName2
        }
    }
}
