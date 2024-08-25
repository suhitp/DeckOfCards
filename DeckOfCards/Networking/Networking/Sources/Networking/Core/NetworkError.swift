//
//  File.swift
//  
//
//  Created by SUHIT PATIL on 26/08/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case emptyResponseData
    case invalidURL
    case decodingError(DecodingError)
    case encodingError(EncodingError)
    case serverError(statusCode: Int, payload: Data?)
    case unexpectedError(Error)
}
