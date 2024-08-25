//
//  DeckEndpoint.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 26/08/24.
//

import Networking
import Foundation

enum DeckEndpoint: Endpoint {
    
    case shuffle(count: Int)
    case draw(deckId: String, count: Int)
    
    // Mark :- Endpoint Protocol
    
    var baseURLString: String { APIConstants.baseURL }
    
    var path: String {
        switch self {
            case .shuffle(let count):
                return "/new/shuffle/?deck_count=\(count)"
            case .draw(let deckId, let count):
                return "/\(deckId)/draw/?count=\(count)"
        }
    }
}
