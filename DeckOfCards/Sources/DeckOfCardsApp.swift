//
//  DeckOfCardsApp.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import SwiftUI

@main
struct DeckOfCardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(numberOfPlayers: Constants.defaultPlayers)
        }
    }
}
