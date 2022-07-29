//
//  DeckManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
import SwiftUI
 
struct DeckManager {
    /*
    static private func getEldraziDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
   
        
        // 1 All Is Dust
        deck.append(Card(cardName: "All Is Dust", cardType: .sorcery))
        
        // 1 Awakening Zone
        deck.append(Card(cardName: "Awakening Zone", cardType: .enchantment))
        
        // 1 Bane of Bala Ged
        deck.append(Card(cardName: "Bane of Bala Ged", cardType: .creature))
        
        // 1 Benthic Infiltrator
        deck.append(Card(cardName: "Benthic Infiltrator", cardType: .creature))
        
        // 1 Blisterpod
        deck.append(Card(cardName: "Blisterpod", cardType: .creature))
        
        // 1 Breaker of Armies
        deck.append(Card(cardName: "Breaker of Armies", cardType: .creature))
        
        // 1 Brood Monitor
        deck.append(Card(cardName: "Brood Monitor", cardType: .creature))
        
        // 1 Chittering Host
        deck.append(Card(cardName: "Chittering Host", cardType: .creature))
        
        // 1 Culling Drone
        deck.append(Card(cardName: "Culling Drone", cardType: .creature))
        
        // 1 Dominator Drone
        deck.append(Card(cardName: "Dominator Drone", cardType: .creature))
        
        // 1 Dread Drone
        deck.append(Card(cardName: "Dread Drone", cardType: .creature))
        
        // 1 Eldrazi Aggressor
        deck.append(Card(cardName: "Eldrazi Aggressor", cardType: .creature))
        
        // 1 Eldrazi Devastator
        deck.append(Card(cardName: "Eldrazi Devastator", cardType: .creature))
        
        // 1 Emrakul's Hatcher
        deck.append(Card(cardName: "Emrakul's Hatcher", cardType: .creature))
        
        // 1 Essence Feed
        deck.append(Card(cardName: "Essence Feed", cardType: .sorcery))
        
        // 1 Eyeless Watcher
        deck.append(Card(cardName: "Eyeless Watcher", cardType: .creature))
        
        // 1 Flayer Drone
        deck.append(Card(cardName: "Flayer Drone", cardType: .creature))
        
        // 1 Hand of Emrakul
        deck.append(Card(cardName: "Hand of Emrakul", cardType: .creature))
        
        // 1 Hanweir, the Writhing Township
        deck.append(Card(cardName: "Hanweir, the Writhing Township", cardType: .creature))
        
        // 1 Incubator Drone
        deck.append(Card(cardName: "Incubator Drone", cardType: .creature))
        
        // 1 It That Betrays
        deck.append(Card(cardName: "It That Betrays", cardType: .creature))
        
        // 1 Kozilek's Predator
        deck.append(Card(cardName: "Kozilek's Predator", cardType: .creature))
        
        // 1 Kozilek's Sentinel
        deck.append(Card(cardName: "Kozilek's Sentinel", cardType: .creature))
        
        // 1 Nest Invader
        deck.append(Card(cardName: "Nest Invader", cardType: .creature))
        
        // 1 Pathrazer of Ulamog
        deck.append(Card(cardName: "Pathrazer of Ulamog", cardType: .creature))
        
        // 1 Pawn of Ulamog
        deck.append(Card(cardName: "Pawn of Ulamog", cardType: .creature))
        
        // 1 Rapacious One
        deck.append(Card(cardName: "Rapacious One", cardType: .creature))
        
        // 1 Reality Smasher
        deck.append(Card(cardName: "Reality Smasher", cardType: .creature))
        
        // 1 Ruination Guide
        deck.append(Card(cardName: "Ruination Guide", cardType: .creature))
        
        // 1 Scion Summoner
        deck.append(Card(cardName: "Scion Summoner", cardType: .creature))
        
        // 1 Sifter of Skulls
        deck.append(Card(cardName: "Sifter of Skulls", cardType: .creature))
        
        // 1 Skittering Invasion
        deck.append(Card(cardName: "Skittering Invasion", cardType: .sorcery))
        
        // 1 Swarm Surge
        deck.append(Card(cardName: "Swarm Surge", cardType: .sorcery))
        
        // 1 Tide Drifter
        deck.append(Card(cardName: "Tide Drifter", cardType: .creature))
        
        // 1 Ulamog's Crusher
        deck.append(Card(cardName: "Ulamog's Crusher", cardType: .creature))
        
        // 1 Vestige of Emrakul
        deck.append(Card(cardName: "Vestige of Emrakul", cardType: .creature))
        
        // 1 Vile Aggregate
        deck.append(Card(cardName: "Vile Aggregate", cardType: .creature))
        
        // 1 Desolation Twin
        deck.append(Card(cardName: "Desolation Twin", cardType: .creature))
        
        // 1 Void Winnower
        deck.append(Card(cardName: "Void Winnower", cardType: .creature))
        
        // 1 Witness the End
        deck.append(Card(cardName: "Witness the End", cardType: .sorcery))
        
        
        // 15 Eldrazi Horror (TEMN) 1
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")))
        }
        
        // 25 Eldrazi Scion (DDR) 71
        for _ in 1...(25 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")))
        }
        
        // 5 Eldrazi (TPCA) 1
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")))
        }
        
        // 15 Eldrazi Spawn (DDP) 76
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")),
            Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")),
            Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")),
            Card(cardName: "Eldrazi (TBFZ)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TBFZ")),
            Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")),
            Card(cardName: "Emrakul, the Aeons Torn", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Emrakul, the Aeons Torn", specifiSet: "ROE")),
            Card(cardName: "Kozilek, Butcher of Truth", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Kozilek, Butcher of Truth", specifiSet: "ROE")),
            Card(cardName: "Ulamog, the Infinite Gyre", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Ulamog, the Infinite Gyre", specifiSet: "ROE"))
        ]

        deck.shuffle()
        
        return (deck, tokens)
    }
    
*/
    
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
                        
                        let card = Card(cardName: cardName, cardType: getCardTypeFromTypeLine(typeLine: cardDataArray[2]), hasFlashback: cardDataArray[3] == DeckEditorViewModel.DeckDataPattern.cardHaveFlashback, specificSet: cardDataArray[1], cardOracleId: cardDataArray[cardDataArray.count - 2], cardId: cardDataArray.last ?? "")
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
        /*
        if !(UserDefaults.standard.object(forKey: "Deck_\(DecksId.eldrazi)_Exist") as? Bool ?? false) {
            createEldraziDeck(deckId: DecksId.eldrazi)
        }*/
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
    
    /*
    static func getRandomCardFromStarterPermanents(deckPickedId: Int) -> Card {
        

   
        
        var commonCards = [
            Card(cardName: "Ghostly Prison", cardType: .enchantment),
            Card(cardName: "Hissing Miasma", cardType: .enchantment),
            Card(cardName: "Authority of the Consuls", cardType: .enchantment),
            Card(cardName: "Glorious Anthem", cardType: .enchantment)
        ]
        
        switch deckPickedId {

        case DecksId.eldrazi:
            commonCards.append(Card(cardName: "Forsaken Monument", cardType: .artifact))
        default:
            commonCards = [
                Card(cardName: "Liliana's Mastery", cardType: .enchantment),
                Card(cardName: "Open the Graves", cardType: .enchantment),
                Card(cardName: "Graf Harvest", cardType: .enchantment),
                Card(cardName: "Hissing Miasma", cardType: .enchantment),
                Card(cardName: "Headless Rider", cardType: .creature)
            ]
        }
        
        return commonCards.randomElement()!
    }
    
    static func getRandomCardFromMidGamePermanents(deckPickedId: Int) -> Card {
        
       
        
        var commonCards = [
            Card(cardName: "Unnatural Growth", cardType: .enchantment),
            Card(cardName: "Collective Blessing", cardType: .enchantment),
            Card(cardName: "Levitation", cardType: .enchantment),
            Card(cardName: "Ethereal Absolution", cardType: .enchantment)
        ]
        
        switch deckPickedId {

        default:
            commonCards.append(Card(cardName: "Brisela, Voice of Nightmares", cardType: .creature))
        }
        
        return commonCards.randomElement()!
    }
    
    static func getStrongCardsListForDeck(deckPickedId: Int) -> [Card] {

        
        var cardArray: [Card] = []
        
        switch deckPickedId {

        default:

          

        
            cardArray.append(Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")))
        }
        return cardArray
    }*/
}





/*
 ZOMBIE
 
 ## Horde Deck ##
 1 5DN creature NO Blind Creeper 02d4c3a8-c733-45c1-bca5-51eed47c9230 86d5440a-7460-4b4f-a167-a6c4fb2d855e
 4 USG creature NO Cackling Fiend 2029954b-6fa7-40d7-bb19-d7534c62be5d ae410ae8-1e72-4727-96df-c7c195063fb5
 1 TOR creature NO Carrion Wurm ed0cf504-c365-4486-92bc-c329b83b99d0 37c2b228-94c0-4e84-ad6d-80b170bb6c0c
 1 MIC creature NO Death Baron 99024aa8-5687-4d38-8a4b-feef42d6c1ff 11641a17-e979-4edb-adba-789f21fd017d
 1 MIC creature NO Fleshbag Marauder 4b1bf05e-753e-4350-a913-894cf3cecc0c a03c738c-88d9-4cf6-a650-20ce6e5565bc
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 2 M19 creature NO Infectious Horror 0931206b-eed2-40d0-9496-5ecefc7f8f90 d17aaa92-10ca-4f70-b45e-5a51e9192efb
 3 PLS creature NO Maggot Carrier e4ad4b81-3685-4f95-84c0-755263b9d3b1 ab2c3dc4-bb49-4ec3-a6c8-4256d1939326
 2 MBS creature NO Nested Ghoul e60b6b71-eea8-42b3-81e2-c8fb1af5e218 c035ff58-9df3-4db4-b9d0-97d58080ecfe
 2 ISD creature NO Rotting Fensnake be22faba-07e0-4036-b700-82769989250b c21cbb10-9157-4887-a752-29b9e94fc77a
 2 10E creature NO Severed Legion 34a8a658-a5f6-406f-99d8-c32ea2e26202 82633f38-5af1-429e-8c9d-db536af85309
 1 TSP creature NO Skulking Knight 11e4c731-4212-4aad-891f-fe066ed0436f a7f7927b-64ae-4448-9540-8d7bbe88c9cc
 2 HOP creature NO Soulless One 27d98b94-a8a1-442b-8940-4ffab51b5164 410a214b-09c4-49bd-a461-3330d0249ae5
 1 ISD creature NO Unbreathing Horde e6cd9203-e4d3-4d9f-b59f-4e454fc5a477 1a91ea47-0c06-4333-a309-ac360c5cc9bd
 1 HOP creature NO Undead Warchief e6af56bf-bd78-4801-8f6e-033cdd68de3d 01482b0c-d05b-4356-9144-e044159f4dcb
 2 SCG creature NO Vengeful Dead 277c8ee9-0157-4e45-96ad-1b67716955ee 7c11c11d-9809-4031-8cbc-21aef07d7f1f
 1 ISD creature NO Walking Corpse fea95888-e16a-4209-9cd4-623f7f4d2f67 8e033384-3334-4082-9541-f2443d3bc424
 1 TSR creature NO Yixlid Jailer 1f55303e-1369-4e42-9ed4-36609887c7c1 3f2ef91f-d113-4e8d-a164-c6e261aa9c12

 2 GVL enchantment NO Bad Moon fc5d3341-cbce-49e5-93cc-8add92479dca 8f8a75da-ea3c-43e7-9d32-1c92f8ec0fd2
 1 M12 enchantment NO Call to the Grave db5a4c25-5ae5-4a04-be79-bdee39b9152c 5e1324b6-dba0-4aff-a403-a45d2b405f5b
 1 ISD enchantment NO Endless Ranks of the Dead 69d4ecac-4735-4667-bfc1-c8800b436d08 5db15c5f-80b7-4f7f-985a-9bbec3199ad9
 1 MIR enchantment NO Forsaken Wastes b9e61e68-9dc8-4295-95dc-dd66a0907c8c c9dbfc7c-164d-47b8-8f05-987864fca89b

 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 2 MM3 sorcery NO Delirium Skeins 7397036f-8114-47cc-b52f-c532a6845d16 64b0d9e7-4a0f-4f07-99ae-31c3c9f0037a
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f
 1 DDJ sorcery NO Twilight's Call ae0a1d9c-19cb-42ee-97c3-464e38e84615 a6e04dd2-75ad-4427-93cc-37226340c2fb

 5 TBBD token NO Zombie Giant e7bba04b-be75-4857-a724-c9e2150d56ad be7e26e1-5db6-49ba-a88e-c79d889cd364
 55 TMH2 token NO Zombie ddc8c973-c31e-463f-be45-f3fa7d632362 3031bec1-c6dc-441f-9391-458bb1577c56

 ## Too Strong ##
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f

 ## Available Tokens ##

 ## Weak Permanents ##
 1 EMN enchantment NO Graf Harvest d3ba6922-c2f7-45ab-87a3-d4bbd770d1ba fbc17697-9db9-41d4-aacf-b2f2e6ff80cf
 1 VOW creature NO Headless Rider d4fdacd7-3101-44e2-a880-dde7326137a4 c24018e8-b8f1-44a5-9355-8b79f363569d
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 MIC enchantment NO Liliana's Mastery bd104c7e-311e-4b03-98d3-5f20f3a99d26 a92ee6ec-eebf-40b4-9dd9-c0551e33f5ff
 1 MIC enchantment NO Open the Graves 28778958-a1f9-4fea-b551-c193d1257f18 130978d1-0b20-4dfa-85f5-3ff2bc2cfda3

 ## Powerfull Permanents ##
 1 DOM creature NO Josu Vess, Lich Knight 974a46f9-aa84-4b34-bee5-c635166e5841 6ed6d088-db82-4648-a109-0e3fa1421847
 1 ME4 creature NO Zombie Master 5446c92f-ff22-4e9b-a2f6-e64c8560c1e0 c25eb8c9-4209-4fe4-8b02-be16d7d7bdf5
 */

/*
 NATURE
 
 ## Horde Deck ##
 1 SOM creature NO Bellowing Tanglewurm a1091651-4e3e-4840-87e2-b80084770137 44eb3e3a-60ee-4293-a321-daa452d4c70d
 1 MRD creature NO Copperhoof Vorrac a5fed574-6ac3-4318-b0a6-27082e07f3bd 81fff4cc-b2ab-4a41-bede-0d807552ba46
 1 JMP creature NO Craterhoof Behemoth 8c52bd39-0586-48ca-b263-17210cf9feb6 44afd414-cc69-4888-ba12-7ea87e60b1f7
 1 RNA creature NO End-Raze Forerunners 69b52907-8aff-4f2a-a391-7d1ab2669b5c a50d79fe-6d37-42f3-b7b0-0c3018282fa2
 1 M19 creature NO Goreclaw, Terror of Qal Sisma befb211f-37ca-4083-98d4-9ff1f28be3f2 36d4574a-3266-4497-b145-fb25820d8a7f
 1 BBD creature NO Grothama, All-Devouring 34fd52c1-3d81-4005-b826-eeefbd7fd874 ab8935b1-ec87-4330-9952-9ef8cd344531
 1 C21 creature NO Hornet Queen 3b1f8108-6911-49e9-8f78-f950bb58cb6c d245cb84-56aa-47a1-aa3a-17ffded57e15
 1 MH1 creature YES Mother Bear fe742976-ef13-4c25-972f-254b1ed436de efae4d84-8134-461a-a352-a5bdff7259a7
 1 THB creature NO Nessian Boar 139a5f0b-6f76-4918-96e6-cdcf27253230 aaf91fc2-7317-47e4-9e6c-d7d74cdf0153
 1 AKH creature NO Rhonas the Indomitable 5d2acd3e-4782-42e3-bcd5-80f8b439cc28 50f23c47-278c-4188-8fb4-ae20a0c423c5
 1 DOM creature NO Steel Leaf Champion 666af637-9282-4121-962a-048e528f9221 24d8a688-79d4-49b9-ab0c-c7f5c9b551f4
 1 2XM creature NO Woodland Champion 675321d7-2cf0-4e0b-9517-d711b22865ab 021bc8f5-3992-4d6a-9806-ed43c89e99f2
 1 ELD creature NO Yorvo, Lord of Garenbrig 00a15abc-bdac-4977-90a0-f08d41941d01 ae2998a1-1713-467e-a08e-0efd8720aa5b

 3 TSR enchantment NO Gaea's Anthem 3754dce0-3e97-406f-8807-a4942a222c41 43febc63-597d-4392-b8ea-a00841148c45
 2 TSR enchantment NO Muraganda Petroglyphs e6eff050-f1f6-49ce-a92e-1d1e13e51084 b103cb22-93b2-4206-9f80-5f966155e07e
 1 AKH enchantment NO Sandwurm Convergence 429eff2b-635b-43f6-b20f-82e25992c0b9 e47bd2c5-e3db-4fde-a695-9e67a7e937be
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae

 1 DDS instant YES Beast Attack 3f5acd90-199c-4ed3-9c8a-eeac4670d876 011f805f-3ebb-4748-a5de-8a10b5f47dcd
 1 DDS sorcery YES Call of the Herd ee243f81-f51c-4d9a-a396-f7cef84b46c1 7ff0c182-f9ec-41d1-beb6-97d0eb1be592
 1 JUD sorcery YES Crush of Wurms 6c12cd05-b673-453c-9f6b-f3aa022467c1 32a924b3-3bd6-43ad-acbd-1303dd670db4
 2 ODY instant YES Elephant Ambush 09386931-59bd-481f-bccc-32e8a8abc0f9 b4abdf1c-a0a9-4e1d-b448-58742830f767
 1 C21 sorcery NO Ezuri's Predation d0dd425b-fdba-41b4-b9e6-f5161610bd7e 3103505c-b071-4ae9-bf82-978e582d030c
 1 M13 sorcery NO Fungal Sprouting 303d4533-0c6b-4f93-80e8-b1f5926f4cd4 97413ae3-037e-4786-85a3-e92604acd771
 2 VMA sorcery YES Grizzly Fate f3073e4f-ca7e-4fde-88a4-bd7b6ebfbc8c 004e1457-d951-4029-8bb6-17a290793e79
 1 AFC instant NO Heroic Intervention 24882fa2-3fe9-4c1b-aa3d-0e6488b9db27 c5e72882-dbf8-42d2-9a98-31f2f71e2ed9
 1 THB sorcery NO Klothys's Design 85c20c39-7b9c-4661-9372-e659b321773f b1b6b7a7-0ac8-470a-949b-4779ded95359
 1 CMA sorcery NO Overrun 204f9afe-c20b-4933-b5cd-aa572784762a 64033221-447f-4f8a-8fa0-c3ef30172602
 1 C19 sorcery NO Overwhelming Stampede e1e96802-fd0c-41f1-aa21-3287d75a0e88 50846a7b-d174-439e-9ffb-31b50bb3a84f
 1 TOR sorcery YES Parallel Evolution 963cfdbe-775c-4267-a617-66f10e9d7f4f 73cce010-a8e7-477b-9179-bbad38aa6438
 1 M13 sorcery NO Predatory Rampage ee6d271c-0728-4080-85bb-a6af05f8b213 3e054ea5-3657-4198-9715-6acc0e362da3
 1 DDS sorcery YES Roar of the Wurm b8b9e6fd-b3ed-4fbc-8753-74018fa33caa 51a0c80e-4ace-4a2a-8b96-4472d1be6872
 1 MH1 sorcery NO Scale Up 2fd025ef-14f5-4621-831d-dd12b7c604dd 3f2d9bae-2753-486c-be79-2438208ac353
 1 C19 instant NO Second Harvest 61a6341e-0d36-44b6-8026-9c87c8ef61cb 22b01c98-c24b-4255-921f-4820f3d395ea
 1 MID sorcery YES Shadowbeast Sighting f05d5632-0a82-45bf-b66e-22cf4080ed5e 1b12e978-4deb-4ccc-8ae6-462bc4598c90
 1 FRF instant NO Winds of Qal Sisma e7871b4d-a408-4377-beee-6b1d3c7dd57d 0c45d98d-b8bd-409d-bce9-d7d73be735a9

 20 TELD token NO Bear a62a374d-ccdd-418d-9bcd-5ca8bf9b05e8 b0f09f9e-e0f9-4ed8-bfc0-5f1a3046106e
 10 TMH2 token NO Beast 695b14a0-920a-47bd-bd4a-7989862cdd0a a1eff7f8-b645-41cb-bcd9-3dc1ab10200e
 10 TUST token NO Elemental 3387629a-f3c6-4dea-8bad-d938b611ced8 70f1f745-9fc2-41a6-9d39-fb4964595cf5
 3 TKHC token NO Elemental ab19c684-94c6-4491-8a6b-7f31dddadae6 7737cbbf-659e-4a8d-9918-50652d6c0863
 12 TCMR token NO Elephant 079c46cc-feb0-4998-8593-c8b739afdb82 8c4d495a-b4b7-4119-ae2d-5b602a0b309f
 5 TC19 token NO Wurm 46a55586-cc9a-443c-b458-e628afc3c587 52df7443-9af7-4cab-a69a-2ffd04b48815

 ## Too Strong ##
 1 JMP creature NO Craterhoof Behemoth 8c52bd39-0586-48ca-b263-17210cf9feb6 44afd414-cc69-4888-ba12-7ea87e60b1f7
 1 THB creature NO Nessian Boar 139a5f0b-6f76-4918-96e6-cdcf27253230 aaf91fc2-7317-47e4-9e6c-d7d74cdf0153
 1 RNA creature NO End-Raze Forerunners 69b52907-8aff-4f2a-a391-7d1ab2669b5c a50d79fe-6d37-42f3-b7b0-0c3018282fa2
 1 BBD creature NO Grothama, All-Devouring 34fd52c1-3d81-4005-b826-eeefbd7fd874 ab8935b1-ec87-4330-9952-9ef8cd344531
 1 AKH enchantment NO Sandwurm Convergence 429eff2b-635b-43f6-b20f-82e25992c0b9 e47bd2c5-e3db-4fde-a695-9e67a7e937be
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 1 JUD sorcery YES Crush of Wurms 6c12cd05-b673-453c-9f6b-f3aa022467c1 32a924b3-3bd6-43ad-acbd-1303dd670db4
 1 C21 sorcery NO Ezuri's Predation d0dd425b-fdba-41b4-b9e6-f5161610bd7e 3103505c-b071-4ae9-bf82-978e582d030c
 1 TOR sorcery YES Parallel Evolution 963cfdbe-775c-4267-a617-66f10e9d7f4f 73cce010-a8e7-477b-9179-bbad38aa6438
 1 C19 instant NO Second Harvest 61a6341e-0d36-44b6-8026-9c87c8ef61cb 22b01c98-c24b-4255-921f-4820f3d395ea
 1 M13 sorcery NO Predatory Rampage ee6d271c-0728-4080-85bb-a6af05f8b213 3e054ea5-3657-4198-9715-6acc0e362da3
 1 TKHC token NO Elemental ab19c684-94c6-4491-8a6b-7f31dddadae6 7737cbbf-659e-4a8d-9918-50652d6c0863
 1 TUST token NO Elemental 3387629a-f3c6-4dea-8bad-d938b611ced8 70f1f745-9fc2-41a6-9d39-fb4964595cf5

 ## Available Tokens ##
 1 TC21 token NO Insect b4f3e7ab-68fd-4613-ae6d-79ca43343d37 14da0d99-9717-47b3-990b-bed6fde78373
 1 TM21 token NO Saproling 2b7dba01-b08c-4218-9fc1-da55559d9155 d71a5aa4-a960-4c42-b8ac-7003f6e83e95
 1 TNCC token NO Wurm 1adf3c28-58c0-4239-ba4a-c53d345709b4 2ca9dbff-d7c7-4769-adab-e09163a29f9e

 ## Weak Permanents ##
 1 KLD enchantment NO Authority of the Consuls 55f3c721-e13a-406e-bc8e-d6cdc91ac477 324b2f55-1e09-490e-8f7e-bfde85a91ac4
 1 VOC enchantment NO Ghostly Prison e828b189-0e8f-43b8-b909-4c23e742e028 8169d44d-b15a-47e0-b417-24f2f4945d0f
 1 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 10E enchantment NO Primal Rage d6464ee4-23fc-4d68-bbda-3b53772015d1 ebe3b738-703d-465c-bc76-2b66f1e0aff2

 ## Powerfull Permanents ##
 1 MB1 enchantment NO Beastmaster Ascension 11b5308d-5bc0-4782-875f-a28be36e665d 3ac51aa4-710e-4171-9fb8-9f28525e3e26
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 RNA enchantment NO Ethereal Absolution e6f95e3a-61a6-40a9-8070-ffd2767764ad 0872d0ff-1060-44cc-9ed0-a6aa496440c8
 1 2X2 creature NO Impervious Greatwurm 65c0ab05-e740-4380-b39c-8bae9662f885 a1aa77ae-f685-48ee-85dc-ba6084cd30ba
 1 M12 enchantment NO Levitation 94b703c4-5584-4913-8365-7e9f2f535c2d 63e5124a-67c0-44ed-8085-28bf37816423
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 1 RTR token NO Worldspine Wurm 254f87cc-e0c2-484d-b5e8-1ea8c366990c 543d55cb-3a6b-4620-af25-10ae74ed32c4
 */

/*
 SLIVER
 
 ## Horde Deck ##
 1 TSR creature NO Battering Sliver 4adf959b-2e09-47ff-a1b1-b889348735b8 7f65a72b-d24c-4016-befc-91018a1b62e1
 1 H09 creature NO Brood Sliver 6b1d178f-9713-4dcf-920b-ddf2c94cc427 fa861228-5ceb-41f8-8ec0-9b96f1360271
 1 MH1 creature NO Cleaving Sliver 9b33059c-c862-4452-8609-14a0e2551fb3 51b657f0-6636-4d8a-9176-81027816e0ec
 1 M15 creature NO Diffusion Sliver 458ca9f4-4622-48e1-9ca1-6a8117188973 fb110a55-c8f9-4627-82c2-edb10db4f380
 1 LGN creature NO Essence Sliver 1f35f5e3-ddd1-4293-96f8-1181bbda77eb 1346fa14-1d9f-4c6a-887d-d3a93de00743
 1 H09 creature NO Frenzy Sliver d512d4ae-5db3-4fe5-8017-6a942004712d 8ae7319e-a12f-4e37-b184-0d15921ae72c
 2 TSR creature NO Fury Sliver 44623693-51d6-49ad-8cd7-140505caf02f a8a64329-09fc-4e0d-b7d1-378635f2801a
 1 MH1 creature NO Lancer Sliver 8ca33b31-4707-40d0-b4ed-cbe625793122 9a4f8d9a-3760-449e-b8a6-72b2a641ff23
 2 MH1 creature NO Lavabelly Sliver 334f673e-7cfa-432c-93aa-41adfbb99113 f6f0c9d6-cffc-4d8c-b455-e9feb8748aa7
 1 M15 creature NO Leeching Sliver f104b361-8000-4eda-b530-1502528e09f9 888ca52b-1270-4587-804d-1d08b07d7c5d
 1 TSR creature NO Lymph Sliver c3469de8-4bdb-42d4-9fc0-75fe31c3f6e5 48b8b4d4-4400-46cc-bd3c-e8a781cfc6f2
 2 M14 creature NO Megantic Sliver 52e8ec03-23ed-43a0-bce2-ad0cd5c4d737 7745f6a9-400c-4200-9732-86c54247de46
 4 TSR creature NO Might Sliver 92f5f80c-de1a-44e8-93f1-e405241c1e82 97c72fc3-72ac-4727-9872-33dc71049894
 1 LGN creature NO Shifting Sliver 6a262f53-2eea-45d0-8189-9222d66f1b52 1f68c4c2-91b5-4ffe-9dff-a6834038aa94
 1 TSR creature NO Sidewinder Sliver de8ccd32-f537-4a11-8dc4-e48836a0b139 5616e0c7-1f1d-4716-95e5-773a8e3ae5e3
 2 TSR creature NO Sinew Sliver ffff90c3-63c4-4dee-a21d-6b2b113f4f80 000edc61-b3ae-49e3-87f4-0250fa6a4501
 1 TPR creature NO Spined Sliver eed9c168-1c78-43c6-a814-9b80054d1373 5bb97644-be16-4d14-bebd-51894772b77b
 1 PLC creature NO Spitting Sliver 8415a482-3957-4c00-9015-99defc049877 cd07649e-c7fc-44f7-ab23-0fb935aff8c7
 1 LGN creature NO Toxin Sliver 96ccad44-7912-4fdb-bb2d-9d16cc3cd68a c04ab6b6-27ee-4c93-a87c-cbc3743f4faf
 1 TSR creature NO Two-Headed Sliver be857d6e-5bf2-491b-ab46-963b4d45adee 260cf43a-f3a4-48f7-9c51-5884d106ff56


 2 TOR sorcery NO Cleansing Meditation 658bccf8-fe73-4d6a-b37b-7a58034e5e5d fd6609ef-71af-4775-affc-34153700c556
 4 ONS sorcery NO Harsh Mercy dcd65c9b-4aaa-42af-869f-de179ae57c9f b6473b4d-1f59-4216-ace9-f3e5306266fb
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 2 VOC sorcery NO Vandalblast 3567c3c8-b3c7-45b7-935b-b1fdbc973720 4ce9072b-58e9-422a-9331-31886c111cfa

 32 TPR token NO Metallic Sliver 2dfafd63-83fb-4783-8e12-30018680a905 0f302984-9bf6-4583-865a-5545711e7a27
 22 M14 token NO Sliver Construct 7d592d5b-95cf-4416-9ade-1c23a8ba01d1 3129645a-221c-4eb5-88fd-12cc742a1dfe
 10 TSP token NO Venser's Sliver 54d65915-3833-4e4d-a066-37ae9507846f 1e3c5a64-453b-4477-853a-9514ba326f16

 ## Too Strong ##
 1 M14 creature NO Megantic Sliver 52e8ec03-23ed-43a0-bce2-ad0cd5c4d737 7745f6a9-400c-4200-9732-86c54247de46
 1 LGN creature NO Shifting Sliver 6a262f53-2eea-45d0-8189-9222d66f1b52 1f68c4c2-91b5-4ffe-9dff-a6834038aa94
 1 TSR creature NO Fury Sliver 44623693-51d6-49ad-8cd7-140505caf02f a8a64329-09fc-4e0d-b7d1-378635f2801a
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 1 ONS sorcery NO Harsh Mercy dcd65c9b-4aaa-42af-869f-de179ae57c9f b6473b4d-1f59-4216-ace9-f3e5306266fb

 ## Available Tokens ##

 ## Weak Permanents ##
 1 KLD enchantment NO Authority of the Consuls 55f3c721-e13a-406e-bc8e-d6cdc91ac477 324b2f55-1e09-490e-8f7e-bfde85a91ac4
 1 VOC enchantment NO Ghostly Prison e828b189-0e8f-43b8-b909-4c23e742e028 8169d44d-b15a-47e0-b417-24f2f4945d0f
 1 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 CLB enchantment NO Propaganda ea9709b6-4c37-4d5a-b04d-cd4c42e4f9dd e5f293d7-9c2b-41cb-8e3c-dfc1daa6635f

 ## Powerfull Permanents ##
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 RNA enchantment NO Ethereal Absolution e6f95e3a-61a6-40a9-8070-ffd2767764ad 0872d0ff-1060-44cc-9ed0-a6aa496440c8
 1 M12 enchantment NO Levitation 94b703c4-5584-4913-8365-7e9f2f535c2d 63e5124a-67c0-44ed-8085-28bf37816423
 1 M15 creature NO Sliver Hivelord e4fe33e7-b952-4152-8c83-81d948756d2f ba4106de-20c7-48cf-8a36-8c6913b46c89
 1 J19 creature NO Sliver Legion 47657df2-0e58-46c8-87e2-cc752708a612 3511ae86-9c49-4628-b61b-f25466b1b1d2
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 */

/*
 PHYREXIAN
 
 ## Horde Deck ##
 1 NPH creature NO Blade Splicer 194166ad-0179-42a3-86b9-ba7f322ec576 b8e56a28-713b-4a13-a601-1128cf117539
 1 MBS creature NO Blightsteel Colossus e80772e2-8623-4094-81a2-70828b2b151c 7928bb14-7631-4830-a756-26d1ea832ba2
 1 C21 creature NO Bronze Guardian 922a030c-857b-4c61-93df-b70ebb32abd3 8cd5cc66-2ade-4142-9269-7d9905b029e5
 1 MBS creature NO Core Prowler 0ad44727-41c3-471c-b038-1bf43c5f296a 05414ba7-0f59-4c73-931c-e599d149d3ba
 1 NPH creature NO Elesh Norn, Grand Cenobite 958d71ff-c9f7-46f0-96ca-79e7f4d65a16 b66390d6-1649-4bfa-92d3-77664650d552
 1 SOM creature NO Hand of the Praetors f595c7f6-783f-4825-9c1a-e7f8edd380fd 94ca493e-f09b-4b11-bb47-0562dfc203ca
 1 SOM creature NO Ichor Rats f8148664-49c0-421f-93a5-cd59e4e9ea36 2013aed6-7415-4bf0-a3bb-46d6beecbaff
 1 MBS creature NO Massacre Wurm 93cf50cf-0ecc-4d3e-abea-778c1ebacec4 cdd32ec2-02a8-41fc-bf45-c9585bb2b3ee
 1 NPH creature NO Master Splicer 9e0c5919-aed6-4d98-85c8-2658be78bdf0 859d2b91-63af-4700-8ca5-b1756aa6639b
 1 NPH creature NO Maul Splicer b0d0c534-8bd2-4801-aadd-dcc9c92d6ec3 2d2c6a6d-5b59-47d7-b290-df3640d9555f
 1 MBS creature NO Phyrexian Crusader 91760bdf-a82a-4f3d-b925-3bc81ffbd41f 32aaa8b9-987b-4809-8a54-aa29bdc18805
 1 MBS creature NO Phyrexian Hydra b16085d5-6d00-4d47-ab8b-d18d55c72141 cb135aa1-9f46-4d60-a1a4-97aa0e852ced
 1 MBS creature NO Phyrexian Juggernaut 009fcd1e-5c5f-435b-afc1-099f1622e45c a9f6ed6c-8095-4a81-b428-36b2916eec88
 1 NPH creature NO Phyrexian Obliterator 41820f91-27cf-41c0-bb5e-9adf6845a6a4 44c4476d-58f9-420d-9545-f5d580c589de
 1 NPH creature NO Phyrexian Swarmlord 4fc2755c-ae7b-4147-a573-b33679a461e8 8a91dea7-9792-4714-82b0-ba2c06cef304
 1 MBS creature NO Priests of Norn 793fe31a-2b11-49f8-9851-719469ad1726 a978c49d-483a-42fe-971c-858288d07e40
 1 SOM creature NO Putrefax 3a336b30-335a-49d0-b192-c20f3670452b b2b2c3f9-a831-4fd2-80e8-b67b0df3e98b
 1 NPH creature NO Reaper of Sheoldred 251cee41-30f5-4bba-93cd-31493a5ea051 a300a645-aec6-4cda-8c11-1e8a6af056ff
 1 C18 creature NO Scuttling Doom Engine 72ccdcef-5c84-45ba-bda3-3dc014e1585c 7ad0dfdd-2075-4a42-976b-e493246bc61c
 1 NPH creature NO Sensor Splicer 9676da93-1e17-4f6c-b610-a242b78c71ab 79076264-d71c-4b30-aac9-702a4d229933
 1 SOM creature NO Skithiryx, the Blight Dragon daf6c421-e7f7-4fc6-967c-65f4ab96fcfd c930c9cc-1b64-4f36-afe2-6bf120a74ce2
 1 NPH creature NO Spinebiter 9b844a0c-590f-46c7-b53e-c99398e0d8c0 cfc79ac6-ffc6-4506-9dea-e20176f960ea
 1 NPH creature NO Toxic Nim afc2a3a7-eb69-4fcb-b3a3-444dccb735d7 5823990c-8d40-4352-8d34-74332934adb2
 1 NPH creature NO Urabrask the Hidden 5b2ffb53-86b7-4665-a5c7-b85b035b6c81 b06fcab2-891e-4fa3-8583-068ba56c2e27
 1 C18 creature NO Vedalken Humiliator 17c3a888-84d2-4c21-8fa3-d2d825dd7601 039dff9a-881f-4a3d-8680-7f560ef0ea7e
 1 KHM creature NO Vorinclex, Monstrous Raider 5a3fdf5a-bff8-4896-b288-3f43f9a72d9b 92613468-205e-488b-930d-11908477e9f8
 1 NPH creature NO Wing Splicer 7fbf6afc-8a16-447b-bdef-b7d0b640f76c e2dbfb1b-092c-44a3-932d-a8b27be0a72b
 1 SOM creature NO Wurmcoil Engine d1a60f44-7696-49ee-91fb-cab5b3102962 33672990-4860-4aa6-ac1b-f9da66f5da59

 1 SOM enchantment NO Inexorable Tide 40ec0a47-badf-4074-b0a8-749bb7c17b95 8f41e281-fcbb-450b-8a67-7b072c55c6f0
 1 AKH enchantment NO Nest of Scarabs 1f21cf59-6390-44b4-ab2e-ef290dfd8c85 97aa6b45-055a-411e-b2db-b373a4d3826d

 1 SOM instant NO Carrion Call 8f1e8f25-ee23-40a6-a3f2-369bb960267f bc3c1a8e-3bdb-42cf-9442-5de7e4670d66
 2 TOR sorcery NO Cleansing Meditation 658bccf8-fe73-4d6a-b37b-7a58034e5e5d fd6609ef-71af-4775-affc-34153700c556
 4 MBS sorcery NO Phyrexian Rebirth 6ef3c75d-6af2-4ea0-b98d-96c5d7d3af58 36b7536d-6b0b-4906-ba88-7fcfe9b854ee
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 1 NPH sorcery NO Triumph of the Hordes 3ded0c0c-40ce-4d14-a9a6-b023bc19ee0e c16b90ff-d256-4ac6-b687-3430b8c80dd7
 2 VOC sorcery NO Vandalblast 3567c3c8-b3c7-45b7-935b-b1fdbc973720 4ce9072b-58e9-422a-9331-31886c111cfa

 9 TTSR token NO Assembly-Worker 02e1a471-36b2-4d28-a323-f4ec3d095cb9 e72daa68-0680-431c-a616-b3693fd58813
 3 TKLD token NO Beast 347a9b41-8545-405d-9b4b-3691890201d7 4de1d095-459f-42fd-9d9f-8f71d002a5b2
 5 TMH2 token NO Construct ee740c48-59cd-4fcc-b4a5-fe3dde1361d5 a7caaf39-8f16-4f1d-bee6-a45674306319
 3 TMBS token NO Golem 80fe0a7b-a310-41a1-8417-c734402e9c4f 2d84926d-5892-4c62-a943-fac9f0ddc569
 8 TRIX token NO Golem ee924697-f02c-412c-82cf-145b943aec06 a7820eb9-6d7f-4bc4-b421-4e4420642fb7
 25 TNPH token NO Golem 9859c54d-695b-4bb1-940e-cfd1c3301e89 fe9e8d3b-ebc0-448b-bd14-a9f418e196e7
 3 T2XM token NO Wurm 1b9ccdd7-4935-45e2-bb16-b09870dd965d a6ee0db9-ac89-4ab6-ac2e-8a7527d9ecbd
 3 T2XM token NO Wurm 5e3f41f7-9b42-437a-a9f9-f09250b083db b68e816f-f9ac-435b-ad0b-ceedbe72447a

 ## Too Strong ##
 1 MBS creature NO Blightsteel Colossus e80772e2-8623-4094-81a2-70828b2b151c 7928bb14-7631-4830-a756-26d1ea832ba2
 1 NPH creature NO Elesh Norn, Grand Cenobite 958d71ff-c9f7-46f0-96ca-79e7f4d65a16 b66390d6-1649-4bfa-92d3-77664650d552
 1 MBS sorcery NO Phyrexian Rebirth 6ef3c75d-6af2-4ea0-b98d-96c5d7d3af58 36b7536d-6b0b-4906-ba88-7fcfe9b854ee
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 1 NPH sorcery NO Triumph of the Hordes 3ded0c0c-40ce-4d14-a9a6-b023bc19ee0e c16b90ff-d256-4ac6-b687-3430b8c80dd7
 1 MBS creature NO Massacre Wurm 93cf50cf-0ecc-4d3e-abea-778c1ebacec4 cdd32ec2-02a8-41fc-bf45-c9585bb2b3ee
 1 NPH creature NO Phyrexian Obliterator 41820f91-27cf-41c0-bb5e-9adf6845a6a4 44c4476d-58f9-420d-9545-f5d580c589de
 1 SOM creature NO Skithiryx, the Blight Dragon daf6c421-e7f7-4fc6-967c-65f4ab96fcfd c930c9cc-1b64-4f36-afe2-6bf120a74ce2
 1 NPH creature NO Urabrask the Hidden 5b2ffb53-86b7-4665-a5c7-b85b035b6c81 b06fcab2-891e-4fa3-8583-068ba56c2e27
 1 MBS creature NO Phyrexian Hydra b16085d5-6d00-4d47-ab8b-d18d55c72141 cb135aa1-9f46-4d60-a1a4-97aa0e852ced
 1 KHM creature NO Vorinclex, Monstrous Raider 5a3fdf5a-bff8-4896-b288-3f43f9a72d9b 92613468-205e-488b-930d-11908477e9f8
 1 C21 creature NO Bronze Guardian 922a030c-857b-4c61-93df-b70ebb32abd3 8cd5cc66-2ade-4142-9269-7d9905b029e5
 1 TMBS token NO Golem 80fe0a7b-a310-41a1-8417-c734402e9c4f 2d84926d-5892-4c62-a943-fac9f0ddc569

 ## Available Tokens ##
 1 TAKH token NO Insect 805e96af-349b-4d59-a5ce-bc6d2be7f260 242c381e-df58-4365-a68c-add1127a83cc
 1 TSOM token NO Insect 5769718d-6781-4919-bc9b-245e9e0cb507 85f9e977-f718-41b2-b30b-77a9a17e9733

 ## Weak Permanents ##
 1 KLD enchantment NO Authority of the Consuls 55f3c721-e13a-406e-bc8e-d6cdc91ac477 324b2f55-1e09-490e-8f7e-bfde85a91ac4
 1 VOC enchantment NO Ghostly Prison e828b189-0e8f-43b8-b909-4c23e742e028 8169d44d-b15a-47e0-b417-24f2f4945d0f
 1 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 CLB enchantment NO Propaganda ea9709b6-4c37-4d5a-b04d-cd4c42e4f9dd e5f293d7-9c2b-41cb-8e3c-dfc1daa6635f

 ## Powerfull Permanents ##
 1 SLD creature NO Atraxa, Praetors' Voice 7e6b9b59-cd68-4e3c-827b-38833c92d6eb 7cc19f85-7ef6-4fd2-83e5-0dbae1d80f2b
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 RNA enchantment NO Ethereal Absolution e6f95e3a-61a6-40a9-8070-ffd2767764ad 0872d0ff-1060-44cc-9ed0-a6aa496440c8
 1 M12 enchantment NO Levitation 94b703c4-5584-4913-8365-7e9f2f535c2d 63e5124a-67c0-44ed-8085-28bf37816423
 1 2X2 creature NO Lord of Extinction ea5e3401-bd6c-47bb-a52a-8eec5f09455d 696cb81d-bc00-4603-b340-c0b2e55c0959
 1 M19 creature NO Poison-Tip Archer d0e810bb-5f38-4045-a718-30d423c05659 5e058ff8-043c-498b-8310-0ca45466ac27
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 */

/*
 HUMAN
 
 ## Horde Deck ##
 1 MID creature NO Adeline, Resplendent Cathar 38515f89-348b-4cf3-b7bd-1f6fe4ce2fba 18092f68-b96e-4084-9eba-b240d2195d81
 1 C20 creature NO Adriana, Captain of the Guard de23275e-e9c1-4151-aed8-f79ead03d5d4 d29569dd-6d79-412d-bc14-674cd1705260
 1 AVR creature NO Angel of Glory's Rise c6a606af-ea08-4cd9-bfd9-60d76e232e85 7a8be765-0949-491c-875c-0385fb83e4b9
 1 BNG creature NO Archetype of Courage 79b48704-480d-4905-b87a-40b127894670 8e6c4afb-6a94-4519-91c6-9824fed2892c
 1 2X2 creature NO Balefire Liege ee35ed62-d5a2-4e65-a7eb-fcdcb3665532 3ed13445-c9a0-4f17-aa69-af353679e6a7
 1 DOM creature NO Benalish Marshal 2cc439e8-d112-44e6-bc5a-6e99333c519a 6dd1a7fc-5dbd-4ed2-9b02-9fd5c55bb629
 1 STX creature NO Blade Historian 314f0a96-5e91-42a3-9d75-3f641f22a9ee a46d64ec-aca4-428e-bce6-66cd755c8cc3
 1 RAV creature NO Blazing Archon 82a70e4c-01ed-4280-80e4-86cb2bf6e63d cd0bc05b-ec48-41fd-a97a-ffb0d5a2dee0
 2 DDO creature NO Captain of the Watch 9f2af06d-8fb7-4276-bb92-3559a6d1fa18 6e201980-e220-44dc-beab-ad13c20332bd
 1 CSP creature NO Darien, King of Kjeldor d05336cb-6157-47e7-942f-43becd67a5bf 5ea571ae-b9bd-4bd2-9357-52915f0d2f15
 1 C20 creature NO Frontier Warmonger 9cb741ae-14d6-4a8d-bfad-703abfe3682c 233e1a27-c8d6-46de-a128-89791e7f2e9b
 1 C20 creature NO Frontline Medic 36a3c910-95b8-45a2-9f84-5681336d868c 984f0514-e9a9-4f22-9f7d-96fd62338db2
 1 KHC creature NO Goldnight Commander 3dc51dfc-7a60-41bf-b944-6afad6b06c22 80be2fea-3fe6-477e-bcb8-63f441d6cfc1
 1 EMN creature NO Hamlet Captain 1a60dc0f-e387-4d28-8ff0-c3f1883d0c5d 43435939-20cf-49c9-8e37-63681740399b
 1 EMN creature NO Hanweir Garrison 7cb29569-48e1-4782-9906-fad155ebfafe 0900e494-962d-48c6-8e78-66a489be4bb2
 1 MBS creature NO Hero of Bladehold 454a8902-8120-4373-96ee-bbf352b04e8d 8a3853ec-e307-46e0-96d7-0706b5c45c5e
 1 MBS creature NO Hero of Oxid Ridge f18799c4-ec54-4435-be51-03ea25809289 1a516bce-3d2d-4e0f-afc7-27be3d88848c
 1 MIC creature NO Kyler, Sigardian Emissary 726cd041-5d0b-436c-bced-9335f56c0b0d 62a78aae-598e-4f2b-a7bc-c3afc1d0d191
 1 EVE creature NO Nobilis of War 4789ac35-ca91-4046-8262-24c34e751cea 6d54ab6e-dd56-40fe-abab-a1e67b024744
 1 THB creature NO Reverent Hoplite 8cb6dbb5-9ea2-4c19-8173-148080fb898e 54153b9c-483e-4e5c-a1ab-b1c8a7a657d4
 1 MIC creature NO Stalwart Pathlighter 88ba283d-2d03-4455-a4a3-a2a5622209bd a5bf9336-80d6-4751-9630-1d28e24cc0cf
 1 ELD creature NO Syr Alin, the Lion's Claw 5d9a4905-4a26-410e-936c-56de849e9ca3 4cddb2d2-d813-4b83-a592-380ba4edf54f

 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 C15 enchantment NO Dictate of Heliod b989279c-665d-4f15-afc1-adf3872a4851 f964c561-96ac-4558-b46e-ba2c472d5807
 2 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 C14 enchantment NO True Conviction fc299c1c-50f3-492a-b6b8-a3664bb72ab7 9e5dc58b-f486-4b9f-9138-33efa31a05e4

 2 TOR sorcery NO Cleansing Meditation 658bccf8-fe73-4d6a-b37b-7a58034e5e5d fd6609ef-71af-4775-affc-34153700c556
 1 C14 sorcery NO Deploy to the Front 135cb4af-f4b6-455b-8fea-84fcef78ee03 10744088-b028-43aa-8a77-cd2a430fbfb6
 2 MIC sorcery NO Hour of Reckoning 3bc13640-03f8-4b19-b0a4-7e7cb5271c0c 0a14b17e-bfff-4859-92cb-a82d2e90580b
 1 C20 sorcery YES Increasing Devotion 7a5ff4d4-27b7-47d4-ba88-970c63c4e3fb 0c786c28-1085-4b3e-9164-5fa3adfa5010
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 2 VOC sorcery NO Vandalblast 3567c3c8-b3c7-45b7-935b-b1fdbc973720 4ce9072b-58e9-422a-9331-31886c111cfa
 1 MIC sorcery YES Visions of Glory ef47c447-bd7f-43c6-b4db-4a848c39820c 11675d8a-cd81-4055-bdbd-2e709e12ba66
 2 2XM sorcery NO Wrath of God 34515b16-c9a4-4f98-8c77-416a7a523407 664e6656-36a3-4635-9f33-9f8901afd397

 10 TELD token NO Human Warrior 07f49348-e3bd-47dc-b68d-6b38b9b54f70 c994ea90-71f4-403f-9418-2b72cc2de14d
 20 TC20 token NO Human 30272edf-097c-4918-84d2-9fa6c42dbe0a 0dffd473-2b89-4f74-8bff-39b8eb408b26
 10 TCM2 token NO Knight 100435fe-ae77-4644-8b4a-4c941bb2067f a0c79cdb-969b-4c3b-8ad0-cbbd359a966b
 10 TM20 token NO Soldier eac25f12-6459-438c-a09e-93e23d2cf80d a491d9da-a58d-4423-b565-c5a99ef63132
 10 TWAR token NO Soldier 01e023e5-38bc-4203-aecb-6b2de54b03ea ca11c711-93fe-45ca-b393-3851148defc4

 ## Too Strong ##
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 MIC sorcery NO Hour of Reckoning 3bc13640-03f8-4b19-b0a4-7e7cb5271c0c 0a14b17e-bfff-4859-92cb-a82d2e90580b
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 1 2XM sorcery NO Wrath of God 34515b16-c9a4-4f98-8c77-416a7a523407 664e6656-36a3-4635-9f33-9f8901afd397
 1 C14 enchantment NO True Conviction fc299c1c-50f3-492a-b6b8-a3664bb72ab7 9e5dc58b-f486-4b9f-9138-33efa31a05e4
 1 C15 enchantment NO Dictate of Heliod b989279c-665d-4f15-afc1-adf3872a4851 f964c561-96ac-4558-b46e-ba2c472d5807
 1 MIC creature NO Kyler, Sigardian Emissary 726cd041-5d0b-436c-bced-9335f56c0b0d 62a78aae-598e-4f2b-a7bc-c3afc1d0d191
 1 STX creature NO Blade Historian 314f0a96-5e91-42a3-9d75-3f641f22a9ee a46d64ec-aca4-428e-bce6-66cd755c8cc3
 1 C20 creature NO Frontline Medic 36a3c910-95b8-45a2-9f84-5681336d868c 984f0514-e9a9-4f22-9f7d-96fd62338db2
 1 C20 sorcery YES Increasing Devotion 7a5ff4d4-27b7-47d4-ba88-970c63c4e3fb 0c786c28-1085-4b3e-9164-5fa3adfa5010
 1 C20 creature NO Adriana, Captain of the Guard de23275e-e9c1-4151-aed8-f79ead03d5d4 d29569dd-6d79-412d-bc14-674cd1705260

 ## Available Tokens ##

 ## Weak Permanents ##
 1 KLD enchantment NO Authority of the Consuls 55f3c721-e13a-406e-bc8e-d6cdc91ac477 324b2f55-1e09-490e-8f7e-bfde85a91ac4
 1 SLD enchantment NO Ghostly Prison e828b189-0e8f-43b8-b909-4c23e742e028 1a43d9e8-3320-4873-b322-b323c792ce5e
 1 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 CMR creature NO Odric, Lunarch Marshal bad76170-c773-4be5-9457-20dc9f745cb4 17b429bd-d7da-45f5-988b-7eed0d3efeaa

 ## Powerfull Permanents ##
 1 SLD creature NO Akroma, Angel of Wrath 107f204c-9fd3-490d-8887-be63d14fc6a4 cf75f895-3481-4c21-a85f-c819613bccc3
 1 CMD creature NO Angelic Arbiter 34dd789c-4d80-4ccc-a4f7-2e5388a9689d 602a5e00-7e7f-4aec-bf8a-550b00f0864c
 1 GTC enchantment NO Assemble the Legion 6f81bef3-6ca0-4cf4-aa99-7b2813eeef04 43675ed7-ece1-4414-965e-9ebadcbf3dfb
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 CM2 creature NO Gisela, Blade of Goldnight 66f9f325-5e8e-4ebf-b5b3-c6410d80f2c5 365c43c2-1a65-4f6a-860d-39dcb15255c3
 1 CMR creature NO Prava of the Steel Legion 4daa7b7d-e410-4bcf-b3e2-2751774bef47 e9e40e2a-e447-4754-a98b-5521e546781f
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 */

/*
 DINOSAUR
 
 ## Horde Deck ##
 1 XLN creature NO Burning Sun's Avatar 248d7759-aa73-4430-aa86-d45dc607944b 146c0cab-5f6b-425d-9f50-33d8da266235
 1 XLN creature NO Carnage Tyrant 8c411f4e-a091-447c-9450-d895b10b4985 3bd78731-949c-464a-826a-92f86d784911
 1 RIX creature NO Charging Tuskodon 1198d47a-4235-4678-bd2e-20f2a97b5924 8e49960d-4b45-4d3b-9c6e-e7b717b4feaa
 1 RIX creature NO Frilled Deathspitter a65c1fcc-61d1-43d9-a62c-65f156f98bce e3825798-f673-4d8a-9997-ccb73681cbf2
 1 PRIX creature NO Ghalta, Primal Hunger b0b6be0c-41cf-4757-9f0e-87227b6ba6b3 c11a7c2e-75e8-432e-84c4-df63e0df0981
 1 M19 creature NO Gigantosaurus e666bae7-dd51-4921-8b89-7e8d423caba0 c1db84d8-d426-4c0d-b44e-5be7b0f5f5bf
 1 XLN creature NO Goring Ceratops 34f5383b-21fe-45f5-9598-7382ee4c5b12 8309f684-5912-4191-9f64-d573f1cc84c9
 1 IKO creature NO Imposing Vantasaur a0d5fce0-a439-496a-9fcf-9271503f3ce8 b6fa5feb-f5e9-4079-acc9-84e458044769
 1 XLN creature NO Kinjalli's Sunwing b9243163-b726-432e-830f-86132aa7f34a 2b9e0b0f-651a-44e6-8fb0-e46bfda0ada9
 1 M20 creature NO Marauding Raptor b3fe2f61-c58e-4ebc-a5e3-99d6b6f62caf 64e4d2ee-e5e5-48e6-a7b8-9045dc8b10a7
 1 RIX creature NO Needletooth Raptor 2c431df9-095a-44f1-993e-74eb215d75fe e9a90b68-d5f4-4f3c-bd4b-af59dd868919
 1 M21 creature NO Ornery Dilophosaur 8291bc2e-ef58-4bd4-b261-b587142bbb1c c2c4a0e7-9ca4-4291-94de-165cc2ded822
 1 RIX creature NO Overgrown Armasaur 9e104718-1f74-4414-977a-82def93b5a8e fb6558db-6332-42ac-8a61-4524c200b62f
 1 RIX creature NO Polyraptor e47e3a40-f51f-41ed-8e7c-06200a2abc22 f8965a3a-93fe-4021-a665-b6013bdc86f7
 1 XLN creature NO Raging Swordtooth 626709bc-6c29-434f-9e3f-b84bb8a5c431 15a79137-9589-4c24-9bea-31041fd3c9ae
 1 XLN creature NO Rampaging Ferocidon 3e5ca524-8dd1-4f7f-a467-5210d768b8a1 39d3c658-1927-4af3-9077-88c4a669c730
 1 XLN creature NO Raptor Hatchling 91638137-06ba-4b21-b088-28d2b4d1d8da 8093e88d-fd3c-43d3-a025-9ebb9f02a84f
 1 XLN creature NO Regisaur Alpha 0673f4e0-66ff-458c-b4ba-eb067e560cce d6a322c5-aa4c-4a99-a3ca-48c1353104f0
 1 LGN creature NO Ridgetop Raptor 600a8c9e-e158-4fff-8c4d-c3a1bfd006e8 1013cbc4-09f4-484f-b328-9f7403225149
 1 CMR creature NO Ripscale Predator 4c297085-5ec1-4d29-9a8e-1785c016ce09 00924a16-fb85-41a4-bd7a-88f51f728333
 1 RIX creature NO Siegehorn Ceratops f7730e2e-aa62-40e7-836d-e6ddb6893816 0a9c4c63-402e-489e-ab0d-1c98309b010a
 1 RIX creature NO Silverclad Ferocidons b3aa5889-0d98-4a8c-a8b1-ada1e9b169e1 5f0d0c8d-c057-4a44-bd1e-38e1dd175778
 1 XLN creature NO Snapping Sailback 6f7b9ff4-fe79-4d21-9262-47bcd2411259 0af1eadf-f7ea-40be-a0cc-b79e4161db34
 1 XLN creature NO Sun-Crowned Hunters 9e6e6458-9e0e-404c-af07-225c4665eaec 3cab793e-0e17-4940-9cab-a30d62df5c20
 1 RIX creature NO Temple Altisaur 1f499d39-b963-45c0-9604-d3cab98c9e05 fa8f8d61-51d6-479b-a812-6cbacc7ea1fc
 1 AFR creature NO The Tarrasque bfd66214-e576-4a7e-8559-4e4e51d56b98 8a26fa15-d81f-4152-ae33-e91aa276b3fc
 1 XLN creature NO Thrash of Raptors 5f554df8-c70f-4212-aec7-597fe8a88553 2a03b859-811c-45ff-8d8a-9e87e4bbf113
 1 MH2 creature NO Thrasta, Tempest's Roar 19d258fb-4cda-4cbb-b07a-8b4670488867 6172da14-9a87-4cf9-aff5-aca3470a67ef
 1 C21 creature NO Verdant Sun's Avatar 6ee71432-a44d-495e-86ea-d495d891c331 f8fd0e28-2bb4-4529-bbfb-1d70a419a91b
 1 XLN creature NO Wakening Sun's Avatar 3c2aec69-ffd9-4a34-888c-58adbbb99bb5 7434abe4-87eb-4709-a26d-4e23154b4d31

 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d

 2 TOR sorcery NO Cleansing Meditation 658bccf8-fe73-4d6a-b37b-7a58034e5e5d fd6609ef-71af-4775-affc-34153700c556
 1 XLN instant NO Dinosaur Stampede 3d6af1ee-16d2-4b82-8d9f-6d956603a746 a31bda74-8455-45ab-8142-65fbde2f39c3
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 3 XLN sorcery NO Star of Extinction 48220e6c-5752-46e0-9b7f-f0eef274d929 021f57dc-80f3-4ede-99d5-4a44aade44e2
 2 VOC sorcery NO Vandalblast 3567c3c8-b3c7-45b7-935b-b1fdbc973720 4ce9072b-58e9-422a-9331-31886c111cfa

 20 TGN2 token NO Dinosaur 240300bd-5088-43c5-a873-290507515843 b1ade1a5-74bf-41cd-b3b4-3bf33cf6d016
 40 TIKO token NO Dinosaur 29b74e83-90eb-4ced-87fc-10cea5822a62 f918b740-1984-4090-8886-9e290a698b95

 ## Too Strong ##
 1 M19 creature NO Gigantosaurus e666bae7-dd51-4921-8b89-7e8d423caba0 c1db84d8-d426-4c0d-b44e-5be7b0f5f5bf
 1 PRIX creature NO Ghalta, Primal Hunger b0b6be0c-41cf-4757-9f0e-87227b6ba6b3 c11a7c2e-75e8-432e-84c4-df63e0df0981
 1 XLN creature NO Goring Ceratops 34f5383b-21fe-45f5-9598-7382ee4c5b12 8309f684-5912-4191-9f64-d573f1cc84c9
 1 AFR creature NO The Tarrasque bfd66214-e576-4a7e-8559-4e4e51d56b98 8a26fa15-d81f-4152-ae33-e91aa276b3fc
 1 XLN creature NO Wakening Sun's Avatar 3c2aec69-ffd9-4a34-888c-58adbbb99bb5 7434abe4-87eb-4709-a26d-4e23154b4d31
 1 XLN creature NO Burning Sun's Avatar 248d7759-aa73-4430-aa86-d45dc607944b 146c0cab-5f6b-425d-9f50-33d8da266235
 1 RIX creature NO Silverclad Ferocidons b3aa5889-0d98-4a8c-a8b1-ada1e9b169e1 5f0d0c8d-c057-4a44-bd1e-38e1dd175778
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 IKO sorcery NO Ruinous Ultimatum a6f38908-aa4f-4f99-a28e-85d11dab52e4 50c1d6ca-7789-46b5-bc89-85cc3915cb85
 1 XLN sorcery NO Star of Extinction 48220e6c-5752-46e0-9b7f-f0eef274d929 021f57dc-80f3-4ede-99d5-4a44aade44e2

 ## Available Tokens ##
 1 RIX token NO Polyraptor e47e3a40-f51f-41ed-8e7c-06200a2abc22 f8965a3a-93fe-4021-a665-b6013bdc86f7
 1 TC21 token NO Saproling 2b7dba01-b08c-4218-9fc1-da55559d9155 113dbefc-14da-4826-87c1-543b53827c24

 ## Weak Permanents ##
 1 C19 enchantment NO Ghostly Prison e828b189-0e8f-43b8-b909-4c23e742e028 daeca212-3a70-470e-a934-9cd7e0ebf7eb
 1 M21 enchantment NO Glorious Anthem e3886fe8-9b76-4613-8891-4ec74657c087 17d154d3-7ae5-43ff-9978-d974285e2c89
 1 CN2 enchantment NO Gruul War Chant a9edb891-1a38-4b8a-8539-c459e8a52315 00cbf1b0-5aa5-4420-84ea-7ea777ae34a7

 ## Powerfull Permanents ##
 1 RTR enchantment NO Collective Blessing 7f7049e8-49ed-46da-89f7-1e40aefb3b0c 53c84c4d-e6d6-4eac-9d14-5b6cba914c3d
 1 RNA creature NO End-Raze Forerunners 69b52907-8aff-4f2a-a391-7d1ab2669b5c a50d79fe-6d37-42f3-b7b0-0c3018282fa2
 1 MID enchantment NO Unnatural Growth 7324abaa-48da-439d-9339-b0ea5eea612e 6748a844-e185-4e3b-ac1d-8a735666d8ae
 1 C20 creature NO Zetalpa, Primal Dawn 7da0e5de-3e4c-420a-8685-991206100b9d 8d5b29be-2b1a-4ba5-8958-60eee4e3bac1
 */

/*
 ELDRAZI
 
 ## Horde Deck ##
 1 BFZ creature NO Bane of Bala Ged 38839894-1706-4e11-8310-5ea8dd8866d9 3741e62a-4b86-46ff-a7df-a8ceaf3b9a0c
 1 BFZ creature NO Benthic Infiltrator b2977807-5f46-424a-a6e9-14262f8a723a f380ae58-08cc-42df-ac74-3c6890a62463
 1 BFZ creature NO Blisterpod 2a62b226-d317-4212-9781-9c1d72056f11 e16f1803-634a-41b0-ae21-484d6f914a0d
 1 BFZ creature NO Breaker of Armies 0be1ace3-2b3d-4465-b63a-be523f73df36 784e843e-7010-466d-adbd-1dd1595aead1
 1 BFZ creature NO Brood Monitor 9a08bb4b-46df-4b99-8f86-670d07e900ba ea7d4a49-8681-4f95-8718-96648bf73c39
 1 EMN creature NO Chittering Host 6923cf6b-7d3e-4d95-abaf-1df1a04ac7c1 70b94f21-4f01-46f8-ad50-e2bb0b68ea33
 1 BFZ creature NO Culling Drone bda0ca68-78a6-4b32-842f-0bee9a9c84ef 1a623415-46c0-45aa-ab75-1e2d9708013a
 1 BFZ creature NO Desolation Twin c0cb1f37-1679-42c7-a794-81e088157eeb 4d229d8d-5e64-4403-a4ae-a0a186a83935
 1 BFZ creature NO Dominator Drone 3c98c925-f380-4520-970d-4c1abbebefe3 12e7e2b5-3141-4a19-aa49-91ab7e5c211c
 1 ROE creature NO Dread Drone b6821131-9ae1-4a3c-8235-90deae33c05f 38d65339-e419-40b9-814a-374874f5585f
 1 OGW creature NO Eldrazi Aggressor aa0c6fea-c90c-4b65-aa1e-18e5b34ea6e3 62f3ec85-552d-4e28-939e-ab2c39e3e9c5
 1 BFZ creature NO Eldrazi Devastator bc08ac66-969c-4905-a2d6-16ff565be475 04b13e32-01b9-4a86-a3df-ca8b784c6a6c
 1 ROE creature NO Emrakul's Hatcher 1ee811fb-c25d-4cf5-b396-539c36e8f90f 1a901c3f-313d-495e-96a0-29f1a33b8225
 1 BFZ creature NO Eyeless Watcher ba047b0b-d451-4566-8656-00b00611de8c 4d949d0e-baf7-4573-bb15-7e30e3e9b202
 1 OGW creature NO Flayer Drone 9e275428-3562-4ed6-8a49-3bb202a5130a 3931db42-3773-4aae-b6eb-2209e7312f8c
 1 ROE creature NO Hand of Emrakul b206d3bc-1203-4f00-997e-5da706346a24 84d602f4-5876-416a-95e5-821a285358bf
 1 EMN creature NO Hanweir, the Writhing Township f4905c40-003e-4992-b8d7-3f07ba09c686 671fe14d-0070-4bc7-8983-707b570f4492
 1 BFZ creature NO Incubator Drone 088d63ec-bd5e-4e80-acf9-2af270a9b395 e0855762-7068-4111-a6bf-fe6d5b092c74
 1 ROE creature NO It That Betrays b11187ab-f8a8-422b-b550-4495f96de0f2 34d790ad-3559-4c32-9057-e2e326740bdc
 1 ROE creature NO Kozilek's Predator 452ef7d0-1351-40e6-9379-59cd8bb31da5 4ab37d0e-5542-4ae0-a48e-d0a4e6bf48e7
 1 BFZ creature NO Kozilek's Sentinel 86ae05d6-f1ba-456d-bbc0-f35cd0d0537d 786c6a0f-3f75-45ff-aae9-5c866be279d0
 1 ROE creature NO Nest Invader a7584a28-0829-4897-abf4-6be1a9232347 24517d9c-6cde-41e8-9e82-ee73f069379a
 1 ROE creature NO Pathrazer of Ulamog 4bf95747-4572-49b8-b892-87fe7f910252 3fdd84b5-fd93-483e-a131-028d04d9dea7
 1 ROE creature NO Pawn of Ulamog 9bcaf141-1f1f-491f-aced-13dc093b9e2c 85f4d77d-e0de-48fe-899b-5718cee779e2
 1 ROE creature NO Rapacious One 3af03c99-d215-477b-ba49-51f4e87907ff e3befaa0-55a3-4e34-8051-1ab19eabd7d2
 1 OGW creature NO Reality Smasher 17c651c7-da4e-45e9-9a64-fad3e873123d 52d4b652-a830-4fd4-94bb-c17c227f2928
 1 BFZ creature NO Ruination Guide 3394ce74-c352-4ae1-a7bb-f6ef8ac1c810 f0bdbe64-d985-4bc5-bb1d-4cbf12ef60b2
 1 OGW creature NO Scion Summoner fa60f3a6-5834-4059-adea-dd17366b7885 826a882e-c4bd-4132-b797-9e1aa2d0bce4
 1 OGW creature NO Sifter of Skulls 688e5e19-8f28-45c4-ace4-a38144f494f1 be57a5aa-44f1-483f-9274-aa68f5a2bf1f
 1 BFZ creature NO Tide Drifter 428c18aa-b195-4cf2-a1a9-09723b26eb0a 4c590579-e0ef-4839-8f67-f52813cd9fe7
 1 ROE creature NO Ulamog's Crusher 597bce51-af89-4d13-9a97-667b4f4f4694 76bacedb-9fa8-4a21-b0eb-e7ead64360b4
 1 BFZ creature NO Vestige of Emrakul 55187899-c445-48e9-80b9-235eaf42f803 a5d84986-64a1-4bd1-a4f6-3eb147aca357
 1 BFZ creature NO Vile Aggregate 4a6b254e-76fb-4712-ac34-5e26c311b2e4 1ec66525-a7e9-450f-83df-03d9957837d5
 1 BFZ creature NO Void Winnower 70ac902e-1eb5-4f83-a5a6-00ac89cfe50f 8cbedb0a-34ca-4d42-bb43-cbea0f3c6d02

 1 ROE enchantment NO Awakening Zone f955bc96-d602-4142-a9a2-87009cc7028c 080dbd69-95a8-4fed-bbaf-875a8a34a2c9

 1 SLD sorcery NO All Is Dust 14693689-d087-43b6-9c3f-63ab0648fc20 2bc7280c-8136-4ac3-b2d6-6679e13b0470
 1 ROE sorcery NO Essence Feed c29b997a-5be6-4d51-a81b-d00677ef401d b9cf2116-7ae5-4b6a-830a-919a55235690
 1 ROE sorcery NO Skittering Invasion cf890abd-b282-4dbb-ac86-9e7caec1c1b8 270f0e5b-2c46-4816-a195-cfce16570bde
 1 BFZ sorcery NO Swarm Surge 77b98632-e103-44fa-a940-2c3b2897b60f 837287cc-f3a4-4ba7-8518-9b1e4a53acda
 1 OGW sorcery NO Witness the End 340d2261-9454-4ab0-827c-49c7e76c7781 0c06d8ec-55ab-4be9-a470-77c79d643d1f

 15 TEMN token NO Eldrazi Horror 294116b1-58c6-40bb-8997-0deda327c522 11d25bde-a303-4b06-a3e1-4ad642deae58
 25 TBFZ token NO Eldrazi Scion 0eb3cd4b-c34e-448c-a9ab-e7b0b4524833 5a5c74d5-b219-4514-8fd6-62705459422c
 15 TROE token NO Eldrazi Spawn 3aaf906a-e749-4e86-ac79-97650b92f271 e0e3826c-3c85-4910-bd6c-04894ea328d0
 5 TPCA token NO Eldrazi 8ce49358-21b3-4b5c-ad8c-a07ac256dee4 f9a7ed9a-25e4-41ad-a53e-d589e923af2c

 ## Too Strong ##
 1 ROE creature NO It That Betrays b11187ab-f8a8-422b-b550-4495f96de0f2 34d790ad-3559-4c32-9057-e2e326740bdc
 1 BFZ creature NO Desolation Twin c0cb1f37-1679-42c7-a794-81e088157eeb 4d229d8d-5e64-4403-a4ae-a0a186a83935
 1 BFZ creature NO Breaker of Armies 0be1ace3-2b3d-4465-b63a-be523f73df36 784e843e-7010-466d-adbd-1dd1595aead1
 1 ROE creature NO Pathrazer of Ulamog 4bf95747-4572-49b8-b892-87fe7f910252 3fdd84b5-fd93-483e-a131-028d04d9dea7
 1 BFZ creature NO Void Winnower 70ac902e-1eb5-4f83-a5a6-00ac89cfe50f 8cbedb0a-34ca-4d42-bb43-cbea0f3c6d02
 1 ROE creature NO Ulamog's Crusher 597bce51-af89-4d13-9a97-667b4f4f4694 76bacedb-9fa8-4a21-b0eb-e7ead64360b4
 1 ROE creature NO Hand of Emrakul b206d3bc-1203-4f00-997e-5da706346a24 84d602f4-5876-416a-95e5-821a285358bf
 1 BFZ creature NO Bane of Bala Ged 38839894-1706-4e11-8310-5ea8dd8866d9 3741e62a-4b86-46ff-a7df-a8ceaf3b9a0c
 1 SLD sorcery NO All Is Dust 14693689-d087-43b6-9c3f-63ab0648fc20 2bc7280c-8136-4ac3-b2d6-6679e13b0470
 1 TPCA token NO Eldrazi 8ce49358-21b3-4b5c-ad8c-a07ac256dee4 f9a7ed9a-25e4-41ad-a53e-d589e923af2c

 ## Available Tokens ##
 1 TBFZ token NO Eldrazi 41014a6a-0f5b-48ae-8cb8-9a89f0f0180f 30ff04d5-ecaf-4be2-94f4-d5409f1c1e4e
 1 ROE creature NO Emrakul, the Aeons Torn 900ca697-ad38-4b2b-bc74-2ff7eb6ea951 67600383-bbb8-411c-b8e6-2296650bc747
 1 ROE creature NO Kozilek, Butcher of Truth 7b8528b0-71eb-4c9e-bed9-aa2d2e84038f 067fac91-2483-4678-b86a-2c54a3a480cf
 1 ROE creature NO Ulamog, the Infinite Gyre b817bc56-9b4d-4c50-bafa-3c652b99578f 225e3cc6-34d0-4f81-9f49-162d97e2ea59

 ## Weak Permanents ##
 1 ZNR artifact NO Forsaken Monument 7777fab1-df3f-467f-b9e2-46dd2bd2166e 0c8f362c-f035-48b3-8e74-ef23240b44f7

 ## Powerfull Permanents ##
 1 EMN creature NO Brisela, Voice of Nightmares b23587e0-9fb7-492e-8bb4-f218e8e4ce6c 5a7a212e-e0b6-4f12-a95c-173cae023f93
 */
