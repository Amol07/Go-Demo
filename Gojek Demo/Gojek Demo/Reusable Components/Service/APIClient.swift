//
//  APIClient.swift
//  Gojek Demo
//
//  Created by Amol Prakash on 02/04/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class APIClient<T: Decodable> {
    
    public typealias Json = [String : AnyHashable]
    public typealias Completion = (_ response :T?, _ error: CustomError?) -> Void
    
    static func clientRequest(with url: String,
                              params: Json? = nil,
                              type: HTTPMethodType = .get,
                              completionHandler: @escaping Completion)
    {
        guard Reachability.isConnectedToNetwork() else {
            completionHandler(nil, .noInternet)
            return
        }
        
        guard let url = URL(string: url) else {
            completionHandler(nil, .badUrlRequest)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.addValue(ContentType.applicationJson,
                         forHTTPHeaderField: HTTPHeaderField.contentType)
        
        if (type == .post || type == .put), let params = params {
            do {
                let body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = body
            } catch {
                completionHandler(nil, .badParamRequest)
            }
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, resp: URLResponse?, err: Error?) in
            DispatchQueue.main.async {
                if let _ = err {
                    completionHandler(nil, .serverError)
                } else {
                    guard let data = data, let response = try? JSONDecoder().decode(T.self, from: data) else {
                        completionHandler(nil, .badResponse)
                        return
                    }
                    completionHandler(response, nil)
                }
            }
        }
        task.resume()
    }
}

enum HTTPMethodType : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    
    init(type: String) {
        guard let type = HTTPMethodType(rawValue: type) else {
            fatalError("Invalid MethodType, Please implement this type")
        }
        self = type
    }
}

enum HTTPHeaderField {
    static let contentType = "Content-Type"
}

enum ContentType {
    static let applicationJson = "application/json"
}

enum EnvironmentURL {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
}
