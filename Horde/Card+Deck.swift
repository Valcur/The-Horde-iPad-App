//
//  Card+Deck.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation

class Card: Hashable, Identifiable {
    
    let id = UUID()
    let cardType: CardType
    let cardImage: String
    let hasFlashback: Bool
    @Published var cardCount: Int = 1
    
    init(cardType: CardType, cardImage: String, hasFlashback: Bool = false){
        self.cardType = cardType
        self.cardImage = cardImage
        self.hasFlashback = hasFlashback
        
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
        return lhs.cardImage == rhs.cardImage
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardImage)
    }
}

struct CardsToCast {
    var cardsFromCemetery: [Card]
    var tokensFromLibrary: [Card]
    var cardFromLibrary: Card
}

enum CardType {
    case token
    case creature
    case enchantment
    case sorcery
    case instant
}
