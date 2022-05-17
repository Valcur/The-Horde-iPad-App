//
//  DeckManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
 
struct DeckManager {
    
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
        deck.append(Card(cardName: "Army of the Damned", cardType: .sorcery, cardImage: DeckManager.getScryfallImageUrl(name: "Army of the Damned", specifiSet: "ISD")))
        
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
            deck.append(Card(cardName: "Zombie Giant Token", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Zombie Giant", specifiSet: "TBBD")))
        }
        
        // 55 Zombie Tokens
        for _ in 1...(55 * difficulty) {
            deck.append(Card(cardName: "Zombie Token", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Zombie", specifiSet: "TISD")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Zombie Token", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Zombie", specifiSet: "TISD"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }

    static private func getZombieClassicDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* ZOMBIE CLASSIC
         
         1 Army of the Damned
         1 Bad Moon
         1 Barter in Blood
         1 Cackling Fiend
         1 Call to the Grave
         1 Cemetery Reaper
         1 Death Baron
         1 Delirium Skeins
         1 Diregraf Ghoul
         1 Dread Slaver
         1 Endless Ranks of the Dead
         1 Erebos, God of the Dead
         1 Fleshbag Marauder
         1 Ghoulraiser
         1 Gluttonous Zombie
         1 Grave Betrayal
         1 Grave Titan
         1 Infectious Horror
         1 Intimidation
         1 Liliana's Reaver
         1 Maalfeld Twins
         1 Nested Ghoul
         1 Nocturnal Raid
         1 Noxious Ghoul
         1 Plague Wind
         1 Raving Dead
         1 Rotting Fensnake
         1 Rotting Mastodon
         1 Sibsig Icebreakers
         1 Smallpox
         1 Soulless One
         1 Sutured Ghoul
         1 Syphon Flesh
         1 Twilight's Call
         1 Unbreathing Horde
         1 Undead Warchief
         1 Vengeful Dead
         1 Wight of Precinct Six
         1 Zombie Apocalypse
         1 Zombie Brute
         5 Big Zombie tokens
         55 Zombie tokens
         */
        
        /*
        // 1 Army of the Damned
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "7/8/787503ed-ebf5-4309-8dc6-3de925ea28a6"), hasFlashback: true))
        
        // 1 Bad Moon
        deck.append(Card(cardType: .enchantment, cardImage: getCardUrl(imageUrlPart: "8/f/8f8a75da-ea3c-43e7-9d32-1c92f8ec0fd2")))
        
        // 1 Barter in Blood
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "2/3/23986add-b33d-4bad-86f3-e2d0f99cf949")))
        
        // 1 Cackling Fiend
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "a/e/ae410ae8-1e72-4727-96df-c7c195063fb5")))
        
        // 1 Call to the Grave
        deck.append(Card(cardType: .enchantment, cardImage: getCardUrl(imageUrlPart: "5/e/5e1324b6-dba0-4aff-a403-a45d2b405f5b")))
        
        // 1 Cemetery Reaper
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "9/0/9008e94a-cfec-473f-ae75-57586e45098d")))
        
        // 1 Death Baron
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "1/1/11641a17-e979-4edb-adba-789f21fd017d")))
        
        // 1 Delirium Skeins
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "6/4/64b0d9e7-4a0f-4f07-99ae-31c3c9f0037a")))
        
        // 1 Diregraf Ghoul
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "5/c/5cf2d355-404e-4c21-9bc2-973d09a845a5")))
        
        // 1 Dread Slaver
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "3/d/3d8a3abd-a4a2-48e6-b709-1c0240a76c5e")))
        
        // 1 Endless Ranks of the Dead
        deck.append(Card(cardType: .enchantment, cardImage: getCardUrl(imageUrlPart: "1/5/155ae16c-f32b-421d-a92a-bf13d9f32891")))
        
        // 1 Erebos, God of the Dead
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "a/c/ac8bdb4c-2d68-4cb4-904f-1649427751dc")))
        
        // 1 Fleshbag Marauder
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "a/0/a03c738c-88d9-4cf6-a650-20ce6e5565bc")))
        
        // 1 Ghoulraiser
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "8/5/850ccdcb-2cd7-4f27-aa9b-917a62a5e94d")))
        
        // 1 Gluttonous Zombie
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "d/b/db909e95-7979-41f0-b17a-874c4137fcc1")))
        
        // 1 Grave Betrayal
        deck.append(Card(cardType: .enchantment, cardImage: getCardUrl(imageUrlPart: "4/7/47b38c68-8e72-4afc-bb5e-0b40880fdda9")))
        
        // 1 Grave Titan
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "8/f/8f1a018f-ce08-428b-9be2-937204dd25c2")))
        
        // 1 Infectious Horror
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "d/1/d17aaa92-10ca-4f70-b45e-5a51e9192efb")))
        
        // 1 Intimidation
        deck.append(Card(cardType: .enchantment, cardImage: getCardUrl(imageUrlPart: "1/b/1b9e1724-91cf-422e-909b-ddb69a6f9f76")))
        
        // 1 Liliana's Reaver
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "f/a/fa9396f3-a93c-47ee-91da-78af864c86c3")))
        
        // 1 Maalfeld Twins
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "f/a/fa715fde-8339-447b-8ac8-3126830bece8")))
        
        // 1 Nested Ghoul
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "c/0/c035ff58-9df3-4db4-b9d0-97d58080ecfe")))
        
        // 1 Nocturnal Raid
        deck.append(Card(cardType: .instant, cardImage: getCardUrl(imageUrlPart: "0/0/0015fee8-068a-421e-9143-bcb575371f9a")))
        
        // 1 Noxious Ghoul
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "7/d/7d67511b-c130-44d5-8536-4278a695627c")))
        
        // 1 Plague Wind
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "7/2/72d21d0d-7de7-4f03-8663-002c9290512f")))
        
        // 1 Raving Dead
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "5/d/5d24d153-a014-4524-a496-9fe1c41cbc2b")))
        
        // 1 Rotting Fensnake
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "c/2/c21cbb10-9157-4887-a752-29b9e94fc77a")))
        
        // 1 Rotting Mastodon
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "1/5/1564a20a-0e57-4ced-9eda-7acff74274e7")))
        
        // 1 Sibsig Icebreakers
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "3/8/3835752e-11a6-406c-8bff-b7d4f2f31d85")))
        
        // 1 Smallpox
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "c/2/c28db9a4-6696-460b-a9d3-98f4a31abe75")))
        
        // 1 Soulless One
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "4/1/410a214b-09c4-49bd-a461-3330d0249ae5")))
        
        // 1 Sutured Ghoul
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "8/3/8390d9b7-5adf-4039-8682-02bfba421ff9")))
        
        // 1 Syphon Flesh
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "6/3/63124d37-d16c-48d6-b1a2-a1a3834b3dc1")))
        
        // 1 Twilight's Call
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "a/6/a6e04dd2-75ad-4427-93cc-37226340c2fb")))
        
        // 1 Unbreathing Horde
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "d/d/dd119aa8-8414-4942-9a28-3e68a9a52a8e")))
        
        // 1 Undead Warchief
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "0/1/01482b0c-d05b-4356-9144-e044159f4dcb")))
        
        // 1 Vengeful Dead
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "7/c/7c11c11d-9809-4031-8cbc-21aef07d7f1f")))
        
        // 1 Wight of Precinct Six
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "3/2/32aec0ec-0feb-4276-ab9c-5bb18b5005a0")))
        
        // 1 Zombie Apocalypse
        deck.append(Card(cardType: .sorcery, cardImage: getCardUrl(imageUrlPart: "8/5/854ae40d-ee52-434e-8fe0-1b5a0d4ea58b")))
        
        // 1 Zombie Brute
        deck.append(Card(cardType: .creature, cardImage: getCardUrl(imageUrlPart: "b/3/b37db470-3aef-4fc4-98ce-63b5fb2546f6")))
        
        // 5 Big Zombie tokens
        for _ in 1...5 {
            deck.append(Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "b/e/be7e26e1-5db6-49ba-a88e-c79d889cd364")))
        }
       
        // 55 Zombie tokens
        for _ in 1...55 {
            deck.append(Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "8/a/8a98d0bf-4106-4ff1-89d4-3f6040b2cd5e")))
        }
        */
        let tokens: [Card] = [
            //Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "8/a/8a98d0bf-4106-4ff1-89d4-3f6040b2cd5e")),
            //Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "b/e/be7e26e1-5db6-49ba-a88e-c79d889cd364"))
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
         1 Fungus Sliver
         1 Fury Sliver
         1 Hive Stirrings
         1 Lancer Sliver
         1 Lavabelly Sliver
         1 Leeching Sliver
         1 Lymph Sliver
         1 Megantic Sliver
         1 Might Sliver
         4 Plague Wind
         1 Root Sliver
         1 Ruinous Ultimatum
         1 Shifting Sliver
         1 Sidewinder Sliver
         1 Sinew Sliver
         1 Sliver Legion
         1 Spined Sliver
         1 Spitting Sliver
         1 Synchronous Sliver
         1 Tempered Sliver
         1 Toxin Sliver
         1 Two-Headed Sliver
         1 Vampiric Sliver
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
        deck.append(Card(cardName: "Essence Sliver",cardType: .sorcery))
        
        // 1 Frenzy Sliver
        deck.append(Card(cardName: "Frenzy Sliver",cardType: .creature))
        
        // 1 Fungus Sliver
        deck.append(Card(cardName: "Fungus Sliver",cardType: .creature))
        
        // 1 Fury Sliver
        deck.append(Card(cardName: "Fury Sliver",cardType: .creature))
        
        // 1 Hive Stirrings
        deck.append(Card(cardName: "Hive Stirrings",cardType: .sorcery))
        
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
        
        // 4 Plague Wind
        for _ in 1...4 {
            deck.append(Card(cardName: "Plague Wind",cardType: .sorcery))
        }
        
        // 1 Root Sliver
        deck.append(Card(cardName: "Root Sliver",cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum",cardType: .sorcery))
        
        // 1 Shifting Sliver
        deck.append(Card(cardName: "Shifting Sliver",cardType: .creature))
        
        // 1 Sidewinder Sliver
        deck.append(Card(cardName: "Sidewinder Sliver",cardType: .creature))
        
        // 1 Sinew Sliver
        deck.append(Card(cardName: "Sinew Sliver",cardType: .creature))
        
        // 1 Sliver Legion
        deck.append(Card(cardName: "Sliver Legion",cardType: .creature))
        
        // 1 Spined Sliver
        deck.append(Card(cardName: "Spined Sliver",cardType: .creature))
        
        // 1 Spitting Sliver
        deck.append(Card(cardName: "Spitting Sliver",cardType: .creature))
        
        // 1 Synchronous Sliver
        deck.append(Card(cardName: "Synchronous Sliver",cardType: .creature))
        
        // 1 Tempered Sliver
        deck.append(Card(cardName: "Tempered Sliver",cardType: .creature))
        
        // 1 Toxin Sliver
        deck.append(Card(cardName: "Toxin Sliver",cardType: .creature))
        
        // 1 Two-Headed Sliver
        deck.append(Card(cardName: "Two-Headed Sliver",cardType: .creature))
        
        // 1 Vampiric Sliver
        deck.append(Card(cardName: "Vampiric Sliver",cardType: .creature))
        
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
         1 Void Grafter -> Hard to know who to target
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
        deck.append(Card(cardName: "ncubator Drone", cardType: .creature))
        
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
        
        // 1 Void Grafter
        deck.append(Card(cardName: "Void Grafter", cardType: .creature))
        
        // 1 Void Winnower
        deck.append(Card(cardName: "Void Winnower", cardType: .creature))
        
        // 1 Witness the End
        deck.append(Card(cardName: "Witness the End", cardType: .sorcery))
        
        
        // 15 Eldrazi Horror (TEMN) 1
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")))
        }
        
        // 25 Eldrazi Scion (DDR) 71
        for _ in 1...(25 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")))
        }
        
        // 5 Eldrazi (TPCA) 1
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Eldrazi (TPCA)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi", specifiSet: "TPCA")))
        }
        
        // 15 Eldrazi Spawn (DDP) 76
        for _ in 1...(15 * difficulty) {
            deck.append(Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Eldrazi Spawn (DDP)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Spawn", specifiSet: "TMIC")),
            Card(cardName: "Eldrazi Scion (DDR)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Scion", specifiSet: "TBFZ")),
            Card(cardName: "Eldrazi Horror (TEMN)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Eldrazi Horror", specifiSet: "TEMN")),
            Card(cardName: "Emrakul, the Aeons Torn", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Emrakul, the Aeons Torn", specifiSet: "ROE")),
            Card(cardName: "Kozilek, Butcher of Truth", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Kozilek, Butcher of Truth", specifiSet: "ROE")),
            Card(cardName: "Ulamog, the Infinite Gyre", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Ulamog, the Infinite Gyre", specifiSet: "ROE"))
        ]

        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getHumanDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* HUMAN ARMY
         
        1 Adeline, Resplendent Cathar
        1 Adriana, Captain of the Guard
        1 Archetype of Courage
        1 Benalish Marshal
        1 Blade Historian
        1 Captain of the Watch
        1 Cathars' Crusade -> PB POUR METTRE LES +1/+1
        1 Cazur, Ruthless Stalker
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
        1 Inspiring Veteran
        1 Knight Exemplar
        1 Kyler, Sigardian Emissary
        4 Plague Wind
        1 Radiant Destiny
        1 Rally the Ranks
        1 Reverent Hoplite
        1 Ruinous Ultimatum
        1 Shared Animosity
        1 Spare from Evil
        1 Stalwart Pathlighter
        1 Syr Alin, the Lion's Claw
        1 True Conviction
        2 Vandalblast
        1 Victory's Envoy -> pb de marqueurs
        1 Visions of Glory
        1 Worthy Knight
         
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
        
        // 1 Cathars' Crusade
        deck.append(Card(cardName: "Cathars' Crusade", cardType: .enchantment))
        
        // 1 Cazur, Ruthless Stalker
        deck.append(Card(cardName: "Cazur, Ruthless Stalker", cardType: .creature))
        
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
        deck.append(Card(cardName: "Inspiring Veteran", cardType: .creature))
        
        // 1 Knight Exemplar
        deck.append(Card(cardName: "Knight Exemplar", cardType: .creature))
        
        // 1 Kyler, Sigardian Emissary
        deck.append(Card(cardName: "Kyler, Sigardian Emissary", cardType: .creature))
        
        // 4 Plague Wind
        for _ in 1...2 {
            deck.append(Card(cardName: "Plague Wind", cardType: .sorcery))
        }
        
        // 1 Radiant Destiny
        deck.append(Card(cardName: "Radiant Destiny", cardType: .enchantment))
        
        // 1 Rally the Ranks
        deck.append(Card(cardName: "Rally the Ranks", cardType: .enchantment))
        
        // 1 Reverent Hoplite
        deck.append(Card(cardName: "Reverent Hoplite", cardType: .creature))
        
        // 1 Ruinous Ultimatum
        deck.append(Card(cardName: "Ruinous Ultimatum", cardType: .sorcery))
        
        // 1 Shared Animosity
        deck.append(Card(cardName: "Shared Animosity", cardType: .enchantment))
        
        // 1 Spare from Evil
        deck.append(Card(cardName: "Spare from Evil", cardType: .instant))
        
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
        
        // 1 Victory's Envoy
        deck.append(Card(cardName: "Victory's Envoy", cardType: .creature))
        
        // 1 Visions of Glory
        deck.append(Card(cardName: "Visions of Glory", cardType: .sorcery, hasFlashback: true))
        
        // 1 Worthy Knight
        deck.append(Card(cardName: "Worthy Knight", cardType: .creature))
        
        
        // 10 Soldier (TGRN) 2
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Soldier (TGRN)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Soldier", specifiSet: "TNCC")))
        }
        
        // 10 Knight (TMIC) 3
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Knight (TMIC)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Knight", specifiSet: "TM21")))
        }
        
        // 10 Human Warrior (TELD) 13
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Human Warrior (TELD)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Human Warrior", specifiSet: "TELD")))
        }
        
        // 10 Knight (TCM2) 4
        for _ in 1...(10 * difficulty) {
            deck.append(Card(cardName: "Knight (TCM2)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Knight", specifiSet: "TCM2")))
        }
        
        // 20 Human (TRNA) 1
        for _ in 1...(20 * difficulty) {
            deck.append(Card(cardName: "Human (TRNA)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Human", specifiSet: "TC20")))
        }
        
        
        let tokens: [Card] = [
            Card(cardName: "Human (TRNA)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Human", specifiSet: "TC20"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
    
    static private func getPhyrexianDeck(difficulty: Int) -> ([Card], [Card]) {
        var deck: [Card] = []
        
        /* PHYREXIAN PERFECTION
         
         // Removed because of +1/+1 counters
         1 Arcbound Crusher
         1 Arcbound Overseer
         1 Arcbound Shikari
         1 Arcbound Slith
         1 Arcbound Tracker
         
         
         1 Blade Splicer
         1 Blightsteel Colossus
         1 Bronze Guardian
         1 Carrion Call
         2 Cleansing Meditation
         1 Core Prowler
         1 Elesh Norn, Grand Cenobite
         1 Hand of the Praetors
         1 Ich-Tekik, Salvage Splicer
         1 Inexorable Tide
         1 Massacre Wurm
         1 Maul Splicer
         1 Nest of Scarabs
         1 Phyrexian Crusader
         1 Phyrexian Hydra
         1 Phyrexian Obliterator
         1 Phyrexian Rebirth
         1 Phyrexian Swarmlord
         3 Plague Wind
         1 Priests of Norn
         1 Reaper of Sheoldred
         1 Ruinous Ultimatum
         1 Scuttling Doom Engine
         1 Sensor Splicer
         1 Spinebiter
         1 Spread the Sickness
         1 Triumph of the Hordes
         2 Vandalblast
         1 Vedalken Humiliator
         1 Vorinclex, Monstrous Raider
         1 Wake the Past
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
        
        // 1 Arcbound Crusher
        deck.append(Card(cardName: "Arcbound Crusher",cardType: .creature))
        
        // 1 Arcbound Overseer
        deck.append(Card(cardName: "Arcbound Overseer",cardType: .creature))
        
        // 1 Arcbound Shikari
        deck.append(Card(cardName: "Arcbound Shikari",cardType: .creature))
        
        // 1 Arcbound Slith
        deck.append(Card(cardName: "Arcbound Slith",cardType: .creature))
        
        // 1 Arcbound Tracker
        deck.append(Card(cardName: "Arcbound Tracker",cardType: .creature))
        
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
        
        // 1 Ich-Tekik, Salvage Splicer
        deck.append(Card(cardName: "Ich-Tekik, Salvage Splicer",cardType: .creature))
        
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
        
        // 3 Plague Wind
        for _ in 1...3 {
            deck.append(Card(cardName: "Plague Wind",cardType: .sorcery))
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
        
        // 1 Spread the Sickness
        deck.append(Card(cardName: "Spread the Sickness",cardType: .sorcery))
        
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
        
        // 1 Wake the Past
        deck.append(Card(cardName: "Wake the Past",cardType: .sorcery))
        
        // 1 Wurmcoil Engine
        deck.append(Card(cardName: "Wurmcoil Engine",cardType: .creature))
        
        // 25 Golem (TNPH) 3
        for _ in 1...25 {
            deck.append(Card(cardName: "Golem TNPH", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TCMR")))
        }
        
        // 5 Assembly-Worker (TTSR) 14
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Assembly-Worker TTSR", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Assembly-Worker", specifiSet: "TTSR")))
        }
        
        // 5 Construct (TMH2) 16
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Construct TMH2", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TMH2")))
        }
        
        // 5 Construct (TC18) 21
        for _ in 1...(5 * difficulty) {
            deck.append(Card(cardName: "Construct (TC18)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TC18")))
        }
        
        // 4 Construct (TZNR) 10
        for _ in 1...(4 * difficulty) {
            deck.append(Card(cardName: "Construct (TZNR)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Construct", specifiSet: "TZNR")))
        }
        
        // 3 Beast (TKLD) 1
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Beast (TKLD)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Beast", specifiSet: "TKLD")))
        }
        
        // 3 Golem (TRIX) 4
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Golem (TRIX)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TRIX")))
        }
        
        // 3 Golem (TMBS) 3
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "Golem (TMBS)", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TMBS")))
        }
        
        // 3 Wurm (TSOM) 8
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "WURM (TSOM) 8", cardType: .token, cardImage: "https://c1.scryfall.com/file/scryfall-cards/large/front/b/6/b68e816f-f9ac-435b-ad0b-ceedbe72447a.jpg?1598312203"))
        }
        
        // 3 Wurm (TSOM) 9
        for _ in 1...(3 * difficulty) {
            deck.append(Card(cardName: "WURM (TSOM) 9", cardType: .token, cardImage: "https://c1.scryfall.com/file/scryfall-cards/large/front/a/6/a6ee0db9-ac89-4ab6-ac2e-8a7527d9ecbd.jpg?1598312477"))
        }
        
        let tokens: [Card] = [
            Card(cardName: "Golem TNPH", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Golem", specifiSet: "TCMR")),
            Card(cardName: "Insect TSOM", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Insect", specifiSet: "TSOM")),
            Card(cardName: "Insect TAKH", cardType: .token, cardImage: DeckManager.getScryfallImageUrl(name: "Insect", specifiSet: "TAKH")),
            Card(cardName: "WURM (TSOM) 8", cardType: .token, cardImage: "https://c1.scryfall.com/file/scryfall-cards/large/front/b/6/b68e816f-f9ac-435b-ad0b-ceedbe72447a.jpg?1598312203"),
            Card(cardName: "WURM (TSOM) 9", cardType: .token, cardImage: "https://c1.scryfall.com/file/scryfall-cards/large/front/a/6/a6ee0db9-ac89-4ab6-ac2e-8a7527d9ecbd.jpg?1598312477")
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
        switch deckPickedId {
        case 1:
            return getHumanDeck(difficulty: difficulty)
        case 2:
            return getPhyrexianDeck(difficulty: difficulty)
        case 3:
            return getSliverDeck(difficulty: difficulty)
        case 4:
            return getEldraziDeck(difficulty: difficulty)
        default:
            return getZombieDeck(difficulty: difficulty)
        }
    }
}

