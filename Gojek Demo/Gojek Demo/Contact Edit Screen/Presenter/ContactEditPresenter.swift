//
//  ContactEditPresenter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

enum UpdateInputType {
    case photo
    case firstName
    case lastName
    case phone
    case email
}

enum ContactSaveType {
    case new
    case existing
}


class ContactEditPresenter: ContactEditPresenterProtocol {
    weak var view: ContactEditViewProtocol?
    var interactor: ContactEditInteractorInputProtocol?
    private weak var delegate: ContactEditDelegate?
    private var imagePicker: ImagePicker?
    
    var contactSaveType: ContactSaveType
    
    var phoneNumber: String? {
        return self.interactor?.contact.phoneNumber
    }
    
    var email: String? {
        return self.interactor?.contact.email
    }
    
    var firstName: String? {
        return self.interactor?.contact.firstName
    }
    
    var lastName: String? {
        return self.interactor?.contact.lastName
    }
    
    var profilePicUrlString: String? {
        return self.interactor?.contact.profilePicUrlString
    }
    
    init(type: ContactSaveType, delegate: ContactEditDelegate?) {
        self.contactSaveType = type
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.contactSaveType == .existing ? self.view?.setTitle("Edit Contact") : self.view?.setTitle("Add Contact")
        if let view = self.view as? ContactEditViewController {
            self.imagePicker = ImagePicker(presentationController: view, delegate: self)
        }
    }
    
    func editingChanged(in inputType: UpdateInputType, with text: String) {
        if self.interactor?.tempContact == nil {
            self.interactor?.tempContact = Contact()
        }
        switch inputType {
        case .photo:
            break
        case .firstName:
            self.interactor?.tempContact.firstName = text
        case .lastName:
            self.interactor?.tempContact.lastName = text
        case .phone:
            self.interactor?.tempContact.phoneNumber = text
        case .email:
            self.interactor?.tempContact.email = text
        }
    }
    
    func saveContact() {
        self.checkValidationsAndSaveContact()
    }
    
    func photoSelector() {
        self.imagePicker?.present(from: nil)
    }
    
    private func checkValidationsAndSaveContact() {
        guard let model = interactor?.tempContact else {
            self.view?.showError(.invalidContact)
            return
        }
        
        guard !model.firstName.trim().isEmpty else {
            self.view?.showError(.invalidFirstName)
            return
        }
        
        guard !model.lastName.trim().isEmpty else {
            self.view?.showError(.invalidLastName)
            return
        }
        
        guard let phoneNumber = model.phoneNumber, phoneNumber.isValidPhoneNumber  else {
            self.view?.showError(.invalidPhoneNo)
            return
        }
        
        guard let email = model.email, email.isValidEmail()  else {
            self.view?.showError(.invalidEmail)
            return
        }
        self.view?.showLoading()
        self.interactor?.saveContact(type: self.contactSaveType)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactEditPresenter: ImagePickerDelegate {
    
    func didSelect(image: UIImage) {
        self.view?.selectedImage(image)
        self.interactor?.tempContact.imageData = image.pngData()
    }
}

extension ContactEditPresenter: ContactEditInteractorOutputProtocol {
    
    func edited(contact: Contact) {
        self.view?.hideLoading()
        switch self.contactSaveType {
        case .existing:
            self.delegate?.didEditedSuccessfully()
        case .new:
            self.delegate?.didAdded(contact: contact)
        }
        self.view?.contactSavedSuccessfully()
    }
    
    func onError(_ error: CustomError?) {
        self.view?.hideLoading()
        self.view?.showError(error)
    }
}
