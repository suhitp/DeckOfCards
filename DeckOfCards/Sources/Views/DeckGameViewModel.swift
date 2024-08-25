//
//  DeckGameViewModel.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation

class DeckGameViewModel: ObservableObject {
    
    private var deckService: DeckAPIService
    @Published var players: [Player] = []
    @Published var winningPlayer: Player?
    
    init(deckService: DeckAPIService = DeckNetworkRepository()) {
        self.deckService = deckService
    }
    
    func startGame(numberOfPlayers: Int) {
        Task {
            do {
                let deckID = try await deckService.shuffleDeck()
                try await dealCards(to: numberOfPlayers, deckId: deckID)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func dealCards(to numberOfPlayers: Int, deckId: String) async throws {
        let cards = try await deckService.drawCards(deckId: deckId)
        self.players = (0..<numberOfPlayers).map { Player(id: $0) }
        for (index, card) in cards.enumerated() {
            self.players[index % numberOfPlayers].pile.append(card)
        }
    }
    
    // Function to play a round
    func playRound() {
        guard !players.isEmpty else { return }
        
        // Draw one card from each player's pile
        var drawnCards: [(player: Player, card: Card)] = []
        
        for var player in players {
            if let card = player.pile.first {
                drawnCards.append((player, card))
                player.pile.removeFirst()
            }
        }
        
        // Determine the winner of the round
        if var winningCard = drawnCards.max(by: { $0.card.value < $1.card.value }) {
            winningCard.player.battlesWon += 1
            // Add drawn cards to the winner's pile
            winningCard.player.pile.append(contentsOf: drawnCards.map { $0.card })
        }
        
        // Check for ties and handle accordingly
        let maxCards = drawnCards.map { $0.card.value }.max()
        let winners = drawnCards.filter { $0.card.value == maxCards }
        if winners.count > 1 {
            // Handle tie by checking pile size or randomly
            let maxPileSize = winners.map { $0.player.pile.count }.max()
            var finalWinner = winners.filter { $0.player.pile.count == maxPileSize }.randomElement()
            finalWinner?.player.battlesWon += 1
            finalWinner?.player.pile.append(contentsOf: drawnCards.map { $0.card })
        }
        
        // Check if a player has won 10 battles
        if let player = players.first(where: { $0.battlesWon >= 10 }) {
            print("Player \(player.id) wins the game!")
            winningPlayer = player
        }
    }
}
