//
//  Networking.swift
//  Dota Heroes
//
//  Created by Ferdinand on 31/07/20.
//  Copyright © 2020 Tiket.com. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class Networking {
    
    static let genericError = "Something went wrong. Please try again later!"
    
    public init() {}
    
    func getRequestData<T: Decodable>(urlRequest: String,
                                      headers: [String: String] = [:],
                                      parameters: [String: String] = [:],
                                      successHandler: @escaping (T) -> Void,
                                      errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler("Network Error: \(Networking.genericError)")
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(Networking.genericError)
                }
                
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    return successHandler(responseObject)
                }
            }
            
            errorHandler("Parsing Error: \(Networking.genericError)")
        }
        
        guard var components = URLComponents(string: urlRequest) else {
            return errorHandler("Unable to create URL from given string")
        }

        components.queryItems = parameters.map {(key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    func post<T: Encodable, U: Decodable>(urlString: String,
                            body: T,
                            headers: [String: String] = [:],
                            successHandler: @escaping (U) -> Void,
                            errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                errorHandler(error.localizedDescription)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                
                guard let data = data else {
                    print("Unable to parse the response in given type \(U.self)")
                    return errorHandler(Networking.genericError)
                }
                
                if let responseObject = try? JSONDecoder().decode(U.self, from: data) {
                    return successHandler(responseObject)
                }
            }
            
            errorHandler(Networking.genericError)
        }
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 90
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        guard let data = try? JSONEncoder().encode(body) else {
            return errorHandler("Cannot encode given object into Data")
        }
        print(String(data: data, encoding: .utf8)!)
        request.httpBody = data
        URLSession.shared
            .uploadTask(with: request,
                        from: data,
                        completionHandler: completionHandler)
            .resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
