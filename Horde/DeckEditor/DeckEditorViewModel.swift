//
//  DeckEditorViewModel.swift
//  Horde
//
//  Created by Loic D on 11/07/2022.
//

import Foundation

class DeckEditorViewModel: ObservableObject {
    
    @Published var selectedDeckListNumber: Int = DeckSelectionNumber.deckList
    @Published var deck: DeckEditorCardList
    @Published var deckSelectionInfo: String = ""
    @Published var searchProgressInfo: String = "Let's search some cards"
    @Published var searchResult: [CardFromCardSearch] = []
    @Published var cardToShow: Card? = nil
    @Published var cardToShowReprints: [Card] = []
    @Published var showDeckEditorInfoView: Bool = false
    var deckId: Int = 2
    
    init() {
        deck = DeckEditorCardList(deckList: MainDeckList(creatures: [], tokens: [], instantsAndSorceries: [], artifactsAndEnchantments: []), tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
        changeSelectedDeckTo(newSelectedDeck: DeckSelectionNumber.deckList)
        
        // If user clicked on an existing deck, load the decklist
        loadExistingDeck()
    }
    
    func changeSelectedDeckTo(newSelectedDeck: Int) {
        selectedDeckListNumber = newSelectedDeck
        
        if selectedDeckListNumber == DeckSelectionNumber.deckList {
            deckSelectionInfo = "Cards and tokens in the Horde library"
        } else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList {
            deckSelectionInfo = "Select cards that are too strong to be drawed during the first turns (like boardwipes)"
        } else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList {
            deckSelectionInfo = "Tokens that could be spawned by cards drawed by the horde"
        } else if selectedDeckListNumber == DeckSelectionNumber.weakPermanentsList {
            deckSelectionInfo = "Weak permanents the Horde could start with"
        } else if selectedDeckListNumber == DeckSelectionNumber.powerfullPermanentsList {
            deckSelectionInfo = "Powerfull permanents the Horde can spawn at milestones or between marathon stages"
        }
        
        // If cardShow not empty, change the cardType to match what is on this deck
        if cardToShow != nil {
            let cardTypesToCheck: [CardType] = [.creature, .token, .instant, .sorcery, .artifact, .enchantment]
            for tmpCardType in cardTypesToCheck {
                let tmpCard = cardToShow?.recreateCard()
                tmpCard?.cardType = tmpCardType
                let deckSelected = getSelectedDeck(card: tmpCard)
                if deckSelected.contains(tmpCard!) {
                    cardToShow = tmpCard
                }
            }
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
        if selectedDeckListNumber == DeckSelectionNumber.deckList
        {
            if card ==  nil {
                return
            }
            if card!.cardType == .creature {
                deck.deckList.creatures = deckSelected
            } else  if card!.cardType == .token {
                deck.deckList.tokens = deckSelected
            } else if card!.cardType == .instant || card!.cardType == .sorcery {
                deck.deckList.instantsAndSorceries = deckSelected
            } else {
                deck.deckList.artifactsAndEnchantments = deckSelected
            }
        }
        else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList
        {
            deck.tooStrongPermanentsList = deckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList
        {
            deck.availableTokensList = deckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.weakPermanentsList
        {
            deck.weakPermanentsList = deckSelected
        }
        else if selectedDeckListNumber == DeckSelectionNumber.powerfullPermanentsList
        {
            deck.powerfullPermanentsList = deckSelected
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
            deckSelected = changeCardTypeFromSpecificDeck(card: card, newCardType: newCardType, deck: deckSelected)
            saveToSelectedDeck(deckSelected: deckSelected, card: card)
        }
    }
    
    func removeCardFromSpecificDeck(card : Card, deck: [Card], removeCompletely: Bool = false) -> [Card] {
        var tmpArray = deck
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                
                let tmpCard = Card(cardName: tmpArray[i].cardName, cardType: tmpArray[i].cardType)
                tmpCard.cardCount = tmpArray[i].cardCount
                tmpCard.cardUIImage = tmpArray[i].cardUIImage
                tmpArray[i] = tmpCard
                
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
                card.cardType = newCardType
                
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
    func loadExistingDeck() {
        let deckData: String = UserDefaults.standard.object(forKey: "Deck_\(deckId)") as? String ?? ""
        
        if deckData != "" {
            let allLines = deckData.components(separatedBy: "\n")
            
            for line in allLines {
                if line != "" {
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
                        // Or add card if its a card
                        let cardDataArray = line.components(separatedBy: " ")
                        
                        let cardCount = Int(cardDataArray[0]) ?? 0
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
            selectedDeckListNumber = DeckSelectionNumber.deckList
        } else {
            /*
            addCardToSelectedDeck(card: Card(cardName: "Adult Gold Dragon", cardType: .creature, specificSet: "AFR"))
            addCardToSelectedDeck(card: Card(cardName: "Death by Dragons", cardType: .sorcery, specificSet: "cma"))
            addCardToSelectedDeck(card: Card(cardName: "Dragon Appeasement", cardType: .enchantment, specificSet: "ARB"))
            addCardToSelectedDeck(card: Card(cardName: "Ancient Copper Dragon", cardType: .creature, hasFlashback: true, specificSet: "CLB"))
            addCardToSelectedDeck(card: Card(cardName: "Cat Dragon", cardType: .token, specificSet: "T2X2"))
            addCardToSelectedDeck(card: Card(cardName: "Dragon", cardType: .token, specificSet: "TCLB"))
            
            selectedDeckListNumber = DeckSelectionNumber.tooStrongPermanentsList
            addCardToSelectedDeck(card: Card(cardName: "Adult Gold Dragon", cardType: .creature, specificSet: "AFR"))
            
            selectedDeckListNumber = DeckSelectionNumber.powerfullPermanentsList
            addCardToSelectedDeck(card: Card(cardName: "Adult Gold Dragon", cardType: .creature, specificSet: "AFR"))
            
            selectedDeckListNumber = DeckSelectionNumber.deckList
            */
        }
    }
    
    func saveDeck() {
        // The whole deck is stored in a String, like a text file
        let deckData: String = getDeckDataString()
        print(deckData)
        
        UserDefaults.standard.set(deckData, forKey: "Deck_\(deckId)")
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
        
        // Start searching for card reprint
        searchForCardReprints(card: card)
    }
    
    func isRemoveOneCardButtonEnable() -> Bool {
        if cardToShow == nil {
            return false
        }
        return getSelectedDeck(card: cardToShow).contains(cardToShow!)
    }
    
    // Need those 2 func, if not card animate like spawn when increasing count
    func addCardShouldBeAnimated() -> Bool {
        if cardToShow == nil {
            return false
        }
        let deckSelected = getSelectedDeck(card: cardToShow)
        return !deckSelected.contains(cardToShow!)
    }
    
    func removeCardShouldBeAnimated() -> Bool {
        if cardToShow == nil {
            return false
        }
        let deckSelected = getSelectedDeck(card: cardToShow)
        return deckSelected[deckSelected.firstIndex(of: cardToShow!)!].cardCount == 1
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
        //print(scryfallSearchApi)
        
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
                                decodedData.data!.forEach {
                                    self.searchResult.append(CardFromCardSearch(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.type_line ?? "Artifact"), specificSet: $0.set ?? "", cardOracleId: $0.oracle_id ?? "", cardId: $0.id ?? "", manaCost: $0.mana_cost ?? ""))
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
        
        cardToShowReprints = []
        
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
                                decodedData.data!.forEach {
                                    if ($0.set ?? "").uppercased() != card.specificSet.uppercased() {
                                        self.cardToShowReprints.append(CardFromCardSearch(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.type_line ?? "Artifact"), specificSet: $0.set ?? "", cardOracleId: $0.oracle_id ?? "", cardId: $0.id ?? "", manaCost: $0.mana_cost ?? ""))
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
