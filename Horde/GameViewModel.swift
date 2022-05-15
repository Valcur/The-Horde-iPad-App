//
//  GameViewModel.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var turnStep: Int = 0
    @Published var cardsToCast: CardsToCast
    @Published var cardsOnBoard: [Card] = []
    @Published var cardsOnGraveyard: [Card] = []
    
    @Published var deck: [Card] = []
    
    let tokensAvailable: [Card]
    @Published var showGraveyard = false
    @Published var damageTakenThisTurn: Int = 0
    
    /** Turn order
        1) launch all in graveyard
          draw until a non token card is revealed
          show them to players until next is pressed
        2) show board to let player resolve card effects and deal with the attack
          change text from next to new turn
          start another turn when new turn is pressed
          change text from new turn to next
     */
    
    init() {
        //super.init()
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImage: ""))
        
        let deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")
        //let deckAndTokens = deckManager.getZombieClassicDeck()
        let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId)
        self.deck = deckAndTokens.0
        self.tokensAvailable = deckAndTokens.1
    }
    
    func startNewHordeStep() {
        // Draw until nonToken card is drawed
        // If graveyard have cards with flashback, take it off from graveyard
        // Show all cards
        
        if turnStep == 1 {
            cardsToCast = drawUntilNonToken()
            cardsToCast.cardsFromGraveyard = searchGraveyardForFlashback()
        }
        if turnStep == 2 {
            // Add cards to board or graveyard
            if cardsToCast.cardFromLibrary.cardType == .instant || cardsToCast.cardFromLibrary.cardType == .sorcery {
                cardsOnGraveyard.append(cardsToCast.cardFromLibrary)
            } else if cardsToCast.cardFromLibrary.cardType != .token {
                addCardToBoard(card: cardsToCast.cardFromLibrary)
            }
            
            for token in cardsToCast.tokensFromLibrary {
                addCardToBoard(card: token)
            }
            // A MODIFIER SI DES CREATURES SE RELANCENT EPUIS LE CIMETIERE
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
            // Attack
            
        }
    }
    
    func drawUntilNonToken() -> CardsToCast {
        
        var cardRevealed: Card
        var tokensRevealed: [Card] = []
        
        repeat {
            cardRevealed = deck.removeLast()
            if cardRevealed.cardType == .token {
                tokensRevealed.append(cardRevealed)
            }
        } while cardRevealed.cardType == .token && deck.count != 0
        
        // We regroup tokens
        tokensRevealed = regroupSameCardInArray(cardArray: tokensRevealed)
        
        return CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: tokensRevealed, cardFromLibrary: cardRevealed)
    }
    
    func regroupSameCardInArray(cardArray: [Card]) -> [Card] {
        var tmpArray = cardArray
        var i = 0
        while i < tmpArray.count {
            var j = i + 1
            while j < tmpArray.count {
                if tmpArray[i] == tmpArray[j] {
                    tmpArray[i].cardCount += tmpArray[j].cardCount
                    tmpArray.remove(at: j)
                    j -= 1
                }
                j += 1
            }
            i += 1
        }
        return tmpArray
    }
    
    func searchGraveyardForFlashback() -> [Card] {
        var cardsFromGraveyard: [Card] = []
        var i = 0
        while i < cardsOnGraveyard.count {
            if cardsOnGraveyard[i].hasFlashback {
                let tmpCard = cardsOnGraveyard.remove(at: i)
                cardsFromGraveyard.append(tmpCard)
                i -= 1
            }
            i += 1
        }
        //cardsFromGraveyard = regroupSameCardInArray(cardArray: cardsFromGraveyard)
        return cardsFromGraveyard
    }
    
    func sendToGraveyard(card: Card) {
        if card.cardType != .token {
            cardsOnGraveyard.append(card)
        }
    }
    
    func addCardToBoard(card: Card) {
        // Enchantment are placed before creatures
        if card.cardType == .enchantment {
            cardsOnBoard.insert(card, at: 0)
        } else {
            cardsOnBoard.append(card)
        }
    }
    
    //MARK: BUTTONS
    
    // Player pressed the next button
    func nextButtonPressed() {
        turnStep += 1
        if turnStep > 2 {
            turnStep = 1
            damageTakenThisTurn = 0
        }
        startNewHordeStep()
    }
    
    func removeOneCardOnBoard(card: Card) {
        var tmpArray = cardsOnBoard
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                tmpArray[i].cardCount -= 1
                if tmpArray[i].cardCount <= 0 {
                    let tmpCard = tmpArray.remove(at: i)
                    sendToGraveyard(card: tmpCard)
                }
                cardsOnBoard = tmpArray
                return
            }
        }
    }

    func destroyAllCreatures() {
        var i = 0
        while i < cardsOnBoard.count {
            let type = cardsOnBoard[i].cardType
            if type == .creature || type == .token {
                let tmpCard = cardsOnBoard.remove(at: i)
                sendToGraveyard(card: tmpCard)
                i -= 1
            }
            i += 1
        }
    }
    
    func destroyAllPermanents() {
        let count = cardsOnBoard.count
        for _ in 0 ..< count {
            let tmpCard = cardsOnBoard.remove(at: 0)
            sendToGraveyard(card: tmpCard)
        }
    }
    
    func createToken(token: Card) {
        cardsOnBoard.append(Card(cardName: token.cardName, cardType: .token, cardImage: token.cardImage))
        cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
    }
    
    func castCardFromGraveyard(card: Card) {
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment {
            addCardToBoard(card: card)
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
            removeCardFromGraveyard(card: card)
        }
    }
    
    func removeCardFromGraveyard(card: Card) {
        for i in 0..<cardsOnGraveyard.count {
            if cardsOnGraveyard[i] == card {
                cardsOnGraveyard.remove(at: i)
                return
            }
        }
    }
    
    func sendTopLibraryCardToGraveyard() {
        if deck.count > 0 {
            let card = deck.removeLast()
            if card.cardType != .token {
                cardsOnGraveyard.append(card)
            }
            damageTakenThisTurn += 1
        }
    }
}
