//
//  DeckPickerViewModel.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import Foundation

class DeckPickerViewModel: ObservableObject {
    
    @Published var deckPickedId: Int
    let deckPickers: [DeckPicker]

    init() {
        self.deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        self.deckPickers = [
            DeckPicker(title: "Zombie", intro: "The original horde deck by Peter Knudson", specialRules: "All creatures controlled by the Horde have haste", image: "Zombie", imageArtist: "Igor Kieryluk"),
            DeckPicker(title: "Human", intro: "Humans are a resilient and tenacious creature type. Alone, they might be weak, but together, they can form a devastating wall of force and destruction. This Horde works together to bolster each other so that the whole is far more powerful than the sum of its parts.", specialRules: "All creatures controlled by the Horde have haste and are Humans in addition to their other creature types.", image: "Human", imageArtist: "Zack Stella"),
            DeckPicker(title: "Phyrexian", intro: "This deck dramatically increases the deadliness of the game. The Phyrexians are full of artifact creatures that build off of each other, terrifying global effects, and the ability to weaken their foes and drive them insane through their infected oil.", specialRules: "All creatures controlled by the Horde have haste and are Phyrexians in addition to their other creature types. The Survivors share poison counters. They do not lose the game for having 10 or more poison counters. Every time the Survivors gain one or more poison counters, each Survivor exiles 1 card from the top of each of their libraries face down for each poison counter.", image: "Phyrexian", imageArtist: "Igor Kieryluk"),
            DeckPicker(title: "Sliver", intro: "Slivers are one of the most iconic creature types in Magic history and also one of the scariest. Each creature in this deck adds to the evolution and adaptation of the hive. Just one unlucky genetic quirk can spell doom for the Survivors.", specialRules: "All creatures controlled by the Horde have haste. All of the artifact slivers in the Horde deck are treated as tokens.", image: "Sliver", imageArtist: "Aleksi Briclot"),
            DeckPicker(title: "Eldrazi", intro: "The planes warp, bend, and tear as these unknowable eldritch abominations force their way into our reality. This Horde sucks all life out of your forces until there is nothing left. But that isn't the worst of it. If enough eldrazi seep into our world, nothing will be able to stop their titanic progenitors from traveling through space and time to devour reality itself.", specialRules: "All tokens controlled by the Horde have haste. All eldrazi spawn the Horde controls cannot attack or block. If the Horde controls 10 eldrazi spawn at the start of its precombat main phase, they are sacrificed, and the Horde casts the three eldrazi titans from exile.", image: "Eldrazi", imageArtist: "Aleksi Briclot")
        ]
    }
    
    // MARK: Buttons
    
    func pickDeck(deckId: Int) {
        deckPickedId = deckId
    }
    
    func startGame() {
        UserDefaults.standard.set(deckPickedId, forKey: "DeckPickedId")
    }
}

struct DeckPicker {
    let title: String
    let intro: String
    let specialRules: String
    let image: String
    let imageArtist: String
}
