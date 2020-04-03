//
//  EndPoints.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Contacts: Endpoint {
        case fetch
        case add
        case edit(String)
        case favourite(String)
        public var path: String {
            switch self {
            case .fetch, .add: return "/contacts.json"
            case .edit(let contactId), .favourite(let contactId): return "/contacts/\(contactId).json"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch, .add, .favourite(_), .edit(_): return "\(EnvironmentURL.baseUrl)\(path)"
            }
        }
    }
}
