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
    @Published var cardUIImage: Image = Image("BlackBackground")
    var hasFlashback: Bool
    let specificSet: String
    let cardOracleId: String    // Unique id of a card but same for each reprints
    let cardId: String          // Unique id of card and unique between reprints
    @Published var cardCount: Int = 1
    
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", cardUIImage: Image = Image("BlackBackground"), hasFlashback: Bool = false, specificSet: String = "", cardOracleId: String = "", cardId: String = ""){
        self.cardType = cardType
        self.hasFlashback = hasFlashback
        self.cardUIImage = cardUIImage
        self.specificSet = specificSet.uppercased()
        self.cardOracleId = cardOracleId
        self.cardId = cardId
        
        // Remove after "//" in name, example : "Amethyst Dragon // Explosive Crystal" -> only keep Amethyst Dragon
        var cardNameString = ""
        if let index = cardName.range(of: " //")?.lowerBound {
            let substring = cardName[..<index]
            let string = String(substring)
            cardNameString = "\(string)"
        } else {
            cardNameString = "\(cardName)"
        }
        cardNameString = cardNameString.trimmingCharacters(in: .whitespacesAndNewlines)
        //self.cardName = "\(cardNameString)\(cardType == .token && !cardName.contains(specificSet) ?
        self.cardName = cardNameString
        
        if cardImageURL == "get-on-scryfall" {
            self.cardImageURL = Card.getScryfallImageUrl(id: cardId, specifiSet: specificSet)
        } else {
            self.cardImageURL = cardImageURL
        }
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.cardId == rhs.cardId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardId)
    }
    
    func recreateCard() -> Card {
        let tmpCard = Card(cardName: self.cardName, cardType: self.cardType, cardImageURL: self.cardImageURL, hasFlashback: self.hasFlashback, specificSet: self.specificSet, cardOracleId: self.cardOracleId, cardId: self.cardId)
        tmpCard.cardCount = self.cardCount
        tmpCard.cardUIImage = self.cardUIImage
        return tmpCard
    }
    
    // NEED CHANGE TO USE getUrlCardName
    static func getScryfallImageUrl(name: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        //let cardNameForUrl = name.replacingOccurrences(of: " ", with: "+")
        let cardNameForUrl = name
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "") // Maybe "-" instead of "" ?????
            .replacingOccurrences(of: "'", with: "")
        var url = "https://api.scryfall.com/cards/named?exact=\(cardNameForUrl)&format=img&version=\(cardResolution)"
        // Example https://api.scryfall.com/cards/named?exact=Zombie+Giant&format=img&version=normal

        if specifiSet != "" {
            url.append("&set=\(specifiSet)")
        }
        print(url)
        return url
    }
    
    static func getScryfallImageUrl(id: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        let url = "https://api.scryfall.com/cards/\(id)?format=img&version=\(cardResolution)"

        print(url)
        return url
    }
    
    static func emptyCard() -> Card {
        return Card(cardName: "Polyraptor", cardType: .token)
    }
    
    func getUrlCardName() -> String {
        var cardNameForUrl = self.cardName
        /*
        if self.cardType == .token {
            cardNameForUrl = cardNameForUrl
                .replacingOccurrences(of: " \(self.specificSet)", with: "")
        }*/
        
        cardNameForUrl = cardNameForUrl
            .replacingOccurrences(of: " ", with: "-")
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: "'", with: "")
            
        
        return cardNameForUrl
    }
}

class CardFromCardSearch: Card {
    let manaCost: String
    
    init(cardName: String, cardType: CardType, cardImageURL: String = "get-on-scryfall", cardUIImage: Image = Image("BlackBackground"), hasFlashback: Bool = false, specificSet: String = "", cardOracleId: String = "", cardId: String = "", manaCost: String){
        self.manaCost = manaCost
        super.init(cardName: cardName, cardType: cardType, cardImageURL: cardImageURL, cardUIImage: cardUIImage, hasFlashback: hasFlashback, specificSet: specificSet, cardOracleId: cardOracleId, cardId: cardId)
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
