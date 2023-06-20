//
//  DeckBrowserVM.swift
//  Horde
//
//  Created by Loic D on 19/06/2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class DeckBrowserViewModel: ObservableObject {
    let db = Firestore.firestore()
    @Published var selectedDeck: DeckBrowserDeck?
    @Published var searchResultMessage: String = ""
    @Published var decks: [DeckBrowserDeck] = []
    
    init() {
        iniRecentDecks()
    }
    
    private func iniRecentDecks() {
        searchResultMessage = "Loading most recent decks"
        self.decks = []

        let query = db.collection("decks").whereField("public", isEqualTo: true).order(by: "lastModified", descending: true).limit(to: 5)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for deck in querySnapshot!.documents {
                    self.decks.append(self.newDeckWithData(deck.data()))
                }
            }
        }
    }
    
    private func newDeckWithData(_ deckData: [String: Any]) -> DeckBrowserDeck {
        return DeckBrowserDeck(title: deckData["name"] as! String, author: deckData["author"] as! String, authorId: deckData["authorUuid"] as! String, deckList: deckData["deckList"] as! String, intro: deckData["intro"] as! String, rules: deckData["specialRules"] as! String, artId: deckData["artId"] as! String)
    }
}

extension DeckBrowserViewModel {
    func setSelectedDeck(_ selectedDeck: DeckBrowserDeck?) {
        self.selectedDeck = selectedDeck
    }
    
    func searchForDecks(withText: String) {
        searchResultMessage = "Searching decks for \(withText)"
        // FIREBASE
        //self.decks = self.firebaseResultToDeckArray("")
    }
    
    func seeDeckList() {
        
    }
    
    func addToYourDecks() {
        
    }
}

class DeckBrowserDeck: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let author: String
    let authorId: String
    let deckList: String
    let intro: String
    let rules: String
    let artId: String
    @Published var image: UIImage?
    
    init(title: String, author: String, authorId: String, deckList: String, intro: String, rules: String, artId: String) {
        self.title = title
        self.author = author
        self.authorId = authorId
        self.deckList = deckList
        self.intro = intro
        self.rules = rules
        self.artId = artId
        self.image = nil
        loadDeckImage()
    }
    
    func loadDeckImage() {
        guard let url = URL(string: "https://api.scryfall.com/cards/\(artId)?format=img&version=art_crop") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.objectWillChange.send()
            }
        }.resume()
    }
}
