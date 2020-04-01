//
//  CustomError.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case badUrlRequest
    case badParamRequest
    case badResponse
    case serverError
    case noInternet
    case unknown
}

extension CustomError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .unknown, .serverError:
            return NSLocalizedString("Something went wrong. Please try again later.", comment: "Error")
        case .badResponse:
            return NSLocalizedString("Response is not in appropriate format.", comment: "Bad Response")
        case .badParamRequest, .badUrlRequest:
            return NSLocalizedString("Unable to create url request.", comment: "Invalid Request")
        case .noInternet:
            return NSLocalizedString("Please check your internet connetion.", comment: "No Internet")
        }
    }
}
