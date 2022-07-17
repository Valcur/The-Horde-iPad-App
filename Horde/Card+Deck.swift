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
    var cardType: CardType // Can be changed in deckeditor
    let cardImageURL: String
    var cardUIImage: Image = Image("BackgroundTest")
    var hasFlashback: Bool
    let specificSet: String
    @Published var cardCount: Int = 1
    
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", cardUIImage: Image = Image("MTGBackground"), hasFlashback: Bool = false, specificSet: String = ""){
        self.cardType = cardType
        self.hasFlashback = hasFlashback
        self.cardUIImage = cardUIImage
        self.specificSet = specificSet.uppercased()
        
        // Remove after "//" in name, example : "Amethyst Dragon // Explosive Crystal" -> only keep Amethyst Dragon
        var cardNameString = ""
        if let index = cardName.range(of: " //")?.lowerBound {
            let substring = cardName[..<index]
            let string = String(substring)
            cardNameString = "\(string)"
        } else {
            cardNameString = "\(cardName)"
        }
        self.cardName = "\(cardNameString)\(cardType == .token ? " \(specificSet.uppercased())" : "")"
        
        if cardImageURL == "get-on-scryfall" {
            self.cardImageURL = Card.getScryfallImageUrl(name: cardName, specifiSet: specificSet)
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
    
    func recreateCard() -> Card {
        let tmpCard = Card(cardName: self.cardName, cardType: self.cardType, cardImageURL: self.cardImageURL, hasFlashback: self.hasFlashback)
        tmpCard.cardCount = self.cardCount
        tmpCard.cardUIImage = self.cardUIImage
        return tmpCard
    }
    
    static func getScryfallImageUrl(name: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        //let cardNameForUrl = name.replacingOccurrences(of: " ", with: "+")
        let cardNameForUrl = name
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "'", with: "")
        var url = "https://api.scryfall.com/cards/named?exact=\(cardNameForUrl)&format=img&version=\(cardResolution)"
        // Example https://api.scryfall.com/cards/named?exact=Zombie+Giant&format=img&version=normal

        if specifiSet != "" {
            url.append("&set=\(specifiSet)")
        }
        print(url)
        return url
    }
}

class CardFromCardSearch: Card {
    let manaCost: String
    
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", cardUIImage: Image = Image("BlackBackground"), hasFlashback: Bool = false, specificSet: String = "", manaCost: String){
        self.manaCost = manaCost
        super.init(cardName: cardName, cardType: cardType, cardImageURL: cardImageURL, cardUIImage: cardUIImage, hasFlashback: hasFlashback, specificSet: specificSet)
    }
    
    // From {3}{R}{W} to ["3", "R", "W"]
    func getManaCostArray() -> [String] {
        if self.manaCost == "" {
            return []
        }
        var tmpString = self.manaCost.replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: " -- ", with: "{//}")
        tmpString.removeLast()
        tmpString.removeFirst()
        return tmpString.components(separatedBy: "}{")
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

struct DeckEditorCardList {
    var deckList: MainDeckList
    var tooStrongPermanentsList: [Card]
    var availableTokensList: [Card]
    var weakPermanentsList: [Card]
    var powerfullPermanentsList: [Card]
}

struct MainDeckList {
    var creatures: [Card]
    var tokens: [Card]
    var instantsAndSorceries: [Card]
    var artifactsAndEnchantments: [Card]
}
