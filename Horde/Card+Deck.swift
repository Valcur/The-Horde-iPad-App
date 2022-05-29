//
//  Card+Deck.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation

class Card: Hashable, Identifiable {
    
    let id = UUID()
    let cardName: String
    let cardType: CardType
    let cardImage: String
    let hasFlashback: Bool
    @Published var cardCount: Int = 1
    
    init(cardName: String, cardType: CardType, cardImage: String = "get-on-scryfall", hasFlashback: Bool = false){
        self.cardType = cardType
        self.hasFlashback = hasFlashback
        self.cardName = cardName
        
        if cardImage == "get-on-scryfall" {
            self.cardImage = DeckManager.getScryfallImageUrl(name: cardName)
        } else {
            self.cardImage = cardImage
        }
        
        // We make a unique Int from the url for faster comparison between cards (instead of comparing url)
        /*let cardStringLength = 8 // Size
        let cardStringInUrl = String(cardImage.suffix(cardStringLength + 4).prefix(cardStringLength))
        var cardNumberTmp: CLongLong = 1
        for char in cardStringInUrl {
            cardNumberTmp += CLongLong(char.hexDigitValue ?? 0) * cardNumberTmp
        }
        print("my number is \(cardNumberTmp)")*/
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardName == rhs.cardName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardImage)
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
