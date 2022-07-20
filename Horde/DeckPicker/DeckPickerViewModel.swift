//
//  DeckPickerViewModel.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import Foundation
import SwiftUI

class DeckPickerViewModel: ObservableObject {
    
    @Published var deckPickedId: Int

    init() {
        self.deckPickedId = -1
    }
    
    // MARK: Buttons
    
    func pickDeck(deckId: Int) {
        deckPickedId = deckId
        savePickedDeckId()
    }
    
    private func savePickedDeckId() {
        UserDefaults.standard.set(deckPickedId, forKey: "DeckPickedId")
    }
    
    func deckForIdExist(id: Int) -> Bool {
        return UserDefaults.standard.object(forKey: "Deck_\(id)_Exist") as? Bool ?? false
    }
    
    func getDeck(id: Int) -> DeckPicker {
        let deckName = UserDefaults.standard.object(forKey: "Deck_\(id)_DeckName") as? String ?? "Deck \(id)"
        let deckIntro = UserDefaults.standard.object(forKey: "Deck_\(id)_Intro") as? String ?? ""
        let deckRules = UserDefaults.standard.object(forKey: "Deck_\(id)_Rules") as? String ?? ""
        let deckImage = getDeckImage(id: id)

        return DeckPicker(id: id, title: deckName, intro: deckIntro, specialRules: deckRules, image: deckImage, imageArtist: "")
    }
    
    private func getDeckImage(id: Int) -> Image{
        guard let data = UserDefaults.standard.data(forKey: "Deck_\(id)_Image") else { return Image("BlackBackground") }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let inputImage = UIImage(data: decoded)
        
        guard let inputImage = inputImage else {
            return Image("BlackBackground")
        }
        return Image(uiImage: inputImage)
    }
    
    func createDeck(id: Int) {
        UserDefaults.standard.set(true, forKey: "Deck_\(id)_Exist")
        editDeck(id: id)
    }
    
    func editDeck(id: Int) {
        pickDeck(deckId: id)
    }
    
    func deleteDeck(id: Int) {
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)_Exist")
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)_DeckName")
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)_Intro")
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)_Rules")
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)_Image")
        UserDefaults.standard.removeObject(forKey: "Deck_\(id)")
        self.deckPickedId = id
    }
}

struct DeckPicker {
    let id: Int
    let title: String
    let intro: String
    let specialRules: String
    let image: Image
    let imageArtist: String
}

struct DecksId {
    static let zombie = 0
    static let human = 1
    static let dinosaur = 2
    static let nature = 3
    static let phyrexian = 5
    static let sliver = 4
    static let eldrazi = 6
}
