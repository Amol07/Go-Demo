//
//  ContactDetailsViewController.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var userImageView: AyncImageView! {
        didSet {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2
            self.userImageView.layer.borderColor = UIColor.white.cgColor
            self.userImageView.layer.borderWidth = 2
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet var actionButtons: [UIButton]! {
        didSet {
            self.actionButtons.forEach { button in
                button.layer.cornerRadius = button.frame.height/2
                button.layer.borderColor = UIColor.clear.cgColor
                button.layer.borderWidth = 0.5

            }
        }
    }
    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    var presenter: ContactDetailsPresenterProtocol?
    var contact: Contact? {
        didSet {
            if let email = self.contact?.email, !email.isEmpty {
                self.emailLabel.text = email
            }
            if let number = self.contact?.phoneNumber, !number.isEmpty {
                self.phoneLabel.text = number
            }
            self.nameLabel.text = [self.contact?.firstName, self.contact?.lastName].compactMap { $0 }.joined(separator: " ")
            self.contactMarked(isFavourite: self.contact?.isFavorite ?? false)
            if let profileUrlString = contact?.profilePicUrlString {
                self.userImageView.loadAsyncFrom(urlString: "\(EnvironmentURL.baseUrl)\(profileUrlString)", placeholder: #imageLiteral(resourceName: "placeholder_photo"))
            } else {
                self.userImageView.image = #imageLiteral(resourceName: "placeholder_photo")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.view.layoutIfNeeded()
        self.gradientView.setGradientBackground(colorOne: .white, colorTwo: UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0))
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        self.presenter?.sendMessage()
    }
    
    @IBAction func call(_ sender: Any) {
        self.presenter?.makeCall()
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        self.presenter?.sendEmail()
    }
    
    @IBAction func markFavourite(_ sender: Any) {
        self.presenter?.markFavourite()
    }
    
    @IBAction func editContact(_ sender: Any) {
        self.presenter?.editContact()
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactDetailsViewController: ContactDetailsViewProtocol {
    
    func contactMarked(isFavourite: Bool) {
        self.favouriteButton.setImage(isFavourite ? #imageLiteral(resourceName: "home_favourite") : #imageLiteral(resourceName: "favourite_button"), for: .normal)
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
