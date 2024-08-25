//
//  Player.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation

struct Player: Identifiable {
    let id: Int
    var battlesWon: Int = 0
    var pile: [Card] = []
}
