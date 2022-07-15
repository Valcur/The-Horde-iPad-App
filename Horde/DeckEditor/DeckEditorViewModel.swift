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
    @Published var searchResult: [Card] = []
    @Published var cardToShow: Card? = nil
    
    init() {
        deck = DeckEditorCardList(deckList: MainDeckList(creatures: [], tokens: [], instantsAndSorceries: [], artifactsAndEnchantments: []), tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
        changeSelectedDeckTo(newSelectedDeck: DeckSelectionNumber.deckList)
        
        // If user clicked on an existing deck, load the decklist
        loadExistingDeck()
    }
    
    func loadExistingDeck() {
        addCardToSelectedDeck(card: Card(cardName: "Polyraptor", cardType: .creature))
        addCardToSelectedDeck(card: Card(cardName: "Counterspell", cardType: .instant))
        addCardToSelectedDeck(card: Card(cardName: "Pacifism", cardType: .enchantment))
        addCardToSelectedDeck(card: Card(cardName: "Veteran Adventurer", cardType: .creature))
        
        selectedDeckListNumber = DeckSelectionNumber.tooStrongPermanentsList
        addCardToSelectedDeck(card: Card(cardName: "Polyraptor", cardType: .creature))
        
        selectedDeckListNumber = DeckSelectionNumber.powerfullPermanentsList
        addCardToSelectedDeck(card: Card(cardName: "Polyraptor", cardType: .creature))
        
        //selectedDeckListNumber = DeckSelectionNumber.deckList
    }
    
    func saveDeck() {
        
    }
    
    func changeSelectedDeckTo(newSelectedDeck: Int) {
        selectedDeckListNumber = newSelectedDeck
        
        if selectedDeckListNumber == DeckSelectionNumber.deckList {
            deckSelectionInfo = "Cards and token in your deck"
        } else if selectedDeckListNumber == DeckSelectionNumber.tooStrongPermanentsList {
            deckSelectionInfo = "Cards too strong to be drawed during the first turns"
        } else if selectedDeckListNumber == DeckSelectionNumber.availableTokensList {
            deckSelectionInfo = "Tokens that could be spawned by card drawed by the horde"
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
    
    func searchCardsFor(text: String, searchingForTokens: Bool) {
        
        if text == "" {
            return
        }
        
        let scryfallSearchApi = "https://api.scryfall.com/cards/search?q=\(text)"
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
                            decodedData.data!.forEach {
                                self.searchResult.append(Card(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.typeLine ?? "Artifact")))
                            }
                        }
                    } catch {
                        print("decode error")
                    }
                }
            }
            
            urlSession.resume()
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
        return CardType.token
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
    
    struct DeckSelectionNumber {
        static let deckList = 1
        static let tooStrongPermanentsList = 2
        static let availableTokensList = 3
        static let weakPermanentsList = 4
        static let powerfullPermanentsList = 5
    }
}
