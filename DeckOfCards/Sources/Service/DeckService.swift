//
//  DeckService.swift
//  DeckOfCards
//
//  Created by SUHIT PATIL on 25/08/24.
//

import Foundation
import Networking

protocol DeckAPIService: AnyObject {
    func shuffleDeck() async throws -> String
    func drawCards(deckId: String) async throws -> [Card]
}

final class DeckNetworkRepository: DeckAPIService {
    
    private let networkClient: NetworkService
    
    init(networkClient: NetworkService = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func shuffleDeck() async throws -> String {
        let endpoint = DeckEndpoint.shuffle(count: APIConstants.deckCount)
        let deckResponse = try await networkClient.dataRequest(for: endpoint, responseType: DeckResponse.self)
        return deckResponse.deckId
    }
    
    func drawCards(deckId: String) async throws -> [Card] {
        let endpoint = DeckEndpoint.draw(deckId: deckId, count: APIConstants.cardsCount)
        let cardResponse = try await networkClient.dataRequest(for: endpoint, responseType: CardsResponse.self)
        return cardResponse.cards
    }
}
