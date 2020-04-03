//
//  Contact.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum ApiConstants {
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let profilePic = "profile_pic"
    static let isFavorite = "favorite"
    static let contactId = "id"
    static let phoneNumber = "phone_number"
    static let email = "email"
}

class Contact: Decodable {
    
    var contactId: Int?
    var firstName: String = ""
    var lastName: String = ""
    var profilePicUrlString: String?
    var contactDetailsUrlString: String?
    var isFavorite: Bool = false
    
    var email: String?
    var phoneNumber: String?
    
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case contactId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrlString = "profile_pic"
        case isFavorite = "favorite"
        case contactDetailsUrlString = "url"
        case email
        case phoneNumber = "phone_number"
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}

extension Contact: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Contact()
        copy.contactId = self.contactId
        copy.firstName = self.firstName
        copy.lastName = self.lastName
        copy.phoneNumber = self.phoneNumber
        copy.email = self.email
        copy.isFavorite = self.isFavorite
        copy.profilePicUrlString = self.profilePicUrlString
        copy.contactDetailsUrlString = self.contactDetailsUrlString
        copy.imageData = self.imageData
        return copy
    }
}
