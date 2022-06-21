//
//  DeckPickerViewModel.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import Foundation

class DeckPickerViewModel: ObservableObject {
    
    @Published var deckPickedId: Int
    var deckPickers: [DeckPicker]

    init() {
        self.deckPickedId = -1
        self.deckPickers = [
            DeckPicker(id: DecksId.zombie, title: "Zombie", intro: "The original horde deck by Peter Knudson", specialRules: "All creatures controlled by the Horde have haste", image: "Zombie", imageArtist: "Grzegorz Rutkowski"),
            
            DeckPicker(id: DecksId.human, title: "Human", intro: "A modified version of the Armies of Men deck by TenkayCrit", specialRules: "All creatures controlled by the Horde have haste and are Humans in addition to their other creature types.", image: "Human", imageArtist: "Antonio José Manzanedo"),
            
            DeckPicker(id: DecksId.phyrexian, title: "Phyrexian", intro: "A modified version of the Phyrexian Perfection deck by TenkayCrit", specialRules: "All creatures controlled by the Horde have haste. The Survivors share poison counters. They do not lose the game for having 10 or more poison counters. Every time the Survivors gain one or more poison counters, each Survivor exiles 1 card from the top of each of their libraries face down for each poison counter.", image: "Phyrexian", imageArtist: "Igor Kieryluk"),
            
            //DeckPicker(id: DecksId.phyrexian, title: "Phyrexian", intro: "A modified version of the Phyrexian Perfection deck by TenkayCrit", specialRules: "All creatures controlled by the Horde have haste. The Survivors share poison counters. They do not lose the game for having 10 or more poison counters. At the beginning of each upkeep, each Survivor exiles 1 card from the top of each of their libraries face down for each poison counter.", image: "Phyrexian", imageArtist: "Igor Kieryluk"),
            
            DeckPicker(id: DecksId.sliver, title: "Sliver", intro: "A modified version of the Sliver Hive deck by TenkayCrit", specialRules: "All creatures controlled by the Horde have haste. All of the artifact slivers in the Horde deck are treated as tokens.", image: "Sliver", imageArtist: "Aleksi Briclot"),
            
            DeckPicker(id: DecksId.dinosaur, title: "Dinosaur", intro: "A modified version of the Dinosaur Rage deck by TenkayCrit", specialRules: " All creatures controlled by the Horde have haste.", image: "Dinosaur", imageArtist: "Grzegorz Rutkowski"),
            
            DeckPicker(id: DecksId.eldrazi, title: "Eldrazi", intro: "A modified version of the Eldrazi Horror deck by TenkayCrit", specialRules: "All tokens controlled by the Horde have haste. All eldrazi spawn the Horde controls cannot attack or block. If the Horde controls 10 eldrazi spawn at the start of its precombat main phase, they are sacrificed, and the Horde casts the three eldrazi titans from exile.", image: "Eldrazi", imageArtist: "Aleksi Briclot"),
            
            DeckPicker(id: DecksId.nature, title: "Nature", intro: "", specialRules: "All tokens controlled by the Horde have haste.", image: "Nature", imageArtist: "Grzegorz Rutkowski")
        ]
        
        deckPickers.sort {
            $0.id < $1.id
        }
    }
    
    // MARK: Buttons
    
    func pickDeck(deckId: Int) {
        deckPickedId = deckId
        savePickedDeckId()
    }
    
    private func savePickedDeckId() {
        UserDefaults.standard.set(deckPickedId, forKey: "DeckPickedId")
    }
}

struct DeckPicker: Hashable {
    let id: Int
    let title: String
    let intro: String
    let specialRules: String
    let image: String
    let imageArtist: String
}

struct DecksId {
    static let zombie = 0
    static let human = 1
    static let dinosaur = 2
    static let nature = 3
    static let phyrexian = 4
    static let sliver = 5
    static let eldrazi = 6
}
