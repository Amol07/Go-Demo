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
    case mailConfigError
    case invalidPhoneNo
    case invalidEmail
    case invalidContact
    case invalidFirstName
    case invalidLastName
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
        case .mailConfigError:
            return NSLocalizedString("Please configure your device for sending emails.", comment: "Mail Configuartion Error")
        case .invalidPhoneNo:
        return NSLocalizedString("Phone number is not valid.", comment: "Phone Error")
        case .invalidEmail:
        return NSLocalizedString("Email Id is not valid.", comment: "Email Error")
        case .invalidContact:
        return NSLocalizedString("Unable to process your request due to invalid contact.", comment: "Error")
        case .invalidFirstName:
        return NSLocalizedString("First name cannot be left blank.", comment: "Error")
        case .invalidLastName:
        return NSLocalizedString("Last name cannot be left blank.", comment: "Error")
        }
    }
}
