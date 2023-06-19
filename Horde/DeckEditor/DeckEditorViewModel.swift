//
//  DeckEditorViewModel.swift
//  Horde
//
//  Created by Loic D on 11/07/2022.
//

import Foundation
import UIKit
import UniformTypeIdentifiers

class DeckEditorViewModel: ObservableObject {
    
    @Published var selectedDeckListNumber: Int = DeckSelectionNumber.deckList
    @Published var deck: DeckEditorCardList = DeckEditorCardList(deckList: MainDeckList(creatures: [], tokens: [], instantsAndSorceries: [], artifactsAndEnchantments: []), tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
    @Published var deckSelectionInfo: String = ""
    @Published var searchProgressInfo: String = "Let's search for some cards"
    @Published var popUpText: String = ""
    @Published var searchResult: [CardFromCardSearch] = []
    @Published var cardToShow: Card? //= Card(cardName: "AAAA", cardType: .token)
    @Published var cardToShowReprints: [Card] = []
    @Published var showDeckEditorInfoView: Bool = false
    @Published var deckId: Int = -1
    @Published var cardCountForSelectedDeck: String = ""
    @Published var carouselIndex = 0
    @Published var showSaveButton = false
    
    func changeSelectedDeckTo(newSelectedDeck: Int) {
        selectedDeckListNumber = newSelectedDeck
        
        if selectedDeckListNumber == DeckSelectionNumber.deckList {
            deckSelectionInfo = "Cards and tokens in the Horde library"
        } else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList {
            deckSelectionInfo = "Select cards that are too strong to be drawn during the first turns (like boardwipes)"
        } else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList {
            deckSelectionInfo = "Tokens/spells that the horde could have to create/cast during the game"
        } else if selectedDeckListNumber == DeckSelectionNumber.weakPermanentsList {
            deckSelectionInfo = "Weak permanents the Horde could start the game with"
        } else if selectedDeckListNumber == DeckSelectionNumber.powerfullPermanentsList {
            deckSelectionInfo = "Powerfull permanents the Horde can spawn at milestones or between marathon stages"
        }
        
        updateCardCountForSelectedDeck()
    }
    
    func updateCardCountForSelectedDeck() {
        var deckList: [Card] = []
        var count = 0
        if selectedDeckListNumber == DeckSelectionNumber.deckList {
            deckList = deck.deckList.creatures + deck.deckList.instantsAndSorceries + deck.deckList.artifactsAndEnchantments + deck.deckList.tokens
        } else {
            deckList = getSelectedDeck()
        }
        
        for card in deckList {
            count += card.cardCount
        }
        
        if count == 0 {
            cardCountForSelectedDeck = ""
        } else if count == 1 {
            cardCountForSelectedDeck = "\(count) card"
        } else {
            cardCountForSelectedDeck = "\(count) cards"
        }
    }
       
    func getCardTypeFromTypeLine(typeLine: String) -> CardType {
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
    
    func cardHasGraveyardKeyword(keywords: [String]) -> Bool {
        let keywordToSearch: [String] = ["flashback", "aftermath"]
        
        for keyword in keywords {
            if keywordToSearch.contains(keyword.lowercased()) {
                return true
            }
        }
        return false
    }
    
    func getSelectedDeck(card: Card? = nil) -> [Card] {
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            if card ==  nil {
                return []
            }
            if card!.cardType == .creature {
                return deck.deckList.creatures
            } else  if card!.cardType == .token {
                return deck.deckList.tokens
            } else if card!.cardType == .instant || card!.cardType == .sorcery {
                return deck.deckList.instantsAndSorceries
            } else {
                return deck.deckList.artifactsAndEnchantments
            }
        }
        else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList
        {
            return deck.tooStrongPermanentsList
        }
        else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList
        {
            return deck.availableTokensList
        }
        else if selectedDeckListNumber == DeckSelectionNumber.weakPermanentsList
        {
            return deck.weakPermanentsList
        }
        else if selectedDeckListNumber == DeckSelectionNumber.powerfullPermanentsList
        {
            return deck.powerfullPermanentsList
        }
        return []
    }
    
    func saveToSelectedDeck(deckSelected: [Card], card: Card? = nil) {
        let sortedDeckSelected = deckSelected.sorted { ($0.cardName + $0.cardId) < ($1.cardName + $1.cardId) }
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            if card ==  nil {
                return
            }
            if card!.cardType == .creature {
                deck.deckList.creatures = sortedDeckSelected
            } else  if card!.cardType == .token {
                deck.deckList.tokens = sortedDeckSelected
            } else if card!.cardType == .instant || card!.cardType == .sorcery {
                deck.deckList.instantsAndSorceries = sortedDeckSelected
            } else {
                deck.deckList.artifactsAndEnchantments = sortedDeckSelected
            }
        }
        else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList
        {
            deck.tooStrongPermanentsList = sortedDeckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList
        {
            deck.availableTokensList = sortedDeckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.weakPermanentsList
        {
            deck.weakPermanentsList = sortedDeckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.powerfullPermanentsList
        {
            deck.powerfullPermanentsList = sortedDeckSelected
        }
    }
    
    func addCardToSelectedDeck(card: Card, onlyAddOne: Bool = true) {
        let tmpCard = card.recreateCard()
        tmpCard.cardCount = onlyAddOne ? 1 : card.cardCount
        
        if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList
        {
            // Add card if not there, remove it if already there
            if deck.tooStrongPermanentsList.contains(card) {
                deck.tooStrongPermanentsList = removeCardFromSpecificDeck(card: card, deck: deck.tooStrongPermanentsList)
            } else {
                deck.tooStrongPermanentsList.append(tmpCard)
            }
        } else {
            
            // We can't add a token that is already in the horde decklist, this array is just for the tokens spawned by horde's spells
            if selectedDeckListNumber == DeckSelectionNumber.availableTokensList && deck.deckList.tokens.contains(card) {
                return
            }
            
            var deckSelected = getSelectedDeck(card: tmpCard)
            deckSelected.append(tmpCard)
            deckSelected = regroupSameCardInArray(cardArray: deckSelected)
            saveToSelectedDeck(deckSelected: deckSelected, card: tmpCard)
        }
        updateCardCountForSelectedDeck()
        showSaveButton = true
    }
    
    func removeCardFromSelectedDeck(card : Card) {
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            // Removing card in main deck removes it from tooStrong at the same time
            deck.tooStrongPermanentsList = removeCardFromSpecificDeck(card: card, deck: deck.tooStrongPermanentsList)
        }
        var deckSelected = getSelectedDeck(card: card)
        deckSelected = removeCardFromSpecificDeck(card: card, deck: deckSelected)
        saveToSelectedDeck(deckSelected: deckSelected, card: card)
        updateCardCountForSelectedDeck()
        showSaveButton = true
    }
    
    // If cardToShow is in the selected deck, change the type
    func changeCardTypeFromSelectedDeck(card : Card, newCardType: CardType) {
        
        var deckSelected = getSelectedDeck(card: card)
        
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            if deckSelected.contains(card) {
                
                let tmpCard = deckSelected[deckSelected.firstIndex(of: card)!].recreateCard()
                tmpCard.cardType = newCardType
                
                // Remove
                deckSelected = removeCardFromSpecificDeck(card: card, deck: deckSelected, removeCompletely: true)
                saveToSelectedDeck(deckSelected: deckSelected, card: card)
                
                // Add
                addCardToSelectedDeck(card: tmpCard, onlyAddOne: false)
                saveToSelectedDeck(deckSelected: getSelectedDeck(card: tmpCard), card: tmpCard)
                
                // Changing main deck type change in tooStrong at the same time
                deck.tooStrongPermanentsList = changeCardTypeFromSpecificDeck(card: card, newCardType: newCardType, deck: deck.tooStrongPermanentsList)
            }
        } else {
            if deckSelected.firstIndex(of: card) != nil{
                let tmpCard = deckSelected[deckSelected.firstIndex(of: card)!].recreateCard()
                tmpCard.cardType = newCardType
                
                // Remove
                deckSelected = removeCardFromSpecificDeck(card: card, deck: deckSelected, removeCompletely: true)
                saveToSelectedDeck(deckSelected: deckSelected, card: card)
                
                // Add
                addCardToSelectedDeck(card: tmpCard, onlyAddOne: false)
                saveToSelectedDeck(deckSelected: getSelectedDeck(card: tmpCard), card: tmpCard)
            } else {
                deckSelected = changeCardTypeFromSpecificDeck(card: card, newCardType: newCardType, deck: deckSelected)
                saveToSelectedDeck(deckSelected: deckSelected)
            }
        }
        showSaveButton = true
    }
    
    // If cardToShow is in the selected deck, change the flashback boolean
    func changeCardFlashbackFromSelectedDeck(card : Card, newFlashbackValue: Bool) {
        
        var deckSelected = getSelectedDeck(card: card)
        
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            if deckSelected.contains(card) {
                
                let tmpCard = deckSelected[deckSelected.firstIndex(of: card)!].recreateCard()
                tmpCard.hasFlashback = newFlashbackValue
                
                // Remove
                deckSelected = removeCardFromSpecificDeck(card: card, deck: deckSelected, removeCompletely: true)
                saveToSelectedDeck(deckSelected: deckSelected, card: card)
                
                // Add
                addCardToSelectedDeck(card: tmpCard, onlyAddOne: false)
                saveToSelectedDeck(deckSelected: getSelectedDeck(card: tmpCard), card: tmpCard)
                
                // Changing main deck type change in tooStrong at the same time
                deck.tooStrongPermanentsList = changeCardFlashbackValueFromSpecificDeck(card: card, newCardFlashbackValue: newFlashbackValue, deck: deck.tooStrongPermanentsList)
            }
        } else {
            // MUST BE CLEANED
            if deckSelected.firstIndex(of: card) != nil{
                let tmpCard = deckSelected[deckSelected.firstIndex(of: card)!].recreateCard()
                tmpCard.hasFlashback = newFlashbackValue
                
                // Remove
                deckSelected = removeCardFromSpecificDeck(card: card, deck: deckSelected, removeCompletely: true)
                saveToSelectedDeck(deckSelected: deckSelected, card: card)
                
                // Add
                addCardToSelectedDeck(card: tmpCard, onlyAddOne: false)
                saveToSelectedDeck(deckSelected: getSelectedDeck(card: tmpCard), card: tmpCard)
            } else {
                deckSelected = changeCardFlashbackValueFromSpecificDeck(card: card, newCardFlashbackValue: newFlashbackValue, deck: deckSelected)
                saveToSelectedDeck(deckSelected: deckSelected)
            }
        }
        showSaveButton = true
    }
    
    func removeCardFromSpecificDeck(card : Card, deck: [Card], removeCompletely: Bool = false) -> [Card] {
        var tmpArray = deck
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                
                tmpArray[i] = tmpArray[i].recreateCard()
                
                if removeCompletely {
                    tmpArray.remove(at: i)
                    return tmpArray
                }
                
                tmpArray[i].cardCount -= 1
                if tmpArray[i].cardCount <= 0 {
                    tmpArray.remove(at: i)
                }
                
                return tmpArray
            }
        }
        return tmpArray
    }
    
    func changeCardTypeFromSpecificDeck(card : Card, newCardType: CardType, deck: [Card]) -> [Card] {
        let tmpArray = deck
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                tmpArray[i].cardType = newCardType
                
                return tmpArray
            }
        }
        return deck
    }
    
    func changeCardFlashbackValueFromSpecificDeck(card : Card, newCardFlashbackValue: Bool, deck: [Card]) -> [Card] {
        let tmpArray = deck
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                tmpArray[i].hasFlashback = newCardFlashbackValue
                
                return tmpArray
            }
        }
        return deck
    }
    
    func regroupSameCardInArray(cardArray: [Card]) -> [Card] {
        var tmpArray = cardArray
        var i = 0
        while i < tmpArray.count {
            var j = i + 1
            while j < tmpArray.count {
                if tmpArray[i] == tmpArray[j] {
                    // Need to recreate card to trigger foreach update
                    let tmpCard = tmpArray[i].recreateCard()
                    tmpCard.cardCount = tmpArray[i].cardCount + tmpArray[j].cardCount
                    tmpArray[i] = tmpCard
                    print("\(tmpArray[i].cardName) now has \(tmpArray[i].cardCount)")
                    tmpArray.remove(at: j)
                    j -= 1
                }
                j += 1
            }
            i += 1
        }
        return tmpArray
    }
    
    func getAllDecksInMainDeckList() -> [[Card]] {
        return [deck.deckList.creatures, deck.deckList.artifactsAndEnchantments, deck.deckList.instantsAndSorceries, deck.deckList.tokens]
    }
    
    // Is this card in the deck ? If yes, change its type if its different in the deck
    func changeCardToFitCardInSelectedDeck(card: Card) -> Card {
        var deckToCheck: [Card] = []
        if selectedDeckListNumber == DeckSelectionNumber.deckList {
            deckToCheck = deck.deckList.creatures + deck.deckList.instantsAndSorceries + deck.deckList.artifactsAndEnchantments + deck.deckList.tokens
        } else {
            deckToCheck = getSelectedDeck()
        }
        for c in deckToCheck {
            if c == card {
                let tmpCard = card.recreateCard()
                tmpCard.cardType = c.cardType
                tmpCard.hasFlashback = c.hasFlashback
                return tmpCard
            }
        }
        
        return card
    }
    
    struct DeckSelectionNumber {
        static let deckList = 1
        static let tooStrongPermanentsList = 2
        static let availableTokensList = 3
        static let weakPermanentsList = 4
        static let powerfullPermanentsList = 5
    }

    struct DeckDataPattern {
        static let deck = "## Horde Deck ##"
        static let tooStrong = "## Too Strong ##"
        static let availableTokens = "## Available Tokens ##"
        static let weakPermanents = "## Weak Permanents ##"
        static let powerfullPermanents = "## Powerfull Permanents ##"
        static let cardHaveFlashback = "YES"
        static let cardDontHaveFlashback = "NO"
    }
}

// MARK: LOAD & SAVE
extension DeckEditorViewModel {
    func loadExistingDeck(deckId: Int) {
        self.deckId = deckId
        let deckData: String = UserDefaults.standard.object(forKey: "Deck_\(deckId)") as? String ?? ""
        
        createDeckListFromDeckData(deckData: deckData)
        showSaveButton = false
        updateCardCountForSelectedDeck()
    }
    
    func createDeckListFromDeckData(deckData: String) {
        self.deck = DeckEditorCardList(deckList: MainDeckList(creatures: [], tokens: [], instantsAndSorceries: [], artifactsAndEnchantments: []), tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
        
        if deckData != "" {
            let allLines = deckData.components(separatedBy: "\n")
            
            for line in allLines {
                if line.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                    // Change current decklist to add cards to
                    if line == DeckDataPattern.deck {
                        selectedDeckListNumber = DeckSelectionNumber.deckList
                    } else if line == DeckDataPattern.tooStrong {
                        selectedDeckListNumber = DeckSelectionNumber.tooStrongPermanentsList
                    } else if line == DeckDataPattern.availableTokens {
                        selectedDeckListNumber = DeckSelectionNumber.availableTokensList
                    } else if line == DeckDataPattern.weakPermanents {
                        selectedDeckListNumber = DeckSelectionNumber.weakPermanentsList
                    } else if line == DeckDataPattern.powerfullPermanents {
                        selectedDeckListNumber = DeckSelectionNumber.powerfullPermanentsList
                    } else
                    {
                        print(line)
                        // Or add card if its a card
                        let cardDataArray = line.components(separatedBy: " ")
                        
                        let cardCount = Int(cardDataArray[0]) ?? 0

                        if cardDataArray.count >= 7 {
                            var cardName = cardDataArray[4]
                            for i in 5..<cardDataArray.count - 2 {
                                cardName += " " + cardDataArray[i]
                            }
                            
                            let card = Card(cardName: cardName, cardType: getCardTypeFromTypeLine(typeLine: cardDataArray[2]), hasFlashback: cardDataArray[3] == DeckDataPattern.cardHaveFlashback, specificSet: cardDataArray[1], cardOracleId: cardDataArray[cardDataArray.count - 2], cardId: cardDataArray.last ?? "")
                            card.cardCount = cardCount
                            addCardToSelectedDeck(card: card, onlyAddOne: false)
                        }
                    }
                }
            }
            changeSelectedDeckTo(newSelectedDeck: DeckSelectionNumber.deckList)
        }
    }
    
    func saveDeck() {
        // The whole deck is stored in a String, like a text file
        let deckData: String = getDeckDataString()
        print(deckData)
        
        UserDefaults.standard.set(deckData, forKey: "Deck_\(deckId)")
        showSaveButton = false
    }
    
    func getDeckDataString() -> String {
        var deckData: String = ""
        
        deckData.append(DeckDataPattern.deck)
        deckData.append("\n")
        for card in deck.deckList.creatures {
            deckData.append(getCardDataString(card: card))
        }
        deckData.append("\n")
        for card in deck.deckList.artifactsAndEnchantments {
            deckData.append(getCardDataString(card: card))
        }
        deckData.append("\n")
        for card in deck.deckList.instantsAndSorceries {
            deckData.append(getCardDataString(card: card))
        }
        deckData.append("\n")
        for card in deck.deckList.tokens {
            deckData.append(getCardDataString(card: card))
        }
        
        deckData.append("\n")
        deckData.append(DeckDataPattern.tooStrong)
        deckData.append("\n")
        for card in deck.tooStrongPermanentsList {
            deckData.append(getCardDataString(card: card))
        }
        
        deckData.append("\n")
        deckData.append(DeckDataPattern.availableTokens)
        deckData.append("\n")
        for card in deck.availableTokensList {
            deckData.append(getCardDataString(card: card))
        }
        
        deckData.append("\n")
        deckData.append(DeckDataPattern.weakPermanents)
        deckData.append("\n")
        for card in deck.weakPermanentsList {
            deckData.append(getCardDataString(card: card))
        }
        
        deckData.append("\n")
        deckData.append(DeckDataPattern.powerfullPermanents)
        deckData.append("\n")
        for card in deck.powerfullPermanentsList {
            deckData.append(getCardDataString(card: card))
        }
        
        return deckData
    }
    
    func getCardDataString(card: Card) -> String {
        // For tokens we remove the set from the name
        let cardName = card.cardType == .token ? card.cardName.replacingOccurrences(of: card.specificSet, with: "") : card.cardName
        let cardData: String = "\(card.cardCount) \(card.specificSet) \(card.cardType) \(card.hasFlashback ? DeckDataPattern.cardHaveFlashback : DeckDataPattern.cardDontHaveFlashback) \(cardName) \(card.cardOracleId) \(card.cardId)\n"
        return cardData
    }
}

// MARK: BUTTONS
extension DeckEditorViewModel {
    func showCard(card: Card) {
        let tmpCard = card.recreateCard()
        tmpCard.cardCount = 1
        cardToShow = tmpCard
        carouselIndex = 0
        
        // Reset download queue
        DownloadQueue.queue.resetQueue()
        
        // Start searching for card reprint
        searchForCardReprints(card: card)
    }
    
    func isRemoveOneCardButtonEnable(card: Card?) -> Bool {
        if card == nil {
            return false
        }
        return getSelectedDeck(card: card!).contains(card!)
    }
    
    // Need those 2 func, if not card animate like spawn when increasing count
    func addCardShouldBeAnimated(card: Card) -> Bool {
        let deckSelected = getSelectedDeck(card: card)
        return !deckSelected.contains(card)
    }
    
    func removeCardShouldBeAnimated(card: Card) -> Bool {
        let deckSelected = getSelectedDeck(card: card)
        return deckSelected[deckSelected.firstIndex(of: card)!].cardCount == 1
    }
    
    func isDeckTooStrongSelected() -> Bool {
        return selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList
    }
    
    func importDeckFromClipboard() {
        if let deckData = UIPasteboard.general.string {
            createDeckListFromDeckData(deckData: deckData)
            if !deckData.contains(DeckDataPattern.deck){
                popUpText = "Only import decklist made with this app"
            } else {
                popUpText = "Deck list imported from clipboard"
            }
            showSaveButton = true
        }
    }
    
    func exportDeckToClipboard() {
        popUpText = "Deck list copied to clipboard"
        UIPasteboard.general.setValue(getDeckDataString(),
            forPasteboardType: UTType.plainText.identifier)
    }
}

// MARK: QUERRY
extension DeckEditorViewModel {
    func searchCardsFor(text: String, searchingForTokens: Bool) {
        
        if text == "" {
            return
        }
        self.searchResult = []
        self.searchProgressInfo = "Searching ..."
        
        let scryfallSearchApi = "https://api.scryfall.com/cards/search?q=\(text.replacingOccurrences(of: " ", with: "+"))\(searchingForTokens ? "+type%3Atoken" : "")"
        print(scryfallSearchApi)
        
        if let url = URL(string: scryfallSearchApi) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    do {
                        let decodedData: ScryfallQuerry = try JSONDecoder().decode(ScryfallQuerry.self,
                                                                   from: data)
                        DispatchQueue.main.async {
                            if decodedData.data != nil {
                                self.searchResult = []
                                decodedData.data!.forEach {
                                    self.searchResult.append(CardFromCardSearch(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.type_line ?? "Artifact"), hasFlashback: self.cardHasGraveyardKeyword(keywords: $0.keywords ?? []), specificSet: $0.set ?? "", cardOracleId: $0.oracle_id ?? "", cardId: $0.id ?? "", manaCost: $0.mana_cost ?? ""))
                                }
                            }
                            self.searchProgressInfo = "Nothing found"
                        }
                    } catch DecodingError.keyNotFound(let key, let context) {
                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.dataCorrupted(let context) {
                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    } catch let error as NSError {
                        NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
            }
            
            urlSession.resume()
        }
    }

    // Add to cardToShowReprints every print of the cardToShow card except the one from cardToShow
    func searchForCardReprints(card: Card) {

        if card.cardOracleId == "" {
            return
        }
        
        DownloadQueue.queue.resetQueue()
        self.cardToShowReprints = []
        
        let scryfallSearchUrl = "https://api.scryfall.com/cards/search?order=released&q=oracleid%3A\(card.cardOracleId)&unique=prints"
        print(scryfallSearchUrl)
        
        if let url = URL(string: scryfallSearchUrl) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    do {
                        let decodedData: ScryfallQuerry = try JSONDecoder().decode(ScryfallQuerry.self,
                                                                   from: data)
                        DispatchQueue.main.async {
                            if decodedData.data != nil {
                                self.cardToShowReprints = []
                                decodedData.data!.forEach {
                                    if ($0.id ?? "") != card.cardId {
                                        self.cardToShowReprints.append(Card(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.type_line ?? "Artifact"), hasFlashback: self.cardHasGraveyardKeyword(keywords: $0.keywords ?? []), specificSet: $0.set ?? "", cardOracleId: $0.oracle_id ?? "", cardId: $0.id ?? ""))
                                    }
                                }
                            }
                        }
                    } catch DecodingError.keyNotFound(let key, let context) {
                        Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.dataCorrupted(let context) {
                        Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                    } catch let error as NSError {
                        NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
            }
            
            urlSession.resume()
        }
    }
}

// MARK: DECKINFO
extension DeckEditorViewModel {
    
    func saveImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "Deck_\(deckId)_Image")
    }

    func loadImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "Deck_\(deckId)_Image") else { return nil }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        return UIImage(data: decoded)
    }
    
    func saveDeckName(text: String) {
        UserDefaults.standard.set(text, forKey: "Deck_\(deckId)_DeckName")
    }
    
    func loadDeckName() -> String {
        return UserDefaults.standard.object(forKey: "Deck_\(deckId)_DeckName") as? String ?? "Deck \(deckId + 1)"
    }
    
    func saveIntroText(text: String) {
        UserDefaults.standard.set(text, forKey: "Deck_\(deckId)_Intro")
    }
    
    func loadIntroText() -> String {
        return UserDefaults.standard.object(forKey: "Deck_\(deckId)_Intro") as? String ?? ""
    }
    
    func saveRulesText(text: String) {
        UserDefaults.standard.set(text, forKey: "Deck_\(deckId)_Rules")
    }
    
    func loadRulesText() -> String {
        return UserDefaults.standard.object(forKey: "Deck_\(deckId)_Rules") as? String ?? "All creatures controlled by the Horde have haste."
    }
}
