//
//  DeckManager.swift
//  Horde
//
//  Created by Loic D on 10/05/2022.
//

import Foundation
 
class DeckManager {
    
    let cardResolution = "normal"
    let cardFormat = ".jpg"
    let url: String
    
    init() {
        url = "https://c1.scryfall.com/file/scryfall-cards/\(cardResolution)/front/"
    }
    
    func getCardUrl(imageUrlPart: String) -> String{
        return "\(url)\(imageUrlPart)\(cardFormat)"
    }
    
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

    func getZombieClassicDeck() -> ([Card], [Card]) {
        var deck: [Card] = []
        
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
        
        let tokens: [Card] = [
            Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "8/a/8a98d0bf-4106-4ff1-89d4-3f6040b2cd5e")),
            Card(cardType: .token, cardImage: getCardUrl(imageUrlPart: "b/e/be7e26e1-5db6-49ba-a88e-c79d889cd364"))
        ]
        
        deck.shuffle()
        
        return (deck, tokens)
    }
}

