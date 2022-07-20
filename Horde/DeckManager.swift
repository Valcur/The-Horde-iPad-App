//
//  DeckManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
 
struct DeckManager {
    
    static let boardWipesCards: [Card] = [
        Card(cardName: "Ruinous Ultimatum",cardType: .sorcery),
        Card(cardName: "All Is Dust", cardType: .sorcery),
        Card(cardName: "Phyrexian Rebirth",cardType: .sorcery),
        Card(cardName: "Wakening Sun's Avatar",cardType: .creature),
        Card(cardName: "Ezuri's Predation", cardType: .sorcery),
        Card(cardName: "Harsh Mercy",cardType: .sorcery),
        Card(cardName: "Hour of Reckoning", cardType: .sorcery),
        Card(cardName: "Wrath of God", cardType: .sorcery),
        Card(cardName: "Fumigate",cardType: .sorcery),
        Card(cardName: "Star of Extinction",cardType: .sorcery)
        ]
    
    static private func getNatureDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        // 1 Sandwurm Convergence

        
        // 1 Copperhoof Vorrac
        // 1 Bellowing Tanglewurm
        // 1 Yorvo, Lord of Garenbrig
        // 1 Goreclaw, Terror of Qal Sisma
        // 1 Rhonas the Indomitable -> cool si j'arrive a remplacer
        // 1 Craterhoof Behemoth
        // 1 Nessian Boar
        // 1 Hornet Queen
        // 1 End-Raze Forerunners
        // 1 Grothama, All-Devouring
        
        // 1 Steel Leaf Champion
        // 1 Woodland Champion
        // 1 Mother Bear
        
        // 1 Winds of Qal Sisma
        // 1 Overrun
        // 1 Overwhelming Stampede
        // 1 Heroic Intervention
        // 1 Scale Up
        // 1 Ezuri's Predation
        // 1 Fungal Sprouting
        // 2 Grizzly Fate
        // 1 Shadowbeast Sighting
        // 1 Klothys's Design
        // 1 Call of the Herd
        // 1 Crush of Wurms
        // 1 Beast Attack
        // 1 Parallel Evolution
        // 1 Second Harvest
        // 2 Elephant Ambush
        // 1 Roar of the Wurm
        // 1 Predatory Rampage
        
        // 1 Unnatural Growth
        // 1 Sandwurm Convergence
        // 2 Muraganda Petroglyphs
        // 2 Gaea's Anthem

        // 1 Copperhoof Vorrac
        deck.append(Card(cardName: "Copperhoof Vorrac", cardType: .creature))
        
        // 1 Bellowing Tanglewurm
        deck.append(Card(cardName: "Bellowing Tanglewurm", cardType: .creature))
        
        // 1 Yorvo, Lord of Garenbrig
        deck.append(Card(cardName: "Yorvo, Lord of Garenbrig", cardType: .creature))
        
        // 1 Goreclaw, Terror of Qal Sisma
        deck.append(Card(cardName: "Goreclaw, Terror of Qal Sisma", cardType: .creature))
        
        // 1 Rhonas the Indomitable
        deck.append(Card(cardName: "Rhonas the Indomitable", cardType: .creature))
        
        // 1 Craterhoof Behemoth
        deck.append(Card(cardName: "Craterhoof Behemoth", cardType: .creature))
        
        // 1 Nessian Boar
        deck.append(Card(cardName: "Nessian Boar", cardType: .creature))
        
        // 1 Hornet Queen
        deck.append(Card(cardName: "Hornet Queen", cardType: .creature))
        
        // 1 End-Raze Forerunners
        deck.append(Card(cardName: "End-Raze Forerunners", cardType: .creature))
        
        // 1 Grothama, All-Devouring
        deck.append(Card(cardName: "Grothama, All-Devouring", cardType: .creature))
        
        // 1 Steel Leaf Champion
        deck.append(Card(cardName: "Steel Leaf Champion", cardType: .creature))
        
        // 1 Woodland Champion
        deck.append(Card(cardName: "Woodland Champion", cardType: .creature))
        
        // 1 Mother Bear
        deck.append(Card(cardName: "Mother Bear", cardType: .creature, hasFlashback: true))
        
        // A CHANGER SORCERY INSTANT
        
        // 1 Winds of Qal Sisma
        deck.append(Card(cardName: "Winds of Qal Sisma", cardType: .sorcery))
        
        // 1 Overrun
        deck.append(Card(cardName: "Overrun", cardType: .sorcery))
        
        // 1 Overwhelming Stampede
        deck.append(Card(cardName: "Overwhelming Stampede", cardType: .sorcery))
        
        // 1 Heroic Intervention
        deck.append(Card(cardName: "Heroic Intervention", cardType: .sorcery))
        
        // 1 Scale Up
        deck.append(Card(cardName: "Scale Up", cardType: .sorcery))
        
        // 1 Ezuri's Predation
        deck.append(Card(cardName: "Ezuri's Predation", cardType: .sorcery))
        
        // 1 Fungal Sprouting
        deck.append(Card(cardName: "Fungal Sprouting", cardType: .sorcery))
        
        // 2 Grizzly Fate
        deck.append(Card(cardName: "Grizzly Fate", cardType: .sorcery, hasFlashback: true))
        deck.append(Card(cardName: "Grizzly Fate", cardType: .sorcery, hasFlashback: true))
        
        // 1 Shadowbeast Sighting
        deck.append(Card(cardName: "Shadowbeast Sighting", cardType: .sorcery, hasFlashback: true))
        
        // 1 Klothys's Design
        deck.append(Card(cardName: "Klothys's Design", cardType: .sorcery))
        
        // 1 Call of the Herd
        deck.append(Card(cardName: "Call of the Herd", cardType: .sorcery, hasFlashback: true))
        
        // 1 Crush of Wurms
        deck.append(Card(cardName: "Crush of Wurms", cardType: .sorcery, hasFlashback: true))
        
        // 1 Beast Attack
        deck.append(Card(cardName: "Beast Attack", cardType: .sorcery, hasFlashback: true))
        
        // 2 Elephant Ambush
        deck.append(Card(cardName: "Elephant Ambush", cardType: .sorcery, hasFlashback: true))
        deck.append(Card(cardName: "Elephant Ambush", cardType: .sorcery, hasFlashback: true))
        
        // 1 Roar of the Wurm
        deck.append(Card(cardName: "Roar of the Wurm", cardType: .sorcery, hasFlashback: true))
        
        // 1 Parallel Evolution
        deck.append(Card(cardName: "Parallel Evolution", cardType: .sorcery, hasFlashback: true))
        
        // 1 Second Harvest
        deck.append(Card(cardName: "Second Harvest", cardType: .instant))
        
        // 1 Predatory Rampage
        deck.append(Card(cardName: "Predatory Rampage", cardType: .sorcery))
        
        // 1 Unnatural Growth
        deck.append(Card(cardName: "Unnatural Growth", cardType: .enchantment))
        
        // 1 Sandwurm Convergence
        deck.append(Card(cardName: "Sandwurm Convergence", cardType: .enchantment, cardImageURL: DeckManager.getScryfallImageUrl(name: "Sandwurm Convergence", specifiSet: "AKH")))
        
        // 2 Muraganda Petroglyphs
        for _ in 1...2 {
            deck.append(Card(cardName: "Muraganda Petroglyphs", cardType: .enchantment))
        }
        
        // 3 Gaea's Anthem
        for _ in 1...3 {
            deck.append(Card(cardName: "Gaea's Anthem", cardType: .enchantment))
        }
        
        // 20 Bear 2/2
        for _ in 1...(20 * difficulty) {
            deck.append(Card(cardName: "Bear", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Bear", specifiSet: "TELD")))
        }
        
        // 6 Elephant 3/3
        for _ in 1...(12 * difficulty) {
            deck.append(Card(cardName: "Elephant", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elephant", specifiSet: "T2XM")))
        }
        
        // 10 Beast 4/4
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Beast", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Beast", specifiSet: "TMH2")))
        }
        
        // 5 Wurm 6/6
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Wurm TC19", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Wurm", specifiSet: "TC19")))
        }
        
        // 16 Elemental x/x
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Elemental T2XM", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "T2XM")))
        }
         
        // 3 Elemental 7/7
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Elemental TKHC", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "TKHC")))
        }

        let tokens: [Card] = [
            Card(cardName: "Saproling (TC20)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Saproling", specifiSet: "TC20")),
            Card(cardName: "Insect", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Insect", specifiSet: "TC20")),
            Card(cardName: "Bear", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Bear", specifiSet: "TELD")),
            Card(cardName: "Elephant", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elephant", specifiSet: "T2XM")),
            Card(cardName: "Beast", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Beast", specifiSet: "TMH2")),
            Card(cardName: "Wurm TCLB", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Wurm", specifiSet: "TCLB")),
            Card(cardName: "Wurm TC19", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Wurm", specifiSet: "TC19")),
            Card(cardName: "Elemental T2XM", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "TKHC")),
            Card(cardName: "Elemental TKHC", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "T2XM"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getZombieDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* ZOMBIE ORIGINAL
         
         1 Call to the Grave
         2 Bad Moon
         1 Plague Wind
         1 Damnation
         1 Yixlid Jailer
         1 Forsaken Wastes
         2 Nested Ghoul
         2 Infectious Horror
         2 Delirium Skeins
         1 Blind Creeper
         2 Soulless One
         2 Vengeful Dead
         1 Fleshbag Marauder
         1 Carrion Wurm
         3 Maggot Carrier
         4 Cackling Fiend
         1 Death Baron
         1 Grave Titan
         2 Severed Legion
         1 Skulking Knight
         1 Undead Warchief
         1 Twilights Call
         1 Army of the Damned
         1 Endless Ranks of the Dead
         2 Rotting Fensnake
         1 Unbreathing Horde
         1 Walking Corpse
         5 Zombie Giant Tokens
         55 Zombie Tokens
         */
        
        // 1 Call to the Grave
        deck.append(Card(cardName: "Call to the Grave", cardType: .enchantment))
        
        // 2 Bad Moon
        for _ in 1...2 {
            deck.append(Card(cardName: "Bad Moon", cardType: .enchantment))
        }
        
        // 1 Plague Wind
        deck.append(Card(cardName: "Plague Wind", cardType: .sorcery))
        
        // 1 Damnation
        deck.append(Card(cardName: "Damnation", cardType: .sorcery))
        
        // 1 Yixlid Jailer
        deck.append(Card(cardName: "Yixlid Jailer", cardType: .creature))
        
        // 1 Forsaken Wastes
        deck.append(Card(cardName: "Forsaken Wastes", cardType: .enchantment))
        
        // 2 Nested Ghoul
        for _ in 1...2 {
            deck.append(Card(cardName: "Nested Ghoul", cardType: .creature))
        }
        
        // 2 Infectious Horror
        for _ in 1...2 {
            deck.append(Card(cardName: "Infectious Horror", cardType: .creature))
        }
        
        // 2 Delirium Skeins
        for _ in 1...2 {
            deck.append(Card(cardName: "Delirium Skeins", cardType: .sorcery))
        }
        
        // 1 Blind Creeper
        deck.append(Card(cardName: "Blind Creeper", cardType: .creature))
        
        // 2 Soulless One
        for _ in 1...2 {
            deck.append(Card(cardName: "Soulless One", cardType: .creature))
        }
        
        // 2 Vengeful Dead
        for _ in 1...2 {
            deck.append(Card(cardName: "Vengeful Dead", cardType: .creature))
        }
        
        // 1 Fleshbag Marauder
        deck.append(Card(cardName: "Fleshbag Marauder", cardType: .creature))
        
        // 1 Carrion Wurm
        deck.append(Card(cardName: "Carrion Wurm", cardType: .creature))
        
        // 3 Maggot Carrier
        for _ in 1...3 {
            deck.append(Card(cardName: "Maggot Carrier", cardType: .creature))
        }
        
        // 4 Cackling Fiend
        for _ in 1...4 {
            deck.append(Card(cardName: "Cackling Fiend", cardType: .creature))
        }
        
        // 1 Death Baron
        deck.append(Card(cardName: "Death Baron", cardType: .creature))
        
        // 1 Grave Titan
        deck.append(Card(cardName: "Grave Titan", cardType: .creature))
        
        // 2 Severed Legion
        for _ in 1...2 {
            deck.append(Card(cardName: "Severed Legion", cardType: .creature))
        }
        
        // 1 Skulking Knight
        deck.append(Card(cardName: "Skulking Knight", cardType: .creature))
        
        // 1 Undead Warchief
        deck.append(Card(cardName: "Undead Warchief", cardType: .creature))
        
        // 1 Twilights Call
        deck.append(Card(cardName: "Twilights Call", cardType: .sorcery))
        
        // 1 Army of the Damned
        deck.append(Card(cardName: "Army of the Damned", cardType: .sorcery, cardImageURL: DeckManager.getScryfallImageUrl(name: "Army of the Damned", specifiSet: "ISD"), hasFlashback: true))
        
        // 1 Endless Ranks of the Dead
        deck.append(Card(cardName: "Endless Ranks of the Dead", cardType: .enchantment))
        
        // 2 Rotting Fensnake
        for _ in 1...2 {
            deck.append(Card(cardName: "Rotting Fensnake", cardType: .creature))
        }
        
        // 1 Unbreathing Horde
        deck.append(Card(cardName: "Unbreathing Horde", cardType: .creature))
        
        // 1 Walking Corpse
        deck.append(Card(cardName: "Walking Corpse", cardType: .creature))
        
        // 5 Zombie Giant Tokens
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Zombie Giant Token", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Zombie Giant", specifiSet: "TBBD")))
        }
        
        // 55 Zombie Tokens
        for _ in 1...(55 * difficulty) {
            deck.append(Card(cardName: "Zombie Token", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Zombie", specifiSet: "TISD")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Zombie Token", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Zombie", specifiSet: "TISD")),
            Card(cardName: "Zombie Giant Token", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Zombie Giant", specifiSet: "TBBD"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getSliverDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* SLIVER HIVE
         
         1 Battering Sliver
         1 Brood Sliver
         2 Cleansing Meditation
         1 Cleaving Sliver
         1 Diffusion Sliver
         1 Essence Sliver
         1 Frenzy Sliver
         1 Fungus Sliver -> Changed to Fury Sliver
         1 Fury Sliver
         1 Hive Stirrings -> Changed to Might Sliver
         1 Lancer Sliver
         1 Lavabelly Sliver
         1 Leeching Sliver
         1 Lymph Sliver
         1 Megantic Sliver
         1 Might Sliver
         4 Plague Wind -> Changed to Harsh Mercy
         1 Root Sliver -> Changed to Sinew Sliver
         1 Ruinous Ultimatum
         1 Shifting Sliver
         1 Sidewinder Sliver
         1 Sinew Sliver
         1 Sliver Legion -> leave this one here not as a boss ? -> Changed to Megantic Sliver
         1 Spined Sliver
         1 Spitting Sliver
         1 Synchronous Sliver -> Changed to Lavabelly Sliver
         1 Tempered Sliver -> Changed to Might Sliver
         1 Toxin Sliver
         1 Two-Headed Sliver
         1 Vampiric Sliver -> Changed to Might Sliver
         2 Vandalblast
         
         10 Venser's Sliver
         22 Sliver Construct
         32 Metallic Sliver
         */
        
        
        // 1 Battering Sliver
        deck.append(Card(cardName: "Battering Sliver",cardType: .creature))
        
        // 1 Brood Sliver
        deck.append(Card(cardName: "Brood Sliver",cardType: .creature))
        
        // 2 Cleansing Meditation
        for _ in 1...2 {
            deck.append(Card(cardName: "Cleansing Meditation",cardType: .sorcery))
        }
        
        // 1 Cleaving Sliver
        deck.append(Card(cardName: "Cleaving Sliver",cardType: .creature))
        
        // 1 Diffusion Sliver
        deck.append(Card(cardName: "Diffusion Sliver",cardType: .creature))
        
        // 1 Essence Sliver
        deck.append(Card(cardName: "Essence Sliver",cardType: .creature))
        
        // 1 Frenzy Sliver
        deck.append(Card(cardName: "Frenzy Sliver",cardType: .creature))
        
        // 1 Fungus Sliver
        deck.append(Card(cardName: "Fury Sliver",cardType: .creature))
        
        // 1 Fury Sliver
        deck.append(Card(cardName: "Fury Sliver",cardType: .creature))
        
        // 1 Hive Stirrings
        deck.append(Card(cardName: "Might Sliver",cardType: .creature))
        
        // 1 Lancer Sliver
        deck.append(Card(cardName: "Lancer Sliver",cardType: .creature))
        
        // 1 Lavabelly Sliver
        deck.append(Card(cardName: "Lavabelly Sliver",cardType: .creature))
        
        // 1 Leeching Sliver
        deck.append(Card(cardName: "Leeching Sliver",cardType: .creature))
        
        // 1 Lymph Sliver
        deck.append(Card(cardName: "Lymph Sliver",cardType: .creature))
        
        // 1 Megantic Sliver
        deck.append(Card(cardName: "Megantic Sliver",cardType: .creature))
        
        // 1 Might Sliver
        deck.append(Card(cardName: "Might Sliver",cardType: .creature))
        
        // 4 Harsh Mercy
        for _ in 1...4 {
            deck.append(Card(cardName: "Harsh Mercy",cardType: .sorcery))
        }
        
        // 1 Root Sliver
        deck.append(Card(cardName: "Sinew Sliver",cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum",cardType: .sorcery))
        
        // 1 Shifting Sliver
        deck.append(Card(cardName: "Shifting Sliver",cardType: .creature))
        
        // 1 Sidewinder Sliver
        deck.append(Card(cardName: "Sidewinder Sliver",cardType: .creature))
        
        // 1 Sinew Sliver
        deck.append(Card(cardName: "Sinew Sliver",cardType: .creature))
        
        // 1 Sliver Legion
        deck.append(Card(cardName: "Megantic Sliver",cardType: .creature))
        
        // 1 Spined Sliver
        deck.append(Card(cardName: "Spined Sliver",cardType: .creature))
        
        // 1 Spitting Sliver
        deck.append(Card(cardName: "Spitting Sliver",cardType: .creature))
        
        // 1 Synchronous Sliver
        deck.append(Card(cardName: "Lavabelly Sliver",cardType: .creature))
        
        // 1 Tempered Sliver
        deck.append(Card(cardName: "Might Sliver",cardType: .creature))
        
        // 1 Toxin Sliver
        deck.append(Card(cardName: "Toxin Sliver",cardType: .creature))
        
        // 1 Two-Headed Sliver
        deck.append(Card(cardName: "Two-Headed Sliver",cardType: .creature))
        
        // 1 Vampiric Sliver
        deck.append(Card(cardName: "Might Sliver",cardType: .creature))
        
        // 2 Vandalblast
        for _ in 1...2 {
            deck.append(Card(cardName: "Vandalblast",cardType: .sorcery))
        }
        
        // 10 Venser's Sliver
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Venser's Sliver",cardType: .token))
        }
        
        // 22 Sliver Construct
        for _ in 1...(22 * difficulty) {
            deck.append(Card(cardName: "Sliver Construct",cardType: .token))
        }
        
        // 32 Metallic Sliver
        for _ in 1...(32 * difficulty) {
            deck.append(Card(cardName: "Metallic Sliver",cardType: .token))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Metallic Sliver",cardType: .token),
            Card(cardName: "Sliver Construct",cardType: .token),
            Card(cardName: "Venser's Sliver",cardType: .token)
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getEldraziDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* ELDRAZI HORRORS
         
         1 All Is Dust
         1 Awakening Zone
         1 Bane of Bala Ged
         1 Benthic Infiltrator
         1 Blisterpod
         1 Breaker of Armies
         1 Brood Monitor
         1 Chittering Host
         1 Culling Drone
         1 Dominator Drone
         1 Dread Drone
         1 Eldrazi Aggressor
         1 Eldrazi Devastator
         1 Emrakul's Hatcher
         1 Essence Feed
         1 Eyeless Watcher
         1 Flayer Drone
         1 Hand of Emrakul
         1 Hanweir, the Writhing Township
         1 Incubator Drone
         1 It That Betrays
         1 Kozilek's Predator
         1 Kozilek's Sentinel
         1 Nest Invader
         1 Pathrazer of Ulamog
         1 Pawn of Ulamog
         1 Rapacious One
         1 Reality Smasher
         1 Ruination Guide
         1 Scion Summoner
         1 Sifter of Skulls
         1 Skittering Invasion
         1 Swarm Surge
         1 Tide Drifter
         1 Ulamog's Crusher
         1 Vestige of Emrakul
         1 Vile Aggregate
         1 Void Grafter -> CHANGED TO Desolation Twin
         1 Void Winnower
         1 Witness the End
         
         15 Eldrazi Horror (TEMN) 1
         25 Eldrazi Scion (DDR) 71
         5 Eldrazi (TPCA) 1
         15 Eldrazi Spawn (DDP) 76

         Sideboard:
         1 Emrakul, the Aeons Torn
         1 Kozilek, Butcher of Truth
         1 Ulamog, the Ceaseless Hunger
         */
        
        // 1 All Is Dust
        deck.append(Card(cardName: "All Is Dust", cardType: .sorcery))
        
        // 1 Awakening Zone
        deck.append(Card(cardName: "Awakening Zone", cardType: .enchantment))
        
        // 1 Bane of Bala Ged
        deck.append(Card(cardName: "Bane of Bala Ged", cardType: .creature))
        
        // 1 Benthic Infiltrator
        deck.append(Card(cardName: "Benthic Infiltrator", cardType: .creature))
        
        // 1 Blisterpod
        deck.append(Card(cardName: "Blisterpod", cardType: .creature))
        
        // 1 Breaker of Armies
        deck.append(Card(cardName: "Breaker of Armies", cardType: .creature))
        
        // 1 Brood Monitor
        deck.append(Card(cardName: "Brood Monitor", cardType: .creature))
        
        // 1 Chittering Host
        deck.append(Card(cardName: "Chittering Host", cardType: .creature))
        
        // 1 Culling Drone
        deck.append(Card(cardName: "Culling Drone", cardType: .creature))
        
        // 1 Dominator Drone
        deck.append(Card(cardName: "Dominator Drone", cardType: .creature))
        
        // 1 Dread Drone
        deck.append(Card(cardName: "Dread Drone", cardType: .creature))
        
        // 1 Eldrazi Aggressor
        deck.append(Card(cardName: "Eldrazi Aggressor", cardType: .creature))
        
        // 1 Eldrazi Devastator
        deck.append(Card(cardName: "Eldrazi Devastator", cardType: .creature))
        
        // 1 Emrakul's Hatcher
        deck.append(Card(cardName: "Emrakul's Hatcher", cardType: .creature))
        
        // 1 Essence Feed
        deck.append(Card(cardName: "Essence Feed", cardType: .sorcery))
        
        // 1 Eyeless Watcher
        deck.append(Card(cardName: "Eyeless Watcher", cardType: .creature))
        
        // 1 Flayer Drone
        deck.append(Card(cardName: "Flayer Drone", cardType: .creature))
        
        // 1 Hand of Emrakul
        deck.append(Card(cardName: "Hand of Emrakul", cardType: .creature))
        
        // 1 Hanweir, the Writhing Township
        deck.append(Card(cardName: "Hanweir, the Writhing Township", cardType: .creature))
        
        // 1 Incubator Drone
        deck.append(Card(cardName: "Incubator Drone", cardType: .creature))
        
        // 1 It That Betrays
        deck.append(Card(cardName: "It That Betrays", cardType: .creature))
        
        // 1 Kozilek's Predator
        deck.append(Card(cardName: "Kozilek's Predator", cardType: .creature))
        
        // 1 Kozilek's Sentinel
        deck.append(Card(cardName: "Kozilek's Sentinel", cardType: .creature))
        
        // 1 Nest Invader
        deck.append(Card(cardName: "Nest Invader", cardType: .creature))
        
        // 1 Pathrazer of Ulamog
        deck.append(Card(cardName: "Pathrazer of Ulamog", cardType: .creature))
        
        // 1 Pawn of Ulamog
        deck.append(Card(cardName: "Pawn of Ulamog", cardType: .creature))
        
        // 1 Rapacious One
        deck.append(Card(cardName: "Rapacious One", cardType: .creature))
        
        // 1 Reality Smasher
        deck.append(Card(cardName: "Reality Smasher", cardType: .creature))
        
        // 1 Ruination Guide
        deck.append(Card(cardName: "Ruination Guide", cardType: .creature))
        
        // 1 Scion Summoner
        deck.append(Card(cardName: "Scion Summoner", cardType: .creature))
        
        // 1 Sifter of Skulls
        deck.append(Card(cardName: "Sifter of Skulls", cardType: .creature))
        
        // 1 Skittering Invasion
        deck.append(Card(cardName: "Skittering Invasion", cardType: .sorcery))
        
        // 1 Swarm Surge
        deck.append(Card(cardName: "Swarm Surge", cardType: .sorcery))
        
        // 1 Tide Drifter
        deck.append(Card(cardName: "Tide Drifter", cardType: .creature))
        
        // 1 Ulamog's Crusher
        deck.append(Card(cardName: "Ulamog's Crusher", cardType: .creature))
        
        // 1 Vestige of Emrakul
        deck.append(Card(cardName: "Vestige of Emrakul", cardType: .creature))
        
        // 1 Vile Aggregate
        deck.append(Card(cardName: "Vile Aggregate", cardType: .creature))
        
        // 1 Desolation Twin
        deck.append(Card(cardName: "Desolation Twin", cardType: .creature))
        
        // 1 Void Winnower
        deck.append(Card(cardName: "Void Winnower", cardType: .creature))
        
        // 1 Witness the End
        deck.append(Card(cardName: "Witness the End", cardType: .sorcery))
        
        
        // 15 Eldrazi Horror (TEMN) 1
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")))
        }
        
        // 25 Eldrazi Scion (DDR) 71
        for _ in 1...(25 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")))
        }
        
        // 5 Eldrazi (TPCA) 1
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")))
        }
        
        // 15 Eldrazi Spawn (DDP) 76
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")),
            Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")),
            Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")),
            Card(cardName: "Eldrazi (TBFZ)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TBFZ")),
            Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")),
            Card(cardName: "Emrakul, the Aeons Torn", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Emrakul, the Aeons Torn", specifiSet: "ROE")),
            Card(cardName: "Kozilek, Butcher of Truth", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Kozilek, Butcher of Truth", specifiSet: "ROE")),
            Card(cardName: "Ulamog, the Infinite Gyre", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Ulamog, the Infinite Gyre", specifiSet: "ROE"))
        ]

        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getHumanDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* HUMAN ARMY
         
        MAYBE ?
        1 Balefire Liege
        1 Crescendo of War
        1 Glory of Warfare
        1 Nobilis of War
         
        1 Adeline, Resplendent Cathar
        1 Adriana, Captain of the Guard
        1 Archetype of Courage
        1 Benalish Marshal
        1 Blade Historian
        1 Captain of the Watch
        1 Cathars' Crusade -> CHANGED TO Collective Blessing
        1 Cazur, Ruthless Stalker -> CHANGED TO Deploy to the Front
        2 Cleansing Meditation
        1 Darien, King of Kjeldor
        1 Frontier Warmonger
        1 Frontline Medic
        1 Goldnight Commander
        1 Hamlet Captain
        1 Hanweir Garrison
        1 Hero of Bladehold
        1 Hero of Oxid Ridge
        1 Increasing Devotion
        1 Inspiring Veteran -> Changed to Balefire Liege
        1 Knight Exemplar -> Changed to Nobilis of War
        1 Kyler, Sigardian Emissary
        4 Plague Wind
        1 Radiant Destiny -> CHANGED TO Glorious Anthem
        1 Rally the Ranks -> CHANGED TO Glorious Anthem
        1 Reverent Hoplite
        1 Ruinous Ultimatum
        1 Shared Animosity -> Too strong ? changed to Dictate of Heliod
        1 Spare from Evil -> Too strong -> Changed to one more Captain of the Watch
        1 Stalwart Pathlighter
        1 Syr Alin, the Lion's Claw
        1 True Conviction
        2 Vandalblast
        1 Victory's Envoy -> CHANGED TO Blazing Archon
        1 Visions of Glory
        1 Worthy Knight -> Changed to Angel of Glory's Rise
         
        10 Soldier (TGRN) 2
        10 Knight (TMIC) 3
        10 Human Warrior (TELD) 13
        10 Knight (TCM2) 4
        20 Human (TRNA) 1
        */
        
        // 1 Adeline, Resplendent Cathar
        deck.append(Card(cardName: "Adeline, Resplendent Cathar", cardType: .creature))
        
        // 1 Adriana, Captain of the Guard
        deck.append(Card(cardName: "Adriana, Captain of the Guard", cardType: .creature))
        
        // 1 Archetype of Courage
        deck.append(Card(cardName: "Archetype of Courage", cardType: .creature))
        
        // 1 Benalish Marshal
        deck.append(Card(cardName: "Benalish Marshal", cardType: .creature))
        
        // 1 Blade Historian
        deck.append(Card(cardName: "Blade Historian", cardType: .creature))
        
        // 1 Captain of the Watch
        deck.append(Card(cardName: "Captain of the Watch", cardType: .creature))
        deck.append(Card(cardName: "Captain of the Watch", cardType: .creature))
        
        // 1 Collective Blessing
        deck.append(Card(cardName: "Collective Blessing", cardType: .enchantment))
        
        // 1 Deploy to the Front
        deck.append(Card(cardName: "Deploy to the Front", cardType: .sorcery))
        
        // 2 Cleansing Meditation
        for _ in 1...2 {
            deck.append(Card(cardName: "Cleansing Meditation", cardType: .sorcery))
        }
        
        // 1 Darien, King of Kjeldor
        deck.append(Card(cardName: "Darien, King of Kjeldor", cardType: .creature))
        
        // 1 Frontier Warmonger
        deck.append(Card(cardName: "Frontier Warmonger", cardType: .creature))
        
        // 1 Frontline Medic
        deck.append(Card(cardName: "Frontline Medic", cardType: .creature))
        
        // 1 Goldnight Commander
        deck.append(Card(cardName: "Goldnight Commander", cardType: .creature))
        
        // 1 Hamlet Captain
        deck.append(Card(cardName: "Hamlet Captain", cardType: .creature))
        
        // 1 Hanweir Garrison
        deck.append(Card(cardName: "Hanweir Garrison", cardType: .creature))
        
        // 1 Hero of Bladehold
        deck.append(Card(cardName: "Hero of Bladehold", cardType: .creature))
        
        // 1 Hero of Oxid Ridge
        deck.append(Card(cardName: "Hero of Oxid Ridge", cardType: .creature))
        
        // 1 Increasing Devotion
        deck.append(Card(cardName: "Increasing Devotion", cardType: .sorcery, hasFlashback: true))
        
        // 1 Inspiring Veteran
        deck.append(Card(cardName: "Balefire Liege", cardType: .creature))
        
        // 1 Knight Exemplar
        deck.append(Card(cardName: "Nobilis of War", cardType: .creature))
        
        // 1 Kyler, Sigardian Emissary
        deck.append(Card(cardName: "Kyler, Sigardian Emissary", cardType: .creature))
        
        // 2 Hour of Reckoning
        for _ in 1...2 {
            deck.append(Card(cardName: "Hour of Reckoning", cardType: .sorcery))
        }
        
        // 2 Wrath of God
        for _ in 1...2 {
            deck.append(Card(cardName: "Wrath of God", cardType: .sorcery))
        }
        
        // 1 Glorious Anthem
        deck.append(Card(cardName: "Glorious Anthem", cardType: .enchantment))
        
        // 1 Glorious Anthem
        deck.append(Card(cardName: "Glorious Anthem", cardType: .enchantment))
        
        // 1 Reverent Hoplite
        deck.append(Card(cardName: "Reverent Hoplite", cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum", cardType: .sorcery))
        
        // 1 Shared Animosity
        deck.append(Card(cardName: "Dictate of Heliod", cardType: .enchantment))
        
        // 1 Spare from Evil
        //deck.append(Card(cardName: "Spare from Evil", cardType: .instant))
        
        // 1 Stalwart Pathlighter
        deck.append(Card(cardName: "Stalwart Pathlighter", cardType: .creature))
        
        // 1 Syr Alin, the Lion's Claw
        deck.append(Card(cardName: "Syr Alin, the Lion's Claw", cardType: .creature))
        
        // 1 True Conviction
        deck.append(Card(cardName: "True Conviction", cardType: .enchantment))
        
        // 2 Vandalblast
        for _ in 1...2 {
            deck.append(Card(cardName: "Vandalblast", cardType: .sorcery))
        }
        
        // 1 Blazing Archon
        deck.append(Card(cardName: "Blazing Archon", cardType: .creature))
        
        // 1 Visions of Glory
        deck.append(Card(cardName: "Visions of Glory", cardType: .sorcery, hasFlashback: true))
        
        // 1 Worthy Knight
        deck.append(Card(cardName: "Angel of Glory's Rise", cardType: .creature))
        
        
        // 10 Soldier (TGRN) 1/1 Lifelink -> Replace to classic 1/1
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Soldier (TCLB)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Soldier", specifiSet: "TCLB")))
        }
        
        // 10 Knight (TMIC) 2/2 Vigilance -> Replace to solider 2/2
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Soldier (TWAR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Soldier", specifiSet: "TWAR")))
        }
        
        // 10 Human Warrior (TELD) 13
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Human Warrior (TELD)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Human Warrior", specifiSet: "TELD")))
        }
        
        // 10 Knight (TCM2) 2/2 First Striker
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Knight (TCM2)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Knight", specifiSet: "TCM2")))
        }
        
        // 20 Human (TRNA) 1
        for _ in 1...(20 * difficulty) {
            deck.append(Card(cardName: "Human (TRNA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Human", specifiSet: "TC20")))
        }
        
        
        let tokens: [Card] = [
            Card(cardName: "Human (TRNA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Human", specifiSet: "TC20")),
            Card(cardName: "Soldier (TCLB)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Soldier", specifiSet: "TCLB")),
            Card(cardName: "Soldier (TWAR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Soldier", specifiSet: "TWAR")),
            Card(cardName: "Knight (TCM2)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Knight", specifiSet: "TCM2")),
            Card(cardName: "Human Warrior (TELD)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Human Warrior", specifiSet: "TELD"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getPhyrexianDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* PHYREXIAN PERFECTION
         
         MAYBE ?
         1 Decimator of the Provinces
         
         // Removed because mostly because of +1/+1 counters
         1 Arcbound Crusher -> CHANGED TO Master Splicer
         1 Arcbound Overseer -> CHANGED TO Wing Splicer
         1 Arcbound Shikari -> CHANGED TO Ichor Rats
         1 Arcbound Slith -> CHANGED TO Phyrexian Juggernaut
         1 Arcbound Tracker -> CHANGED TO Toxic Nim
         1 Ich-Tekik, Salvage Splicer -> CHANGED TO Urabrask the Hidden
         
         1 Spread the Sickness -> CHANGED TO Skithiryx, the Blight Dragon
         1 Wake the Past -> CHANGED TO Putrefax
         
         1 Blade Splicer
         1 Blightsteel Colossus
         1 Bronze Guardian
         1 Carrion Call
         2 Cleansing Meditation
         1 Core Prowler
         1 Elesh Norn, Grand Cenobite
         1 Hand of the Praetors
         1 Inexorable Tide
         1 Massacre Wurm
         1 Maul Splicer
         1 Nest of Scarabs
         1 Phyrexian Crusader
         1 Phyrexian Hydra
         1 Phyrexian Obliterator
         1 Phyrexian Rebirth
         1 Phyrexian Swarmlord
         3 Plague Wind -> Changed to Fumigate
         1 Priests of Norn
         1 Reaper of Sheoldred
         1 Ruinous Ultimatum
         1 Scuttling Doom Engine
         1 Sensor Splicer
         1 Spinebiter
         1 Triumph of the Hordes
         2 Vandalblast
         1 Vedalken Humiliator
         1 Vorinclex, Monstrous Raider
         1 Wurmcoil Engine
         
         20 Golem (TNPH) 3
         5 Assembly-Worker (TTSR) 14
         5 Construct (TMH2) 16
         5 Construct (TC18) 21
         5 Golem (TC21) 27 -> moved to Golem TPNH
         4 Construct (TZNR) 10
         3 Beast (TKLD) 1
         3 Golem (TRIX) 4
         3 Golem (TMBS) 3
         3 Wurm (TSOM) 8
         3 Wurm (TSOM) 9
         */
        
        // 1 Master Splicer
        deck.append(Card(cardName: "Master Splicer",cardType: .creature))
        
        // 1 Wing Splicer
        deck.append(Card(cardName: "Wing Splicer",cardType: .creature))
        
        // 1 Ichor Rats
        deck.append(Card(cardName: "Ichor Rats",cardType: .creature))
        
        // 1 Phyrexian Juggernaut
        deck.append(Card(cardName: "Phyrexian Juggernaut",cardType: .creature))
        
        // 1 Toxic Nim
        deck.append(Card(cardName: "Toxic Nim",cardType: .creature))
        
        // 1 Blade Splicer
        deck.append(Card(cardName: "Blade Splicer",cardType: .creature))
        
        // 1 Blightsteel Colossus
        deck.append(Card(cardName: "Blightsteel Colossus",cardType: .creature))
        
        // 1 Bronze Guardian
        deck.append(Card(cardName: "Bronze Guardian",cardType: .creature))
        
        // 1 Carrion Call
        deck.append(Card(cardName: "Carrion Call",cardType: .instant))
        
        // 2 Cleansing Meditation
        for _ in 1...2 {
            deck.append(Card(cardName: "Cleansing Meditation",cardType: .sorcery))
        }
        
        // 1 Core Prowler
        deck.append(Card(cardName: "Core Prowler",cardType: .creature))
        
        // 1 Elesh Norn, Grand Cenobite
        deck.append(Card(cardName: "Elesh Norn, Grand Cenobite",cardType: .creature))
        
        // 1 Hand of the Praetors
        deck.append(Card(cardName: "Hand of the Praetors",cardType: .creature))
        
        // 1 Urabrask the Hidden
        deck.append(Card(cardName: "Urabrask the Hidden",cardType: .creature))
        
        // 1 Inexorable Tide
        deck.append(Card(cardName: "Inexorable Tide",cardType: .enchantment))
        
        // 1 Massacre Wurm
        deck.append(Card(cardName: "Massacre Wurm",cardType: .creature))
        
        // 1 Maul Splicer
        deck.append(Card(cardName: "Maul Splicer",cardType: .creature))
        
        // 1 Nest of Scarabs
        deck.append(Card(cardName: "Nest of Scarabs",cardType: .enchantment))
        
        // 1 Phyrexian Crusader
        deck.append(Card(cardName: "Phyrexian Crusader",cardType: .creature))
        
        // 1 Phyrexian Hydra
        deck.append(Card(cardName: "Phyrexian Hydra",cardType: .creature))
        
        // 1 Phyrexian Obliterator
        deck.append(Card(cardName: "Phyrexian Obliterator",cardType: .creature))
        
        // 1 Phyrexian Rebirth
        deck.append(Card(cardName: "Phyrexian Rebirth",cardType: .sorcery))
        
        // 1 Phyrexian Swarmlord
        deck.append(Card(cardName: "Phyrexian Swarmlord",cardType: .creature))
        
        // 3 Fumigate
        for _ in 1...3 {
            deck.append(Card(cardName: "Fumigate",cardType: .sorcery))
        }
        
        // 1 Priests of Norn
        deck.append(Card(cardName: "Priests of Norn",cardType: .creature))
        
        // 1 Reaper of Sheoldred
        deck.append(Card(cardName: "Reaper of Sheoldred",cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum",cardType: .sorcery))
        
        // 1 Scuttling Doom Engine
        deck.append(Card(cardName: "Scuttling Doom Engine",cardType: .creature))
        
        // 1 Sensor Splicer
        deck.append(Card(cardName: "Sensor Splicer",cardType: .creature))
        
        // 1 Spinebiter
        deck.append(Card(cardName: "Spinebiter",cardType: .creature))
        
        // 1 Skithiryx, the Blight Dragon
        deck.append(Card(cardName: "Skithiryx, the Blight Dragon",cardType: .creature))
        
        // 1 Triumph of the Hordes
        deck.append(Card(cardName: "Triumph of the Hordes",cardType: .sorcery))
        
        // 2 Vandalblast
        for _ in 1...2 {
            deck.append(Card(cardName: "Vandalblast",cardType: .sorcery))
        }
        
        // 1 Vedalken Humiliator
        deck.append(Card(cardName: "Vedalken Humiliator",cardType: .creature))
        
        // 1 Vorinclex, Monstrous Raider
        deck.append(Card(cardName: "Vorinclex, Monstrous Raider",cardType: .creature))
        
        // 1 Putrefax
        deck.append(Card(cardName: "Putrefax",cardType: .creature))
        
        // 1 Wurmcoil Engine
        deck.append(Card(cardName: "Wurmcoil Engine",cardType: .creature))
        
        // 25 Golem (TNPH) 3
        for _ in 1...25 {
            deck.append(Card(cardName: "Golem TNPH", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TCMR")))
        }
        
        // 5+4 Assembly-Worker (TTSR) 14
        for _ in 1...(9 * difficulty) {
            deck.append(Card(cardName: "Assembly-Worker TTSR", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Assembly-Worker", specifiSet: "TTSR")))
        }
        
        // 5 Construct (TMH2) X/X
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Construct TMH2", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TMH2")))
        }
        
        // 5 Construct (TC18) 4/4 -> Changed to Golem 4/4
        /*for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Construct (TC18)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TC18")))
        }*/
        
        // 4 Construct (TZNR) 1/1 -> Changed to Assembly-Worker 2/2
        /*for _ in 1...(4 * difficulty) {
            deck.append(Card(cardName: "Construct (TZNR)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TZNR")))
        }*/
        
        // 3 Beast (TKLD) 1
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Beast (TKLD)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Beast", specifiSet: "TKLD")))
        }
        
        // 3+5 Golem (TRIX) 4/4
        for _ in 1...(8 * difficulty) {
            deck.append(Card(cardName: "Golem (TRIX)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TRIX")))
        }
        
        // 3 Golem (TMBS) 9/9
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Golem (TMBS)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TMBS")))
        }
        
        // 3 Wurm (TSOM) 8
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "WURM (TSOM) 8", cardType: .token, cardImageURL: "https://c1.scryfall.com/file/scryfall-cards/large/front/b/6/b68e816f-f9ac-435b-ad0b-ceedbe72447a.jpg?1598312203"))
        }
        
        // 3 Wurm (TSOM) 9
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "WURM (TSOM) 9", cardType: .token, cardImageURL: "https://c1.scryfall.com/file/scryfall-cards/large/front/a/6/a6ee0db9-ac89-4ab6-ac2e-8a7527d9ecbd.jpg?1598312477"))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Insect TAKH", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Insect", specifiSet: "TAKH")),
            Card(cardName: "Insect TSOM", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Insect", specifiSet: "TSOM")),
            Card(cardName: "Assembly-Worker TTSR", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Assembly-Worker", specifiSet: "TTSR")),
            Card(cardName: "Golem TNPH", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TCMR")),
            Card(cardName: "WURM (TSOM) 8", cardType: .token, cardImageURL: "https://c1.scryfall.com/file/scryfall-cards/large/front/b/6/b68e816f-f9ac-435b-ad0b-ceedbe72447a.jpg?1598312203"),
            Card(cardName: "WURM (TSOM) 9", cardType: .token, cardImageURL: "https://c1.scryfall.com/file/scryfall-cards/large/front/a/6/a6ee0db9-ac89-4ab6-ac2e-8a7527d9ecbd.jpg?1598312477"),
            Card(cardName: "Golem (TRIX)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TRIX")),
            Card(cardName: "Golem (TMBS)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TMBS"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getDinosaurDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* DINAUSOR RAGE
         
         1 Bellowing Aegisaur -> CHANGED TO Collective Blessing
         1 Burning Sun's Avatar
         1 Carnage Tyrant
         1 Charging Tuskodon
         2 Cleansing Meditation
         1 Dinosaur Stampede
         1 Frilled Deathspitter
         1 Ghalta, Primal Hunger
         1 Gigantosaurus
         1 Goring Ceratops
         1 Imposing Vantasaur
         1 Marauding Raptor
         1 Momentum Rumbler -> CHANGED TO Kinjalli's Sunwing
         1 Needletooth Raptor
         1 Ornery Dilophosaur
         1 Overgrown Armasaur
         3 Plague Wind -> changed to Star of Extinction
         1 Polyraptor
         1 Quartzwood Crasher -> CHANGED TO Verdant Sun's Avatar
         1 Raging Swordtooth
         1 Rampaging Ferocidon
         1 Raptor Hatchling
         1 Regisaur Alpha
         1 Ridgetop Raptor
         1 Ripscale Predator
         1 Ruinous Ultimatum
         1 Siegehorn Ceratops
         1 Silverclad Ferocidons
         1 Snapping Sailback
         1 Sun-Crowned Hunters
         1 Temple Altisaur
         1 The Tarrasque
         1 Thrash of Raptors
         1 Thrasta, Tempest's Roar
         2 Vandalblast
         1 Wakening Sun's Avatar
         */
        
        // 1 Collective Blessing
        deck.append(Card(cardName: "Collective Blessing", cardType: .enchantment))
        
        // 1 Burning Sun's Avatar
        deck.append(Card(cardName: "Burning Sun's Avatar", cardType: .creature))
        
        // 1 Carnage Tyrant
        deck.append(Card(cardName: "Carnage Tyrant", cardType: .creature))
        
        // 1 Charging Tuskodon
        deck.append(Card(cardName: "Charging Tuskodon", cardType: .creature))
        
        // 2 Cleansing Meditation
        for _ in 1...2 {
            deck.append(Card(cardName: "Cleansing Meditation", cardType: .sorcery))
        }
        
        // 1 Dinosaur Stampede
        deck.append(Card(cardName: "Dinosaur Stampede", cardType: .instant))
        
        // 1 Frilled Deathspitter
        deck.append(Card(cardName: "Frilled Deathspitter", cardType: .creature))
        
        // 1 Ghalta, Primal Hunger
        deck.append(Card(cardName: "Ghalta, Primal Hunger", cardType: .creature))
        
        // 1 Gigantosaurus
        deck.append(Card(cardName: "Gigantosaurus", cardType: .creature))
        
        // 1 Goring Ceratops
        deck.append(Card(cardName: "Goring Ceratops", cardType: .creature))
        
        // 1 Imposing Vantasaur
        deck.append(Card(cardName: "Imposing Vantasaur", cardType: .creature))
        
        // 1 Marauding Raptor
        deck.append(Card(cardName: "Marauding Raptor", cardType: .creature))
        
        // 1 Kinjalli's Sunwing
        deck.append(Card(cardName: "Kinjalli's Sunwing", cardType: .creature))
        
        // 1 Needletooth Raptor
        deck.append(Card(cardName: "Needletooth Raptor", cardType: .creature))
        
        // 1 Ornery Dilophosaur
        deck.append(Card(cardName: "Ornery Dilophosaur", cardType: .creature))
        
        // 1 Overgrown Armasaur
        deck.append(Card(cardName: "Overgrown Armasaur", cardType: .creature))
        
        // 3 Star of Extinction
        for _ in 1...3 {
            deck.append(Card(cardName: "Star of Extinction",cardType: .sorcery))
        }
        
        // 1 Polyraptor
        deck.append(Card(cardName: "Polyraptor", cardType: .creature))
        
        // 1 Verdant Sun's Avatar
        deck.append(Card(cardName: "Verdant Sun's Avatar", cardType: .creature))
        
        // 1 Raging Swordtooth
        deck.append(Card(cardName: "Raging Swordtooth", cardType: .creature))
        
        // 1 Rampaging Ferocidon
        deck.append(Card(cardName: "Rampaging Ferocidon", cardType: .creature))
        
        // 1 Raptor Hatchling
        deck.append(Card(cardName: "Raptor Hatchling", cardType: .creature))
        
        // 1 Regisaur Alpha
        deck.append(Card(cardName: "Regisaur Alpha", cardType: .creature))
        
        // 1 Ridgetop Raptor
        deck.append(Card(cardName: "Ridgetop Raptor", cardType: .creature))
        
        // 1 Ripscale Predator
        deck.append(Card(cardName: "Ripscale Predator", cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum", cardType: .sorcery))
        
        // 1 Siegehorn Ceratops
        deck.append(Card(cardName: "Siegehorn Ceratops", cardType: .creature))
        
        // 1 Silverclad Ferocidons
        deck.append(Card(cardName: "Silverclad Ferocidons", cardType: .creature))
        
        // 1 Snapping Sailback
        deck.append(Card(cardName: "Snapping Sailback", cardType: .creature))
        
        // 1 Sun-Crowned Hunters
        deck.append(Card(cardName: "Sun-Crowned Hunters", cardType: .creature))
        
        // 1 Temple Altisaur
        deck.append(Card(cardName: "Temple Altisaur", cardType: .creature))
        
        // 1 The Tarrasque
        deck.append(Card(cardName: "The Tarrasque", cardType: .creature))
        
        // 1 Thrash of Raptors
        deck.append(Card(cardName: "Thrash of Raptors", cardType: .creature))
        
        // 1 Thrasta, Tempest's Roar
        deck.append(Card(cardName: "Thrasta, Tempest's Roar", cardType: .creature))
        
        // 2 Vandalblast
        for _ in 1...2 {
            deck.append(Card(cardName: "Vandalblast", cardType: .sorcery))
        }
        
        // 1 Wakening Sun's Avatar
        deck.append(Card(cardName: "Wakening Sun's Avatar", cardType: .creature))

        // 40 Dinosaur (TIKO)
        for _ in 1...(40 * difficulty) {
            deck.append(Card(cardName: "Dinosaur (TIKO)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Dinosaur", specifiSet: "TIKO")))
        }
        
        // 20 Dinosaur (TGN2)
        for _ in 1...(20 * difficulty) {
            deck.append(Card(cardName: "Dinosaur (TGN2)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Dinosaur", specifiSet: "TGN2")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Saproling (TC20)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Saproling", specifiSet: "TC20")),
            Card(cardName: "Dinosaur (TIKO)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Dinosaur", specifiSet: "TIKO")),
            Card(cardName: "Dinosaur (TGN2)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Dinosaur", specifiSet: "TGN2")),
            Card(cardName: "Polyraptor", cardType: .token)
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static func getScryfallImageUrl(name: String, specifiSet: String = "") -> String {
        let cardResolution = "normal"
        let cardNameForUrl = name.replacingOccurrences(of: " ", with: "+")
        var url = "https://api.scryfall.com/cards/named?exact=\(cardNameForUrl)&format=img&version=\(cardResolution)"
        // Example https://api.scryfall.com/cards/named?exact=Zombie+Giant&format=img&version=normal
        
        if specifiSet != "" {
            url.append("&set=\(specifiSet)")
        }
        
        return url
    }
    
    static func getDeckForId(deckPickedId: Int) -> ([Card], [Card]) {
        let difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
        return getDeckForId(deckPickedId: deckPickedId, difficulty: difficulty)
    }
    
    static func getDeckForId(deckPickedId: Int, difficulty: Int) -> ([Card], [Card]) {
        switch deckPickedId {
        case DecksId.human:
            return getHumanDeck(difficulty: difficulty)
        case DecksId.phyrexian:
            return getPhyrexianDeck(difficulty: difficulty)
        case DecksId.sliver:
            return getSliverDeck(difficulty: difficulty)
        case DecksId.dinosaur:
            return getDinosaurDeck(difficulty: difficulty)
        case DecksId.eldrazi:
            return getEldraziDeck(difficulty: difficulty)
        case DecksId.nature:
            return getNatureDeck(difficulty: difficulty)
        default:
            return getZombieDeck(difficulty: difficulty)
        }
    }
    
    static func getRandomCardFromStarterPermanents(deckPickedId: Int) -> Card {
        
        /* WEAK PERMANENTS THE HORDE CAN START WITH
         
         1 Ghostly Prison
         1 Hissing Miasma
         1 Authority of the Consuls
         1 Glorious Anthem
         
         ONLY ZOMBIE -> NO COMMONS
         
         1 Liliana's Mastery
         1 Open the Graves
         1 Graf Harvest
         1 Hissing Miasma
         1 Headless Rider
         
         ONLY HUMAN
         
         1 Prava of the Steel Legion
         1 Odric, Lunarch Marshal
         1 Assemble the Legion
         
         ONLY PHYREXIAN
         
         1 Propaganda
         
         ONLY SLIVER
         
         1 Propaganda
         
         ONLY DINOSAUR
         
         1 Gruul War Chant
         
         ONLY ELDRAZI
         
         1 Forsaken Monument
         
         */
        
        var commonCards = [
            Card(cardName: "Ghostly Prison", cardType: .enchantment),
            Card(cardName: "Hissing Miasma", cardType: .enchantment),
            Card(cardName: "Authority of the Consuls", cardType: .enchantment),
            Card(cardName: "Glorious Anthem", cardType: .enchantment)
        ]
        
        switch deckPickedId {
        case DecksId.human:
            commonCards.append(Card(cardName: "Prava of the Steel Legion", cardType: .creature))
            commonCards.append(Card(cardName: "Odric, Lunarch Marshal", cardType: .creature))
        case DecksId.phyrexian:
            commonCards.append(Card(cardName: "Propaganda", cardType: .enchantment))
        case DecksId.sliver:
            commonCards.append(Card(cardName: "Propaganda", cardType: .enchantment))
        case DecksId.dinosaur:
            commonCards.append(Card(cardName: "Gruul War Chant", cardType: .enchantment))
        case DecksId.eldrazi:
            commonCards.append(Card(cardName: "Forsaken Monument", cardType: .artifact))
        case DecksId.nature:
            commonCards.append(Card(cardName: "Primal Rage", cardType: .enchantment))
        default:
            commonCards = [
                Card(cardName: "Liliana's Mastery", cardType: .enchantment),
                Card(cardName: "Open the Graves", cardType: .enchantment),
                Card(cardName: "Graf Harvest", cardType: .enchantment),
                Card(cardName: "Hissing Miasma", cardType: .enchantment),
                Card(cardName: "Headless Rider", cardType: .creature)
            ]
        }
        
        return commonCards.randomElement()!
    }
    
    static func getRandomCardFromMidGamePermanents(deckPickedId: Int) -> Card {
        
        /* POWERFULL PERMANENTS THE HORDE CAN SPAWN MID GAME
         
         1 Unnatural Growth
         1 Collective Blessing
         1 Levitation
         1 Ethereal Absolution
         
         ONLY ZOMBIE -> NO COMMONS
         
         1 Zombie Master
         1 Josu Vess, Lich Knight
         
         ONLY HUMAN
         
         1 Oketra the True
         1 Emmara Tandris
         1 Resolute Archangel
         1 Akroma, Angel of Wrath
         1 Angelic Arbiter
         1 Gisela, Blade of Goldnight
         
         ONLY PHYREXIAN
         
         1 Poison-Tip Archer
         1 Atraxa, Praetors' Voice
         1 Lord of Extinction
         
         ONLY SLIVER
         
         1 Sliver Hiverlord
         1 Sliver Legion
         
         ONLY DINOSAUR
         
         1 Zetalpa, Primal Dawn
         1 End-Raze Forerunners
         
         ONLY ELDRAZI
         
         1 Brisela, Voice of Nightmares
         
         */
        
        var commonCards = [
            Card(cardName: "Unnatural Growth", cardType: .enchantment),
            Card(cardName: "Collective Blessing", cardType: .enchantment),
            Card(cardName: "Levitation", cardType: .enchantment),
            Card(cardName: "Ethereal Absolution", cardType: .enchantment)
        ]
        
        switch deckPickedId {
        case DecksId.human:
            commonCards.append(Card(cardName: "Prava of the Steel Legion", cardType: .creature))
            commonCards.append(Card(cardName: "Assemble the Legion", cardType: .enchantment))
            commonCards.append(Card(cardName: "Akroma, Angel of Wrath", cardType: .creature))
            commonCards.append(Card(cardName: "Angelic Arbiter", cardType: .creature))
            commonCards.append(Card(cardName: "Gisela, Blade of Goldnight", cardType: .creature))
        case DecksId.phyrexian:
            commonCards.append(Card(cardName: "Poison-Tip Archer", cardType: .creature))
            commonCards.append(Card(cardName: "Atraxa, Praetors' Voice", cardType: .creature))
            commonCards.append(Card(cardName: "Lord of Extinction", cardType: .creature))
        case DecksId.sliver:
            commonCards.append(Card(cardName: "Sliver Hiverlord", cardType: .creature))
            commonCards.append(Card(cardName: "Sliver Legion", cardType: .creature))
        case DecksId.dinosaur:
            commonCards.append(Card(cardName: "Zetalpa, Primal Dawn", cardType: .creature))
            commonCards.append(Card(cardName: "End-Raze Forerunners", cardType: .creature))
        case DecksId.eldrazi:
            commonCards.append(Card(cardName: "Brisela, Voice of Nightmares", cardType: .creature))
        case DecksId.nature:
            commonCards.append(Card(cardName: "Worldspine Wurm", cardType: .creature))
            commonCards.append(Card(cardName: "Impervious Greatwurm", cardType: .creature))
            commonCards.append(Card(cardName: "Beastmaster Ascension", cardType: .enchantment, cardImageURL: DeckManager.getScryfallImageUrl(name: "Beastmaster Ascension", specifiSet: "ZEN")))
        default:
            commonCards = [
                Card(cardName: "Zombie Master", cardType: .creature),
                Card(cardName: "Josu Vess, Lich Knight", cardType: .creature)
            ]
        }
        
        return commonCards.randomElement()!
    }
    
    static func getStrongCardsListForDeck(deckPickedId: Int) -> [Card] {
        
        /* TOO STRONG TO DRAW EARLY
         
         ZOMBIE
         
         Grave Titan
         Army of the Damned
         
         HUMAN
         
         True Conviction
         Collective Blessing
         Kyler, Sigardian Emissary
         Blade Historian
         Frontline Medic
         
         PHYREXIAN
         
         Vorinclex, Monstruous Raider
         Massacre Wurm
         Bronze Guardian
         Triumph of the Hordes
         Elesh Norn, Grand Cenobite
         Skithiryx, the Blight Dragon
         Blightsteel Colossus
         Phyrexian Hydra
         Urabrask the Hidden
         Phyrexian Obliterator
         
         SLIVER
         
         Shifting Sliver
         Megantic Sliver
         Fury Sliver
         
         DINOSAUR
         
         Gigantosaurus
         Ghalta, Primal Hunger
         Goring Ceratops
         The Tarrasque
         Silverclad Ferocidons
         Collective Blessing
         
         ELDRAZI
         
         Desolation Twin
         Breaker of Armies
         Ulamog's Crusher
         Bane of Bala Ged
         Void Winnower
         Pathrazer of Ulamog
         Hand of Emrakul
         
         NATURE
         
         Craterhoof Behemoth
         Nessian Boar
         End-Raze Forerunners
         Grothama, All-Devouring
         Crush of Wurms
         Parallel Evolution
         Second Harvest
         Predatory Rampage
         Unnatural Growth
         Sandwurm Convergence
         
         */
        
        var cardArray: [Card] = []
        
        switch deckPickedId {
        case DecksId.human:
            cardArray.append(Card(cardName: "True Conviction", cardType: .enchantment))
            cardArray.append(Card(cardName: "Collective Blessing", cardType: .enchantment))
            cardArray.append(Card(cardName: "Dictate of Heliod", cardType: .enchantment))
            cardArray.append(Card(cardName: "Kyler, Sigardian Emissary", cardType: .creature))
            cardArray.append(Card(cardName: "Blade Historian", cardType: .creature))
            cardArray.append(Card(cardName: "Frontline Medic", cardType: .creature))
            cardArray.append(Card(cardName: "Increasing Devotion", cardType: .sorcery))
            cardArray.append(Card(cardName: "Adriana, Captain of the Guard", cardType: .creature))
        case DecksId.phyrexian:
            cardArray.append(Card(cardName: "Vorinclex, Monstrous Raider",cardType: .creature))
            cardArray.append(Card(cardName: "Massacre Wurm",cardType: .creature))
            cardArray.append(Card(cardName: "Bronze Guardian",cardType: .creature))
            cardArray.append(Card(cardName: "Triumph of the Hordes",cardType: .sorcery))
            cardArray.append(Card(cardName: "Elesh Norn, Grand Cenobite",cardType: .creature))
            cardArray.append(Card(cardName: "Skithiryx, the Blight Dragon",cardType: .creature))
            cardArray.append(Card(cardName: "Blightsteel Colossus",cardType: .creature))
            cardArray.append(Card(cardName: "Phyrexian Hydra",cardType: .creature))
            cardArray.append(Card(cardName: "Urabrask the Hidden",cardType: .creature))
            cardArray.append(Card(cardName: "Phyrexian Obliterator",cardType: .creature))
            cardArray.append(Card(cardName: "Golem (TMBS)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TMBS")))
        case DecksId.sliver:
            cardArray.append(Card(cardName: "Shifting Sliver",cardType: .creature))
            cardArray.append(Card(cardName: "Megantic Sliver",cardType: .creature))
            cardArray.append(Card(cardName: "Fury Sliver",cardType: .creature))
        case DecksId.dinosaur:
            cardArray.append(Card(cardName: "Gigantosaurus", cardType: .creature))
            cardArray.append(Card(cardName: "Ghalta, Primal Hunger", cardType: .creature))
            cardArray.append(Card(cardName: "Goring Ceratops", cardType: .creature))
            cardArray.append(Card(cardName: "The Tarrasque", cardType: .creature))
            cardArray.append(Card(cardName: "Burning Sun's Avatar", cardType: .creature))
            cardArray.append(Card(cardName: "Silverclad Ferocidons", cardType: .creature))
            cardArray.append(Card(cardName: "Collective Blessing", cardType: .enchantment))
        case DecksId.eldrazi:
            cardArray.append(Card(cardName: "Desolation Twin", cardType: .creature))
            cardArray.append(Card(cardName: "Breaker of Armies", cardType: .creature))
            cardArray.append(Card(cardName: "Ulamog's Crusher", cardType: .creature))
            cardArray.append(Card(cardName: "Bane of Bala Ged", cardType: .creature))
            cardArray.append(Card(cardName: "Void Winnower", cardType: .creature))
            cardArray.append(Card(cardName: "It That Betrays", cardType: .creature))
            cardArray.append(Card(cardName: "Pathrazer of Ulamog", cardType: .creature))
            cardArray.append(Card(cardName: "Hand of Emrakul", cardType: .creature))
            cardArray.append(Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")))
        case DecksId.nature:
            cardArray.append(Card(cardName: "Craterhoof Behemoth", cardType: .creature))
            cardArray.append(Card(cardName: "Nessian Boar", cardType: .creature))
            cardArray.append(Card(cardName: "End-Raze Forerunners", cardType: .creature))
            cardArray.append(Card(cardName: "Grothama, All-Devouring", cardType: .creature))
            cardArray.append(Card(cardName: "Crush of Wurms", cardType: .sorcery, hasFlashback: true))
            cardArray.append(Card(cardName: "Parallel Evolution", cardType: .sorcery, hasFlashback: true))
            cardArray.append(Card(cardName: "Second Harvest", cardType: .instant))
            cardArray.append(Card(cardName: "Predatory Rampage", cardType: .sorcery))
            cardArray.append(Card(cardName: "Unnatural Growth", cardType: .enchantment))
            cardArray.append(Card(cardName: "Sandwurm Convergence", cardType: .enchantment, cardImageURL: DeckManager.getScryfallImageUrl(name: "Sandwurm Convergence", specifiSet: "AKH")))
            cardArray.append(Card(cardName: "Elemental TKHC", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "TKHC")))
            cardArray.append(Card(cardName: "Elemental T2XM", cardType: .token, cardImageURL: DeckManager.getScryfallImageUrl(name: "Elemental", specifiSet: "T2XM")))
        default:
            cardArray.append(Card(cardName: "Grave Titan", cardType: .creature))
            cardArray.append(Card(cardName: "Army of the Damned", cardType: .sorcery, cardImageURL: DeckManager.getScryfallImageUrl(name: "Army of the Damned", specifiSet: "ISD"), hasFlashback: true))
        }
        
        return cardArray
    }
}

/*
 ## Horde Deck ##
 1 5DN creature NO Blind Creeper 02d4c3a8-c733-45c1-bca5-51eed47c9230 86d5440a-7460-4b4f-a167-a6c4fb2d855e
 4 USG creature NO Cackling Fiend 2029954b-6fa7-40d7-bb19-d7534c62be5d ae410ae8-1e72-4727-96df-c7c195063fb5
 1 TOR creature NO Carrion Wurm ed0cf504-c365-4486-92bc-c329b83b99d0 37c2b228-94c0-4e84-ad6d-80b170bb6c0c
 1 MIC creature NO Death Baron 99024aa8-5687-4d38-8a4b-feef42d6c1ff 11641a17-e979-4edb-adba-789f21fd017d
 1 MIC creature NO Fleshbag Marauder 4b1bf05e-753e-4350-a913-894cf3cecc0c a03c738c-88d9-4cf6-a650-20ce6e5565bc
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 2 M19 creature NO Infectious Horror 0931206b-eed2-40d0-9496-5ecefc7f8f90 d17aaa92-10ca-4f70-b45e-5a51e9192efb
 3 PLS creature NO Maggot Carrier e4ad4b81-3685-4f95-84c0-755263b9d3b1 ab2c3dc4-bb49-4ec3-a6c8-4256d1939326
 2 MBS creature NO Nested Ghoul e60b6b71-eea8-42b3-81e2-c8fb1af5e218 c035ff58-9df3-4db4-b9d0-97d58080ecfe
 2 ISD creature NO Rotting Fensnake be22faba-07e0-4036-b700-82769989250b c21cbb10-9157-4887-a752-29b9e94fc77a
 2 10E creature NO Severed Legion 34a8a658-a5f6-406f-99d8-c32ea2e26202 82633f38-5af1-429e-8c9d-db536af85309
 1 TSP creature NO Skulking Knight 11e4c731-4212-4aad-891f-fe066ed0436f a7f7927b-64ae-4448-9540-8d7bbe88c9cc
 2 HOP creature NO Soulless One 27d98b94-a8a1-442b-8940-4ffab51b5164 410a214b-09c4-49bd-a461-3330d0249ae5
 1 ISD creature NO Unbreathing Horde e6cd9203-e4d3-4d9f-b59f-4e454fc5a477 1a91ea47-0c06-4333-a309-ac360c5cc9bd
 1 HOP creature NO Undead Warchief e6af56bf-bd78-4801-8f6e-033cdd68de3d 01482b0c-d05b-4356-9144-e044159f4dcb
 2 SCG creature NO Vengeful Dead 277c8ee9-0157-4e45-96ad-1b67716955ee 7c11c11d-9809-4031-8cbc-21aef07d7f1f
 1 ISD creature NO Walking Corpse fea95888-e16a-4209-9cd4-623f7f4d2f67 8e033384-3334-4082-9541-f2443d3bc424
 1 TSR creature NO Yixlid Jailer 1f55303e-1369-4e42-9ed4-36609887c7c1 3f2ef91f-d113-4e8d-a164-c6e261aa9c12

 2 GVL enchantment NO Bad Moon fc5d3341-cbce-49e5-93cc-8add92479dca 8f8a75da-ea3c-43e7-9d32-1c92f8ec0fd2
 1 M12 enchantment NO Call to the Grave db5a4c25-5ae5-4a04-be79-bdee39b9152c 5e1324b6-dba0-4aff-a403-a45d2b405f5b
 2 ISD enchantment NO Endless Ranks of the Dead 69d4ecac-4735-4667-bfc1-c8800b436d08 5db15c5f-80b7-4f7f-985a-9bbec3199ad9
 1 MIR enchantment NO Forsaken Wastes b9e61e68-9dc8-4295-95dc-dd66a0907c8c c9dbfc7c-164d-47b8-8f05-987864fca89b

 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 2 MM3 sorcery NO Delirium Skeins 7397036f-8114-47cc-b52f-c532a6845d16 64b0d9e7-4a0f-4f07-99ae-31c3c9f0037a
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f
 1 DDJ sorcery NO Twilight's Call ae0a1d9c-19cb-42ee-97c3-464e38e84615 a6e04dd2-75ad-4427-93cc-37226340c2fb

 5 TBBD token NO Zombie Giant e7bba04b-be75-4857-a724-c9e2150d56ad be7e26e1-5db6-49ba-a88e-c79d889cd364
 55 TMH2 token NO Zombie ddc8c973-c31e-463f-be45-f3fa7d632362 3031bec1-c6dc-441f-9391-458bb1577c56

 ## Too Strong ##
 1 SLD creature NO Grave Titan f3abd4d1-a975-4e85-8684-aa0fce029670 8f1a018f-ce08-428b-9be2-937204dd25c2
 1 ISD sorcery NO Army of the Damned 75d667ec-86f4-4850-a3b6-e7a9fc7053b0 260a4544-a1eb-4d07-943f-0401ae288e13
 1 2X2 sorcery NO Damnation d57a8f0b-7989-4db5-8756-6f2690097252 d3c0aac5-b9f1-4446-bfea-3e1dd1cf1f2f
 1 A25 sorcery NO Plague Wind 18ec721f-c1ac-4581-a61d-2f0b09d6bf92 72d21d0d-7de7-4f03-8663-002c9290512f

 ## Available Tokens ##

 ## Weak Permanents ##
 1 EMN enchantment NO Graf Harvest d3ba6922-c2f7-45ab-87a3-d4bbd770d1ba fbc17697-9db9-41d4-aacf-b2f2e6ff80cf
 1 VOW creature NO Headless Rider d4fdacd7-3101-44e2-a880-dde7326137a4 c24018e8-b8f1-44a5-9355-8b79f363569d
 1 GPT enchantment NO Hissing Miasma e257d8e0-06e9-433d-a750-1962db399388 f394fd39-842f-4c98-b857-bdad3fd09758
 1 MIC enchantment NO Liliana's Mastery bd104c7e-311e-4b03-98d3-5f20f3a99d26 a92ee6ec-eebf-40b4-9dd9-c0551e33f5ff
 1 MIC enchantment NO Open the Graves 28778958-a1f9-4fea-b551-c193d1257f18 130978d1-0b20-4dfa-85f5-3ff2bc2cfda3

 ## Powerfull Permanents ##
 1 DOM creature NO Josu Vess, Lich Knight 974a46f9-aa84-4b34-bee5-c635166e5841 6ed6d088-db82-4648-a109-0e3fa1421847
 1 ME4 creature NO Zombie Master 5446c92f-ff22-4e9b-a2f6-e64c8560c1e0 c25eb8c9-4209-4fe4-8b02-be16d7d7bdf5
 */
