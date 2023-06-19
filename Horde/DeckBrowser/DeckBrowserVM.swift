//
//  DeckBrowserVM.swift
//  Horde
//
//  Created by Loic D on 19/06/2023.
//

import Foundation

class DeckBrowserViewModel: ObservableObject {
    @Published var selectedDeck: DeckBrowserDeck?
    @Published var decks: [DeckBrowserDeck] = [
        DeckBrowserDeck(title: "ae", author: "aeaea", authorId: "err", deckList: "azeze", intro: "azeaze", rules: "azeez", artId: "Dinosaur"),
        DeckBrowserDeck(title: "ae", author: "aeaea", authorId: "err", deckList: "azeze", intro: "azeaze", rules: "azeez", artId: "Eldrazi"),
        DeckBrowserDeck(title: "ae", author: "aeaea", authorId: "err", deckList: "azeze", intro: "azeaze", rules: "azeez", artId: "Human"),
        DeckBrowserDeck(title: "ae", author: "aeaea", authorId: "err", deckList: "azeze", intro: "azeaze", rules: "azeez", artId: "Zombie")
    ]
    
    func setSelectedDeck(_ selectedDeck: DeckBrowserDeck?) {
        self.selectedDeck = selectedDeck
    }
}

struct DeckBrowserDeck: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let authorId: String
    let deckList: String
    let intro: String
    let rules: String
    let artId: String
}
