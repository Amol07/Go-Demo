//
//  ContactDetailsPresenter.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import MessageUI

class ContactDetailsPresenter: NSObject, ContactDetailsPresenterProtocol {
    weak var view: ContactDetailsViewProtocol?
    var interactor: ContactDetailsInteractorInputProtocol?
    var router: ContactDetailsRouterProtocol?
    
    private weak var delegate: ContactDetailsDelegate?
    
    init(delegate: ContactDetailsDelegate?) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        self.view?.contact = self.interactor?.contact
    }
    
    func markFavourite() {
        self.view?.showLoading()
        self.interactor?.markFavourite()
    }
    
    func makeCall() {
        guard let phoneNumber = self.interactor?.contact.phoneNumber, phoneNumber.isValidPhoneNumber else {
            self.view?.showError(.invalidPhoneNo)
            return
        }
        phoneNumber.makeACall()
    }
    
    func sendMessage() {
        guard let phoneNumber = self.interactor?.contact.phoneNumber, phoneNumber.isValidPhoneNumber else {
            self.view?.showError(.invalidPhoneNo)
            return
        }
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.router?.present(viewController: controller, from: self.view)
        } else {
            
        }
    }
    
    func sendEmail() {
        guard let email = self.interactor?.contact.email, email.isValidEmail() else {
            self.view?.showError(.invalidEmail)
            return
        }
        if MFMailComposeViewController.canSendMail() {
            let mailVc = MFMailComposeViewController()
            mailVc.setToRecipients([email])
            mailVc.mailComposeDelegate = self
            self.router?.present(viewController: mailVc, from: self.view)
        } else {
            // show failure alert
            self.view?.showError(.mailConfigError)
        }
    }
    
    func editContact() {
        guard let contact = self.interactor?.contact else { return }
        self.router?.presentContactEditScreen(from: self.view, forContact: contact, andDelegate: self)
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactDetailsPresenter: ContactEditDelegate {
    
    func didEditedSuccessfully() {
        self.view?.contact = self.interactor?.contact
        self.delegate?.contactInfoDidChange(isSortingRequired: true)
    }
}

extension ContactDetailsPresenter: ContactDetailsInteractorOutputProtocol {
    
    func contactMarked(isFavourite: Bool) {
        self.view?.hideLoading()
        self.view?.contactMarked(isFavourite: isFavourite)
        self.delegate?.contactMarkedFavourite()
    }
    
    func onError(_ error: CustomError?) {
        self.view?.hideLoading()
        self.view?.showError(error)
    }
}

extension ContactDetailsPresenter: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.router?.dismiss(controller: controller)
    }
}

extension ContactDetailsPresenter: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.router?.dismiss(controller: controller)
    }
}
