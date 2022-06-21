//
//  Card+Deck.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation
import SwiftUI

class Card: Hashable, Identifiable {
    
    let id = UUID()
    let cardName: String
    let cardType: CardType
    let cardImageURL: String
    var cardUIImage: Image = Image("BackgroundTest")
    let hasFlashback: Bool
    @Published var cardCount: Int = 1
    
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", hasFlashback: Bool = false){
        self.cardType = cardType
        self.hasFlashback = hasFlashback
        self.cardName = cardName
        
        if cardImageURL == "get-on-scryfall" {
            self.cardImageURL = DeckManager.getScryfallImageUrl(name: cardName)
        } else {
            self.cardImageURL = cardImageURL
        }
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardName == rhs.cardName && lhs.cardType == rhs.cardType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardImageURL)
    }
}

struct CardsToCast {
    var cardsFromGraveyard: [Card]
    var tokensFromLibrary: [Card]
    var cardFromLibrary: Card
}

enum CardType {
    case token
    case creature
    case enchantment
    case artifact
    case sorcery
    case instant
}
