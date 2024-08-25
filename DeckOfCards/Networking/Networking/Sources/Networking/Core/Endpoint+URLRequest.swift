//
//  File.swift
//  
//
//  Created by SUHIT PATIL on 26/08/24.
//

import Foundation

extension Endpoint {
    
    func makeURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURLString) else {
            throw NetworkError.invalidURL
        }
        
        urlComponents.queryItems = query?.map { key, value in
            URLQueryItem(name: key, value: value?.description)
        }
        
        urlComponents.path = path
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        heаders.forEach { (header: String, value: String) in
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        return request
    }
}
