//
//  GameViewModel.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var turnStep: Int = -1
    @Published var cardsToCast: CardsToCast
    @Published var cardsOnBoard: [Card] = []
    @Published var cardsOnGraveyard: [Card] = []
    
    @Published var deck: [Card] = []
    
    var tokensAvailable: [Card]
    @Published var showGraveyard = false
    @Published var damageTakenThisTurn: Int = 0
    @Published var deckPercentToKeepAtStart: Int
    
    var deckPickedId = 0
    var deckSizeAtStart = 0
    @Published var shouldStartWithEnchantment = false
    @Published var shouldSpawnGeneralAtHalf = false
    @Published var shouldntHaveBoardWipeInFirstQuarter = false
    
    // true = 100 card deck, false = multiple deck with increasing difficulty
    @Published var isClassicMode = true
    var marathonStage = -1
    
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
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImage: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        //let deckAndTokens = deckManager.getZombieClassicDeck()
        let deckAndTokens = DeckManager.getDeckForId(deckPickedId: 1)
        self.deck = deckAndTokens.0
        self.tokensAvailable = deckAndTokens.1
        print("Game initiating with deck \(deckPickedId)")
        
        deckPercentToKeepAtStart = 100
        turnStep = -1
        marathonStage = -1
    }
    
    func startGame() {
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImage: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")

        let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId)
        self.deck = deckAndTokens.0
        self.tokensAvailable = deckAndTokens.1
        print("Game initiating with deck \(deckPickedId)")
        
        cardsOnBoard = []
        cardsOnGraveyard = []
        
        deckPercentToKeepAtStart = 100
        turnStep = -1
        marathonStage = -1
    }
    
    func startNewHordeStep() {
        // Draw until nonToken card is drawed
        // If graveyard have cards with flashback, take it off from graveyard
        // Show all cards
        
        // Setup step
        if turnStep == 0 {
            setupHorde()
        }
        if turnStep == 1 {
            // If empty, start new marathon stage
            if !isClassicMode && deck.count == 0 && marathonStage < 3 {
                marathonStage += 1
                generateMarathonStage(atStage: marathonStage)
            }
            
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
        
        showLibraryTopCard = false
    }
    
    func setupHorde(withDifficulty: Int = -1) {
        // Marathon setup
        if !isClassicMode && marathonStage == -1 {
            deckPercentToKeepAtStart = 50
            shouldSpawnGeneralAtHalf = false
            shouldStartWithEnchantment = false
            marathonStage = 0
        }
        
        if withDifficulty > -1 {
            let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId, difficulty: withDifficulty)
            self.deck = deckAndTokens.0
            self.tokensAvailable = deckAndTokens.1
        } else {
            let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId)
            self.deck = deckAndTokens.0
            self.tokensAvailable = deckAndTokens.1
        }
        
        // Reduce library size
        let cardsToKeep = Int(Double(deck.count) * (Double(deckPercentToKeepAtStart) / 100.0))
        deck.removeSubrange(0..<(deck.count - cardsToKeep))
        deckSizeAtStart = deck.count
        
        // INFINITE LOOP IF TOO MANY BOARD WIPE AFETR SIZE REDUCTION ?
        var n = 0
        // Make sure no boardwipe in first quarter
        if shouldntHaveBoardWipeInFirstQuarter && marathonStage <= 0 {
            let quarter = deck.count / 6
            var hasBoardWipeInFirstQuarter = false
            
            repeat {
                deck.shuffle()
                for i in 1..<quarter {
                    for boardWipe in DeckManager.boardWipesCards {
                        if deck[deck.count - i] == boardWipe {
                            hasBoardWipeInFirstQuarter = true
                        }
                    }
                }
                print("loop \(n)")
                n += 1
            } while hasBoardWipeInFirstQuarter && n < 100
            
            // Can't suffle without no board wipe wich means too many board wipe -> wouldn't be fun -> let's get a new deck
            if n >= 100 {
                setupHorde(withDifficulty: withDifficulty)
                return
            }
        }
        
        // Spawn start enchantment
        if shouldStartWithEnchantment {
            addCardToBoard(card: DeckManager.getRandomCardFromStarterPermanents(deckPickedId: deckPickedId))
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
            spawnGeneralIfNeeded()
        } while cardRevealed.cardType == .token && deck.count != 0
        
        // We regroup tokens
        tokensRevealed = regroupSameCardInArray(cardArray: tokensRevealed)
        
        print("About to play \(cardRevealed.cardName) from library")
        
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
            let tmpCard = newCardCopy(copyOfCard: card)
            tmpCard.cardCount = 1
            cardsOnGraveyard.append(tmpCard)
        }
    }
    
    func addCardToBoard(card: Card) {
        // Enchantments and artifacts are placed before creatures
        if card.cardType == .enchantment || card.cardType == .artifact  {
            cardsOnBoard.insert(card, at: 0)
        } else {
            cardsOnBoard.append(card)
        }
    }
    
    func newCardCopy(copyOfCard: Card) -> Card {
        let tmpCard = Card(cardName: copyOfCard.cardName, cardType: copyOfCard.cardType, cardImage: copyOfCard.cardImage, hasFlashback: copyOfCard.hasFlashback)
        tmpCard.cardCount = copyOfCard.cardCount
        return copyOfCard
    }
    
    func spawnGeneralIfNeeded() {
        if shouldSpawnGeneralAtHalf && deck.count == deckSizeAtStart / 2 {
            addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
            // MAKE SURE IT HAPPENS ONLY ONCE
        }
    }
    
    func generateMarathonStage(atStage: Int) {
        var difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
        difficulty += atStage
        
        setupHorde(withDifficulty: difficulty)
        
        // Spawn everything needed between waves
        
        // First Stage, 50 cards normal amount of tokens
        if atStage == 0 {
            
        }
        // Second Stage, 100 cards with twice the amount of tokens
        // Spawn first boss
        else if atStage == 1 {
            addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
        }
        // Second Stage, 150 cards with tokens x3
        // Spawn second boss
        else if atStage == 2 {
            addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
            addCardToBoard(card: DeckManager.getRandomCardFromStarterPermanents(deckPickedId: deckPickedId))
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
    
    func isNextButtonDisabled() -> Bool {
        return (isClassicMode && deck.count == 0) || (!isClassicMode && deck.count == 0 && marathonStage >= 2)
    }
    
    func removeOneCardOnBoard(card: Card) {
        var tmpArray = cardsOnBoard
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card {
                card.cardCount -= 1
                if card.cardCount <= 0 {
                    tmpArray.remove(at: i)
                }
                sendToGraveyard(card: card)
                
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
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment || card.cardType == .artifact {
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
            
            spawnGeneralIfNeeded()
            
            showLibraryTopCard = false
        }
    }
    
    func putOnTopOfLibrary(card: Card) {
        removeCardFromGraveyard(card: card)
        deck.append(card)
        showLibraryTopCard = false
    }
    
    func putAtBottomOfLibrary(card: Card) {
        removeCardFromGraveyard(card: card)
        deck.insert(card, at: 0)
    }
    
    func shuffleIntofLibrary(card: Card) {
        removeCardFromGraveyard(card: card)
        deck.append(card)
        deck.shuffle()
        showLibraryTopCard = false
    }
    
    func reduceLibrarySize(percentToKeep: Int) {
        deckPercentToKeepAtStart = percentToKeep
    }
    
    @Published var showLibraryTopCard = false
    
    func shuffleLibrary() {
        showLibraryTopCard = false
        deck.shuffle()
    }
    
    func putTopLibraryCardToBottom() {
        showLibraryTopCard = false
        putAtBottomOfLibrary(card: deck.removeLast())
    }
    
    func putTopLibraryCardToBattlefield() {
        let card = deck.last!
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment || card.cardType == .artifact {
            showLibraryTopCard = false
            addCardToBoard(card: card)
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
            deck.removeLast()
        }
    }
}
