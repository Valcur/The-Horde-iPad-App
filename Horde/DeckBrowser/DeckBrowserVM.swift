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
    let hordeVM: HordeAppViewModel
    let db = Firestore.firestore()
    @Published var selectedDeck: DeckBrowserDeck?
    @Published var searchResultMessage: String = ""
    @Published var decks: [DeckBrowserDeck] = []
    @Published var resultStatus: ResultStatus = .mostRecent
    
    init(hordeVM: HordeAppViewModel) {
        self.hordeVM = hordeVM
        iniRecentDecks()
    }
    
    func iniRecentDecks() {
        searchResultMessage = "Loading most recent decks"
        decks = []
        resultStatus = .progress

        let query = db.collection("decks").whereField("public", isEqualTo: true).order(by: "lastModified", descending: true).limit(to: 14)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.resultStatus = .error
            } else {
                for deck in querySnapshot!.documents {
                    self.decks.append(self.newDeckWithData(deck.data()))
                }
                self.resultStatus = .mostRecent
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
    
    func seeAllDecks() {
        searchResultMessage = "Loading all decks"
        decks = []
        resultStatus = .progress
        
        let query = db.collection("decks").whereField("public", isEqualTo: true).order(by: "lastModified", descending: true)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.resultStatus = .error
            } else {
                for deck in querySnapshot!.documents {
                    self.decks.append(self.newDeckWithData(deck.data()))
                }
                self.resultStatus = .allRecent
            }
        }
    }
    
    func searchForDecks(withText: String) {
        if withText.count <= 1 {
            return
        }
        
        searchResultMessage = "Searching decks for \(withText)"
        decks = []
        resultStatus = .progress
        
        let splited = withText.lowercased().components(separatedBy: " ").filter({ $0.count > 1 })

        let query = db.collection("decks").whereField("public", isEqualTo: true).whereField("nameKeywords", arrayContainsAny: splited).order(by: "lastModified", descending: true)
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.resultStatus = .error
            } else {
                for deck in querySnapshot!.documents {
                    self.decks.append(self.newDeckWithData(deck.data()))
                }
                print(self.decks)
                self.resultStatus = .nameSearch
            }
        }
    }
    
    func addToYourDecks(progressMessage: Binding<String>) {
        progressMessage.wrappedValue = ""
        
        if let deck = selectedDeck, let deckImage = selectedDeck?.image {
            for id in 0..<hordeVM.numberOfDeckSlot {
                // On ajoute dans le premier slot vide disponible
                if !(UserDefaults.standard.object(forKey: "Deck_\(id)_Exist") as? Bool ?? false) {
                    guard let data = deckImage.jpegData(compressionQuality: 0.5) else { return }
                    let encoded = try! PropertyListEncoder().encode(data)
                    UserDefaults.standard.set(true, forKey: "Deck_\(id)_Exist")
                    UserDefaults.standard.set(deck.title, forKey: "Deck_\(id)_DeckName")
                    UserDefaults.standard.set(deck.intro, forKey: "Deck_\(id)_Intro")
                    UserDefaults.standard.set(deck.rules, forKey: "Deck_\(id)_Rules")
                    UserDefaults.standard.set(encoded, forKey: "Deck_\(id)_Image")
                    UserDefaults.standard.set(deck.deckList, forKey: "Deck_\(id)")
                    
                    hordeVM.createDeck(deckId: id)
                    
                    progressMessage.wrappedValue = "Deck added"
                    
                    return
                }
            }
        }
        progressMessage.wrappedValue = "No deck slots available"
    }
    
    func playWithSelectedDeck() {
        guard let selectedDeck = selectedDeck else { return }
        
        UserDefaults.standard.set(selectedDeck.deckList, forKey: "Deck_-999")
        UserDefaults.standard.set(-999 , forKey: "DeckPickedId")
    }
}

class DeckBrowserDeck: Identifiable, ObservableObject, Equatable {
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
    
    static func == (lhs: DeckBrowserDeck, rhs: DeckBrowserDeck) -> Bool {
        return lhs.title == rhs.title &&
        lhs.authorId == rhs.authorId &&
        lhs.deckList == rhs.deckList &&
        lhs.intro == rhs.intro &&
        lhs.rules == rhs.rules &&
        lhs.artId == rhs.artId
    }
}

enum ResultStatus: Int {
    case mostRecent = 1
    case allRecent = 2
    case nameSearch = 3
    case error = -1
    case progress = 0
}
