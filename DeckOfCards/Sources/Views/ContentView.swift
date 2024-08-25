//
//  ContentView.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import SwiftUI

/*
 
 
 Create an iOS/Android application that plays the card game "War".
 Rules for War:
 
 all cards in a deck are dealt out to the players. each player has a "battle won" counter
 players do not look at their hand
 players draw a card.
 player with the highest card wins and takes both cards. The "battle won" counter goes up for that player
 play ends when a player has won 10 battles.
 Design of app:
 
 Users should be able to specify the number of players for the game (up to 4)
 All cards in deck get shuffled and sent to the "players" piles.
 Press a button to play the round.
 A random card from each pile is played, the highest card wins.
 If there's a tie between cards, the person with the most cards in their pile wins, and if there's a tie there a random player gets the cards.
 Please find attached file for the API spec which you should follow for the SDK.  It is in OpenAPI3.
 
 */

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = DeckGameViewModel()
    @State var numberOfPlayers: Int
    
    init(numberOfPlayers: Int) {
        self.numberOfPlayers = numberOfPlayers
    }
    
    var body: some View {
        VStack {
            Stepper("Number of Players: \(numberOfPlayers)", value: $numberOfPlayers, in: 2...4)
            
            Button("Start Game") {
                viewModel.startGame(numberOfPlayers: numberOfPlayers)
            }
            
            Button("Play Round") {
                viewModel.playRound()
            }
            
            List(viewModel.players) { player in
                Text("Player \(player.id): \(player.battlesWon) battles won")
            }
        }
        .padding()
    }
}


#Preview {
    ContentView(numberOfPlayers: Constants.defaultPlayers)
}
