//
//  DeckManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
import SwiftUI
 
struct DeckManager {
    
    static func getDeckForId(deckPickedId: Int, difficulty: Int) -> ([Card], [Card], [Card], [Card], [Card]) {
        let deckData: String = UserDefaults.standard.object(forKey: "Deck_\(deckPickedId)") as? String ?? ""
        return createDeckListFromDeckData(deckData: deckData, tokenMultiplicator: difficulty)
    }
    
    static func createDeckListFromDeckData(deckData: String, tokenMultiplicator: Int) -> ([Card], [Card], [Card], [Card], [Card]){
        var deck = DeckEditorCardList(deckList: MainDeckList(creatures: [], tokens: [], instantsAndSorceries: [], artifactsAndEnchantments: []), tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
        
        if deckData != "" {
            let allLines = deckData.components(separatedBy: "\n")
            var selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.deckList
            
            for line in allLines {
                if line.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    // Change current decklist to add cards to
                    if line == DeckEditorViewModel.DeckDataPattern.deck {
                        selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.deckList
                    } else if line == DeckEditorViewModel.DeckDataPattern.tooStrong {
                        selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList
                    } else if line == DeckEditorViewModel.DeckDataPattern.availableTokens {
                        selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.availableTokensList
                    } else if line == DeckEditorViewModel.DeckDataPattern.weakPermanents {
                        selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList
                    } else if line == DeckEditorViewModel.DeckDataPattern.powerfullPermanents {
                        selectedDeckListNumber = DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList
                    } else
                    {
                        // Or add card if its a card
                        let cardDataArray = line.components(separatedBy: " ")
                        
                        let cardCount = Int(cardDataArray[0]) ?? 0
                        var cardName = cardDataArray[4]
                        for i in 5..<cardDataArray.count - 2 {
                            cardName += " " + cardDataArray[i]
                        }
                        
                        let cardEffects = DeckEditorViewModel.getCardSpecialEffects(effects: cardDataArray[3])
                        let cardId = cardDataArray.last ?? ""
                        
                        
                        let cardIds = cardId.components(separatedBy: "://:")
                        let frontUrl = DeckManager.imageUrlFromCustomId(cardIds[0])
                        let backUrl = DeckManager.imageUrlFromCustomId(cardIds.count >= 2 ? cardIds[1] : "")
     
                        let card = Card(cardName: cardName, cardType: getCardTypeFromTypeLine(typeLine: cardDataArray[2]), cardImageURL: frontUrl, cardBackImageURL: backUrl, hasFlashback: cardEffects.0, hasDefender: cardEffects.1, specificSet: cardDataArray[1], cardOracleId: cardDataArray[cardDataArray.count - 2], cardId: cardId)
                        
                        card.cardCount = cardCount
                        deck = addCardToSelectedDeck(card: card, selectedDeckListNumber: selectedDeckListNumber, deckList: deck)
                    }
                }
            }
        }
        
        var hordeDeck = deck.deckList.creatures + deck.deckList.instantsAndSorceries + deck.deckList.artifactsAndEnchantments
        for _ in 0..<tokenMultiplicator {
            hordeDeck += deck.deckList.tokens
        }
        hordeDeck = hordeDeck.shuffled()
        
        let availableTokens = deck.availableTokensList
        let lateGameCards = deck.tooStrongPermanentsList
        let weakPermanents = deck.weakPermanentsList
        let powerfullPermanents = deck.powerfullPermanentsList
        
        return (hordeDeck, availableTokens, lateGameCards, weakPermanents, powerfullPermanents)
    }
    
    static func imageUrlFromCustomId(_ cardId: String) -> String {
        if cardId.contains("https://i.imgur") {
            return cardId
        } else if cardId.contains("D::") {
            return "https://media.discordapp.net/attachments/1127961672225673256/" + cardId.dropFirst(3) + "?width=488&height=680"
        }
        return "get-on-scryfall"
    }
    
    private static func addCardToSelectedDeck(card: Card, selectedDeckListNumber: Int, deckList: DeckEditorCardList) -> DeckEditorCardList {
        var deck = deckList
        if selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.deckList
        {
            if card.cardType == .creature {
                deck.deckList.creatures = addCardToDeck(card: card, deck: deck.deckList.creatures)
            } else  if card.cardType == .token {
                deck.deckList.tokens = addCardToDeck(card: card, deck: deck.deckList.tokens)
                if deck.availableTokensList.contains(card) == false {
                    deck.availableTokensList = addCardToDeck(card: card, deck: deck.availableTokensList, onlyAddOne: true)
                }
            } else if card.cardType == .instant || card.cardType == .sorcery {
                deck.deckList.instantsAndSorceries = addCardToDeck(card: card, deck: deck.deckList.instantsAndSorceries)
            } else {
                deck.deckList.artifactsAndEnchantments = addCardToDeck(card: card, deck: deck.deckList.artifactsAndEnchantments)
            }
        }
        else if selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList
        {
            deck.tooStrongPermanentsList = addCardToDeck(card: card, deck: deck.tooStrongPermanentsList)
        }
        else if selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.availableTokensList
        {
            deck.availableTokensList = addCardToDeck(card: card, deck: deck.availableTokensList)
        }
        else if selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList
        {
            deck.weakPermanentsList = addCardToDeck(card: card, deck: deck.weakPermanentsList)
        }
        else if selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList
        {
            deck.powerfullPermanentsList = addCardToDeck(card: card, deck: deck.powerfullPermanentsList)
        }
        
        return deck
    }
    
    static func getCardTypeFromTypeLine(typeLine: String) -> CardType {
        if typeLine.contains("oken") {
            return CardType.token
        } else if typeLine.contains("reature") {
            return CardType.creature
        } else if typeLine.contains("nchantment") {
            return CardType.enchantment
        } else if typeLine.contains("rtifact") {
            return CardType.artifact
        } else if typeLine.contains("orcery") {
            return CardType.sorcery
        } else if typeLine.contains("nstant") {
            return CardType.instant
        }
        return CardType.enchantment
    }
    
    private static func addCardToDeck(card: Card, deck: [Card], onlyAddOne: Bool = false) -> [Card] {
        let tmpCard = card.recreateCard()
        tmpCard.cardCount = 1
        var tmpDeck = deck
        if onlyAddOne {
            tmpDeck.append(tmpCard)
        } else {
            for _ in 0..<card.cardCount {
                tmpDeck.append(tmpCard.recreateCard())
            }
        }
        return tmpDeck
    }
    
    static func createStarterDecks() {
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.zombie)_Exist") as? Bool ?? false) {
            createZombieDeck(deckId: DecksId.zombie)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.human)_Exist") as? Bool ?? false) {
            createHumanDeck(deckId: DecksId.human)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.dinosaur)_Exist") as? Bool ?? false) {
            createDinosaurDeck(deckId: DecksId.dinosaur)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.nature)_Exist") as? Bool ?? false) {
            createNatureDeck(deckId: DecksId.nature)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.sliver)_Exist") as? Bool ?? false) {
            createSliverDeck(deckId: DecksId.sliver)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.phyrexian)_Exist") as? Bool ?? false) {
            createPhyrexianDeck(deckId: DecksId.phyrexian)
        }
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.eldrazi)_Exist") as? Bool ?? false) {
            createEldraziDeck(deckId: DecksId.eldrazi)
        }
    }
    
    static func createHumanDeck(deckId: Int) {
        let deckName = "Human"
        let deckIntro = "A modified version of the Armies of Men deck by TenkayCrit.\nArt by Antonio José Manzanedo"
        let deckRules = "All creatures controlled by the Horde have haste and are Humans in addition to their other creature types. All tokens controlled by the Horde are white"
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Human")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createZombieDeck(deckId: Int) {
        let deckName = "Zombie"
        let deckIntro = "The original horde deck by Peter Knudson\nArt by Grzegorz Rutkowski"
        let deckRules = "All creatures controlled by the Horde have haste"
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Zombie")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createDinosaurDeck(deckId: Int) {
        let deckName = "Dinosaur"
        let deckIntro = "A modified version of the Dinosaur Rage deck by TenkayCrit\nArt by Grzegorz Rutkowski"
        let deckRules = "All creatures controlled by the Horde have haste."
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Dinosaur")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createPhyrexianDeck(deckId: Int) {
        let deckName = "Phyrexian"
        let deckIntro = "A modified version of the Phyrexian Perfection deck by TenkayCrit\nArt by Igor Kieryluk"
        let deckRules = "All creatures controlled by the Horde have haste. The Survivors share poison counters. They do not lose the game for having 10 or more poison counters. Every time the Survivors gain one or more poison counters, each Survivor exiles 1 card from the top of each of their libraries face down for each poison counter."
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Phyrexian")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createSliverDeck(deckId: Int) {
        let deckName = "Sliver"
        let deckIntro = "A modified version of the Sliver Hive deck by TenkayCrit\nArt by Aleksi Briclot"
        let deckRules = "All creatures controlled by the Horde have haste. All of the artifact slivers in the Horde deck are treated as tokens."
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Sliver")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createNatureDeck(deckId: Int) {
        let deckName = "Nature"
        let deckIntro = "Art by Grzegorz Rutkowski"
        let deckRules = "All tokens controlled by the Horde have haste."
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Nature")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createEldraziDeck(deckId: Int) {
        let deckName = "Eldrazi"
        let deckIntro = "A modified version of the Eldrazi Horror deck by TenkayCrit\nArt by Aleksi Briclot"
        let deckRules = "All tokens controlled by the Horde have haste. All eldrazi spawn the Horde controls cannot attack or block. If the Horde controls 10 eldrazi spawn at the start of its precombat main phase, they are sacrificed, and the Horde casts the three eldrazi titans from exile."
        
        let deckData = readDeckDataFromFile(fileName: deckName)

        let deckImage = UIImage(named: "Eldrazi")
        
        createDeck(deckId: deckId, deckName: deckName, deckData: deckData, deckIntro: deckIntro, deckRules: deckRules, deckImage: deckImage!)
    }
    
    static func createDeck(deckId: Int, deckName: String, deckData: String, deckIntro: String, deckRules: String, deckImage: UIImage) {
        UserDefaults.standard.set(true, forKey: "Deck_\(deckId)_Exist")
        UserDefaults.standard.set(deckName, forKey: "Deck_\(deckId)_DeckName")
        UserDefaults.standard.set(deckIntro, forKey: "Deck_\(deckId)_Intro")
        UserDefaults.standard.set(deckRules, forKey: "Deck_\(deckId)_Rules")
        UserDefaults.standard.set(deckData, forKey: "Deck_\(deckId)")
        
        guard let data = deckImage.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "Deck_\(deckId)_Image")
    }
    
    private static func readDeckDataFromFile(fileName: String) -> String {

        if let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if(exists){
                let content = fm.contents(atPath: path)
                let contentAsString = String(data: content!, encoding: String.Encoding.utf8)
                return contentAsString!
            }
        }
        return ""
    }
    
    static func shareOnDiscord(deckName: String, deckList: String) -> [Any] {
        let text = deckList
        let textData = text.data(using: .utf8)
        let textURL = textData?.dataToFile(fileName: "\(deckName).txt")
        var filesToShare = [Any]()
        filesToShare.append(textURL!)
        
        return filesToShare
    }
}
