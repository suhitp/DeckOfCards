//
//  File.swift
//  
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public typealias HTTPHeaders = [String: String]
public typealias RequestBody = Data

// MARK: Public definitions
public protocol Endpoint {
    /// Base URL string
    var baseURLString: String { get }
    /// Request body. Default is *nil*
    var httpBody: RequestBody? { get }
    /// Request method: GET, POST, PUT, DELETE. Default is GET
    var httpMethod: HTTPMethod { get }
    /// Request headeers. Default is EMPTY
    var heаders: [String: String] { get }
    /// URL path. *Important* should always start with forward slash. Leave it empty if not relevant
    var path: String { get }
    /// URL query parameters. Default is *nil*
    var query: [String: CustomStringConvertible?]? { get }
    /// Request timeout. Default is 30 seconds
    var timeoutInterval: TimeInterval { get }
    /// Request cache policy. Default is *.useProtocolCachePolicy*
    var cachePolicy: URLRequest.CachePolicy { get }
}

// MARK: Set up defaults & sending requests
public extension Endpoint {
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var httpBody: RequestBody? { nil }
    
    var heаders: [String: String] { [:] }
    
    var query: [String: CustomStringConvertible?]? { nil }
    
    var timeoutInterval: TimeInterval { 30 }
    
    var cachePolicy: URLRequest.CachePolicy { .useProtocolCachePolicy }
}

