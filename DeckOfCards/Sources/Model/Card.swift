//
//  Card.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation

struct Card: Decodable, Identifiable {
    let id: String // Unique identifier for each card
    let value: String
    let suit: String
}
