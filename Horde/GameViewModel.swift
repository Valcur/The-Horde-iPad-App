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
    
    @Published var showGraveyard = false
    @Published var damageTakenThisTurn: Int = 0
    @Published var showLibraryTopCard = false

    @Published var gameConfig: GameConfig
    var deckPickedId = 0
    var deckSizeAtStart = 0
    var tokensAvailable: [Card]
    var marathonStage = -1
    var strongPermanentsAlreadySpawned: [Bool]
    
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
        
        turnStep = -1
        marathonStage = -1
        
        gameConfig = GameConfig(isClassicMode: true, shared: SharedParameters(shouldStartWithWeakPermanent: false, shouldntHaveBoardWipeInFirstQuarter: false, shouldntHaveBoardWipeAtAll: false, deckSize: 100), classic: ClassicModeParameters(shouldSpawnStrongPermanents: false, spawnStrongPermanentAt25: false, spawnStrongPermanentAt50: true, spawnStrongPermanentAt75: false, spawnStrongPermanentAt100: false))
        
        strongPermanentsAlreadySpawned = [false, false, false, false]
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
        
        gameConfig.shared.deckSize = 100
        turnStep = -1
        marathonStage = -1
        showLibraryTopCard = false
        damageTakenThisTurn = 0
        
        strongPermanentsAlreadySpawned = [false, false, false, false]
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
            if !gameConfig.isClassicMode && deck.count == 0 && marathonStage < 3 {
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
        if !gameConfig.isClassicMode && marathonStage == -1 {
            gameConfig.shared.deckSize = 50
            gameConfig.shared.shouldStartWithWeakPermanent = false
            gameConfig.classic.shouldSpawnStrongPermanents = false
            marathonStage = 0
        }
        
        // Get deck
        if withDifficulty > -1 {
            let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId, difficulty: withDifficulty)
            self.deck = deckAndTokens.0
            self.tokensAvailable = deckAndTokens.1
        } else {
            let deckAndTokens = DeckManager.getDeckForId(deckPickedId: deckPickedId)
            self.deck = deckAndTokens.0
            self.tokensAvailable = deckAndTokens.1
        }
        
        // Reduce or increase library size
        if gameConfig.shared.deckSize <= 100 {
            let cardsToKeep = Int(Double(deck.count) * (Double(gameConfig.shared.deckSize) / 100.0))
            deck.removeSubrange(0..<(deck.count - cardsToKeep))
            deckSizeAtStart = deck.count
        } else {
            let deck200 = DeckManager.getDeckForId(deckPickedId: deckPickedId).0
            
            for card in deck200 {
                self.deck.append(card)
            }
            
            if gameConfig.shared.deckSize == 300 {
                let deck300 = DeckManager.getDeckForId(deckPickedId: deckPickedId).0
                
                for card in deck300 {
                    self.deck.append(card)
                }
            }
            
            self.deck.shuffle()
        }

        // No boardwipe in first quarter
        var n = 0
        if gameConfig.shared.shouldntHaveBoardWipeInFirstQuarter && marathonStage <= 0 {
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
        
        // Replace Board Wipes with storng permanents
        if gameConfig.shared.shouldntHaveBoardWipeAtAll {
            removeBoardWipeFromDeck()
        }
        
        // Spawn start enchantment
        if gameConfig.shared.shouldStartWithWeakPermanent {
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
            spawnStrongPermanentIfNeeded()
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
    
    func spawnStrongPermanentIfNeeded() {
        if gameConfig.classic.shouldSpawnStrongPermanents {
            if gameConfig.classic.spawnStrongPermanentAt25 == true && !strongPermanentsAlreadySpawned[0] && deck.count == deckSizeAtStart - deckSizeAtStart / 4 {
                addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
                strongPermanentsAlreadySpawned[0] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt50 == true && !strongPermanentsAlreadySpawned[1] && deck.count == deckSizeAtStart / 2 {
                addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
                strongPermanentsAlreadySpawned[1] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt75 == true && !strongPermanentsAlreadySpawned[2] && deck.count == deckSizeAtStart / 4 {
                addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
                strongPermanentsAlreadySpawned[2] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt100 == true && !strongPermanentsAlreadySpawned[3] && deck.count == 0 {
                addCardToBoard(card: DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId))
                strongPermanentsAlreadySpawned[3] = true
            }
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
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
    
    func removeBoardWipeFromDeck() {
        for i in 0..<deck.count {
            for boardWipe in DeckManager.boardWipesCards {
                if deck[i] == boardWipe {
                    deck.remove(at: i)
                    deck.insert(DeckManager.getRandomCardFromMidGamePermanents(deckPickedId: deckPickedId), at: i)
                }
            }
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
        return (gameConfig.isClassicMode && deck.count == 0) || (!gameConfig.isClassicMode && deck.count == 0 && marathonStage >= 2)
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
    
    func castCardFromGraveyard(cardId: Int) {
        let card = cardsOnGraveyard[cardId]
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment || card.cardType == .artifact {
            addCardToBoard(card: cardsOnGraveyard[cardId])
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
            cardsOnGraveyard.remove(at: cardId)
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
            
            spawnStrongPermanentIfNeeded()
            
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
        gameConfig.shared.deckSize = percentToKeep
    }
    
    func shuffleLibrary() {
        showLibraryTopCard = false
        deck.shuffle()
    }
    
    func putTopLibraryCardToBottom() {
        showLibraryTopCard = false
        putAtBottomOfLibrary(card: deck.removeLast())
    }
    
    func castTopLibraryCard() {
        let card = deck.last!
        showLibraryTopCard = false
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment || card.cardType == .artifact {
            addCardToBoard(card: card)
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
        } else {
            sendToGraveyard(card: card)
        }
        deck.removeLast()
    }
    
    func changeGameMode(isClassicMode: Bool) {
        if isClassicMode {
            gameConfig.shared.deckSize = 100
        } else {
            gameConfig.shared.deckSize = 50
        }
        self.gameConfig.isClassicMode = isClassicMode
    }
}

struct GameConfig {
    var isClassicMode: Bool
    var shared: SharedParameters
    var classic: ClassicModeParameters
}

// GRAVEYARD CRASH WHEN SAME PERMANENT MULTIPLE TIMES CLICK ON IT

struct SharedParameters {
    var shouldStartWithWeakPermanent: Bool
    var shouldntHaveBoardWipeInFirstQuarter: Bool
    var shouldntHaveBoardWipeAtAll: Bool
    var deckSize: Int
}

struct ClassicModeParameters {
    var shouldSpawnStrongPermanents: Bool
    var spawnStrongPermanentAt25: Bool
    var spawnStrongPermanentAt50: Bool
    var spawnStrongPermanentAt75: Bool
    var spawnStrongPermanentAt100: Bool
}
