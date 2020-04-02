//
//  Contact.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class Contact: Decodable {
    
    var contactId: Int?
    var firstName: String = ""
    var lastName: String = ""
    var profilePicUrlString: String?
    var contactDetailsUrlString: String?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case contactId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrlString = "profile_pic"
        case isFavorite = "favorite"
        case contactDetailsUrlString = "url"
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
