//
//  ContactsTableViewCell.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private weak var profileImageView: AyncImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width/2
        self.profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        self.profileImageView.layer.borderWidth = 0.5
    }
    
    func configure(contact: Contact) {
        self.nameLabel.text = [contact.firstName, contact.lastName].compactMap { $0 }.joined(separator: " ")
        if contact.isFavorite {
            self.favImageView.isHidden = false
        } else {
            self.favImageView.isHidden = true
        }
        if let profileUrlString = contact.profilePicUrlString {
            self.profileImageView.loadAsyncFrom(urlString: "\(EnvironmentURL.baseUrl)\(profileUrlString)", placeholder: #imageLiteral(resourceName: "placeholder_photo"))
        } else {
            self.profileImageView.image = #imageLiteral(resourceName: "placeholder_photo")
        }
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
