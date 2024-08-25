//
//  DeckResponse.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation

struct DeckResponse: Codable {
    let deckId: String
}

struct CardsResponse: Decodable {
    let cards: [Card]
}
