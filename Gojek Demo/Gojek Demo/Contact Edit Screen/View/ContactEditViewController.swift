//
//  ContactEditViewController.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 03/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController {
    
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var userImageView: AyncImageView! {
        didSet {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2
            self.userImageView.layer.borderColor = UIColor.white.cgColor
            self.userImageView.layer.borderWidth = 2
            if let profileUrlString = self.presenter?.profilePicUrlString {
                self.userImageView.loadAsyncFrom(urlString: "\(EnvironmentURL.baseUrl)\(profileUrlString)", placeholder: #imageLiteral(resourceName: "placeholder_photo"))
            } else {
                self.userImageView.image = #imageLiteral(resourceName: "placeholder_photo")
            }
        }
    }
    
    @IBOutlet private weak var firstNameTextField: UITextField! {
        didSet {
            self.firstNameTextField.text = self.presenter?.firstName
            self.firstNameTextField.isAccessibilityElement = true
            self.firstNameTextField.accessibilityIdentifier = "First Name"
        }
    }
    @IBOutlet private weak var lastNameTextField: UITextField! {
        didSet {
            self.lastNameTextField.text = self.presenter?.lastName
            self.lastNameTextField.isAccessibilityElement = true
            self.lastNameTextField.accessibilityIdentifier = "Last Name"
        }
    }
    @IBOutlet private weak var phoneNoTextField: UITextField! {
        didSet {
            self.phoneNoTextField.text = self.presenter?.phoneNumber
            self.phoneNoTextField.isAccessibilityElement = true
            self.phoneNoTextField.accessibilityIdentifier = "Phone Number"
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.text = self.presenter?.email
            self.emailTextField.isAccessibilityElement = true
            self.emailTextField.accessibilityIdentifier = "Email Id"
        }
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            self.activityIndicatorView.stopAnimating()
        }
    }

    var presenter: ContactEditPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.gradientView.setGradientBackground(colorOne: .white, colorTwo: UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0))
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func done(_ sender: Any) {
        self.view.endEditing(true)
        self.presenter?.saveContact()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePhoto(_ sender: Any) {
        self.view.endEditing(true)
        self.presenter?.photoSelector()
    }
    
    @IBAction func editingChnaged(_ sender: UITextField) {
        let type: UpdateInputType
        switch sender {
        case self.firstNameTextField:
            type = .firstName
        case self.lastNameTextField:
            type = .lastName
        case self.phoneNoTextField:
            type = .phone
        case self.emailTextField:
            type = .email
        default:
            type = .firstName
        }
        self.presenter?.editingChanged(in: type, with: sender.text?.trim() ?? "")
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension ContactEditViewController: ContactEditViewProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func selectedImage(_ image: UIImage) {
        self.userImageView.image = image
    }
    
    func contactSavedSuccessfully() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showError(_ error: CustomError?) {
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

extension ContactEditViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let whitespaceSet = CharacterSet.whitespaces
        if let _ = string.rangeOfCharacter(from: whitespaceSet) {
            return false
        }
        let charCount: Int
        switch textField {
        case self.firstNameTextField, self.lastNameTextField:
            charCount = 20
        case self.phoneNoTextField:
            charCount = 13
            guard CharacterSet(charactersIn: "+123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        case self.emailTextField:
            charCount = 50
        default:
            charCount = 20
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= charCount
    }
}

