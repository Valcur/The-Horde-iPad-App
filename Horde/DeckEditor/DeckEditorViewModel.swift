//
//  DeckEditorViewModel.swift
//  Horde
//
//  Created by Loic D on 11/07/2022.
//

import Foundation

class DeckEditorViewModel: ObservableObject {
    
    @Published var selectedDeckList: Int = DeckSelectionNumber.deckList
    @Published var deck: DeckEditorCardList
    @Published var deckSelectionInfo: String = ""
    @Published var searchResult: [Card] = []
    @Published var cardToShow: Card? = nil
    
    init() {
        deck = DeckEditorCardList(deckList: [], tooStrongPermanentsList: [], availableTokensList: [], weakPermanentsList: [], powerfullPermanentsList: [])
        changeSelectedDeckTo(newSelectedDeck: DeckSelectionNumber.deckList)
        
        // If user clicked on an existing deck, load the decklist
    }
    
    func addCardToSelectedDeck(card: Card) {
        if selectedDeckList == DeckSelectionNumber.deckList {
            deck.deckList.append(card)
        } else if selectedDeckList == DeckSelectionNumber.tooStrongPermanentsList {
            deck.tooStrongPermanentsList.append(card)
        } else if selectedDeckList == DeckSelectionNumber.availableTokensList {
            deck.availableTokensList.append(card)
        } else if selectedDeckList == DeckSelectionNumber.weakPermanentsList {
            deck.weakPermanentsList.append(card)
        } else if selectedDeckList == DeckSelectionNumber.powerfullPermanentsList {
            deck.powerfullPermanentsList.append(card)
        }
    }
    
    func loadExistingDeck() {
        
    }
    
    func saveDeck() {
        
    }
    
    func changeSelectedDeckTo(newSelectedDeck: Int) {
        selectedDeckList = newSelectedDeck
        
        if selectedDeckList == DeckSelectionNumber.deckList {
            deckSelectionInfo = "Cards and token in your deck"
        } else if selectedDeckList == DeckSelectionNumber.tooStrongPermanentsList {
            deckSelectionInfo = "Cards too strong to be drawed during the first turns"
        } else if selectedDeckList == DeckSelectionNumber.availableTokensList {
            deckSelectionInfo = "Tokens that could be spawned by card drawed by the horde"
        } else if selectedDeckList == DeckSelectionNumber.weakPermanentsList {
            deckSelectionInfo = "Weak permanents the Horde could start with"
        } else if selectedDeckList == DeckSelectionNumber.powerfullPermanentsList {
            deckSelectionInfo = "Powerfull permanents the Horde can spawn at milestones or between marathon stages"
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
                                self.searchResult.append(Card(cardName: $0.name ?? "", cardType: self.getCardTypeFromTypeLine(typeLine: $0.typeLine ?? "Creature")))
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
        return CardType.artifact
    }
    
    struct DeckEditorCardList {
        var deckList: [Card]
        var tooStrongPermanentsList: [Card]
        var availableTokensList: [Card]
        var weakPermanentsList: [Card]
        var powerfullPermanentsList: [Card]
    }
    
    struct DeckSelectionNumber {
        static let deckList = 1
        static let tooStrongPermanentsList = 2
        static let availableTokensList = 3
        static let weakPermanentsList = 4
        static let powerfullPermanentsList = 5
    }
}
