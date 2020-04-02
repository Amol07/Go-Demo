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
        public var path: String {
            switch self {
            case .fetch: return "contacts.json"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(EnvironmentURL.baseUrl)\(path)"
            }
        }
    }
}
