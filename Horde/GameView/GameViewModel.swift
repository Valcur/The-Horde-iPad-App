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
    var tokensAvailable: [Card] = []
    var lateGameCards: [Card] = []
    var weakCards: [Card] = []
    var powerfullCards: [Card] = []
    var marathonStage = -1
    var strongPermanentsAlreadySpawned: [Bool]
    @Published var strongPermanentsToSpawn: [Card] = []
    @Published var shouldShowStrongPermanent: Bool = false
    
    @Published var cardToZoomIn = Card.emptyCard()
    @Published var shouldZoomOnCard: Bool = false
    
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
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImageURL: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")
        
        turnStep = -1
        marathonStage = -1
        
        gameConfig = GameConfig(isClassicMode: true, shared: SharedParameters(shouldStartWithWeakPermanent: false, shouldntHaveStrongCardsInFirstQuarter: true, deckSize: 100), classic: ClassicModeParameters(shouldSpawnStrongPermanents: false, spawnStrongPermanentAt25: false, spawnStrongPermanentAt50: true, spawnStrongPermanentAt75: false, spawnStrongPermanentAt100: false))
        
        strongPermanentsAlreadySpawned = [false, false, false, false]
        
        setupDeck(deckPickedId: 1)
    }
    
    func startGame() {
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImageURL: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")
        
        setupDeck(deckPickedId: deckPickedId)
        
        cardsOnBoard = []
        cardsOnGraveyard = []
        
        gameConfig.shared.deckSize = 100
        turnStep = -1
        marathonStage = -1
        showLibraryTopCard = false
        damageTakenThisTurn = 0
        
        strongPermanentsAlreadySpawned = [false, false, false, false]
        
        print("All good")
    }
    
    func setupDeck(deckPickedId: Int) {
        setupDeck(deckPickedId: deckPickedId, tokenMultiplicator: UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1)
    }
    
    func setupDeck(deckPickedId: Int, tokenMultiplicator: Int) {
        let deckList = DeckManager.getDeckForId(deckPickedId: deckPickedId, difficulty: tokenMultiplicator)
        self.deck = deckList.0
        self.tokensAvailable = deckList.1
        self.lateGameCards = deckList.2
        self.weakCards = deckList.3
        self.powerfullCards = deckList.4
        print("Game initiating with deck \(deckPickedId)")
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
            setupDeck(deckPickedId: deckPickedId, tokenMultiplicator: withDifficulty)
        } else {
            setupDeck(deckPickedId: deckPickedId)
        }
        
        // Reduce or increase library size
        if gameConfig.shared.deckSize <= 100 {
            let cardsToKeep = Int(Double(deck.count) * (Double(gameConfig.shared.deckSize) / 100.0))
            deck.removeSubrange(0..<(deck.count - cardsToKeep))
            deckSizeAtStart = deck.count
        } else {
            if gameConfig.shared.deckSize == 200 {
                self.deck = deck + deck
            } else if gameConfig.shared.deckSize == 300 {
                self.deck = deck + deck + deck
            }
            
            self.deck.shuffle()
        }

        // No boardwipe in first quarter & no strong cards
        if (gameConfig.shared.shouldntHaveStrongCardsInFirstQuarter) && marathonStage <= 0 {
            
            let difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
            let sizeAndnbrOfTokens = getSafeZoneCardCountAndAverageTokens(difficulty: difficulty)
            let quarter = sizeAndnbrOfTokens.0
            let averageNumberOfTokens = sizeAndnbrOfTokens.1
            
            var nbrOfTokens = 0
            
            var n = 0
            
            // For each card in safe zone if too strong, switch it with a random not strong card from the non safe zone
            repeat {
                nbrOfTokens = 0
                deck.shuffle()
                for i in 1..<quarter {
                    
                    if isCardAStrongCard(card: deck[deck.count - i], cardsToCheck: powerfullCards) {
                        var cardIdToSwitchWith: Int
                        repeat {
                            cardIdToSwitchWith = Int.random(in: 0..<deck.count - quarter)
                            let cardTmp = deck[deck.count - i]
                            deck[deck.count - i] = deck[cardIdToSwitchWith]
                            deck[cardIdToSwitchWith] = cardTmp
                        } while isCardAStrongCard(card: deck[deck.count - i], cardsToCheck: powerfullCards)
                    }
                    
                    if deck[deck.count - i].cardType == .token {
                        nbrOfTokens += 1
                    }
                }
                print("loop \(n) + in \(quarter) max \(averageNumberOfTokens) has \(nbrOfTokens) tokens ")
                n += 1
            } while nbrOfTokens >= averageNumberOfTokens && n < 100
            
            // Can't suffle without no strong cards wich means too many strong cards -> wouldn't be fun -> let's get a new deck
            if n >= 100 {
                setupHorde(withDifficulty: withDifficulty)
                return
            }
        }
        
        // Spawn start enchantment if deck has any
        if gameConfig.shared.shouldStartWithWeakPermanent {
            let weakCard: Card? = weakCards.randomElement()
            if weakCard != nil {
                addCardToBoard(card: weakCard!)
            }
        }
    }
    
    func isCardAStrongCard(card: Card, cardsToCheck: [Card]) -> Bool {
        for strongCard in cardsToCheck {
            if card == strongCard {
                return true
            }
        }
        return false
    }
    
    // Number of cards at the begining that shouldn't have strong cards in it
    func getSafeZoneCardCountAndAverageTokens(difficulty: Int) -> (Int, Int) {
        var n = 6 // Number of real cards you wan to draw on average before storng cards come
        
        if gameConfig.shared.deckSize == 75 {
            n = 5
        } else if gameConfig.shared.deckSize == 50 {
            n = 4
        } else if gameConfig.shared.deckSize == 25 {
            n = 3
        }
    
        let averageNbrOfToken: Int = Int((Double(n * difficulty) * 1.5).rounded())
        return (n + averageNbrOfToken, averageNbrOfToken + (difficulty <= 2 ? 1 : 2))
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
            let tmpCard = card.recreateCard()
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
    
    func spawnStrongPermanentIfNeeded() {
        if gameConfig.classic.shouldSpawnStrongPermanents {
            if gameConfig.classic.spawnStrongPermanentAt25 == true && !strongPermanentsAlreadySpawned[0] && deck.count == deckSizeAtStart - deckSizeAtStart / 4 {
                let strongCard: Card? = powerfullCards.randomElement()
                if strongCard != nil {
                    addCardToBoard(card: strongCard!)
                    shouldShowStrongPermanent = true
                    strongPermanentsToSpawn.append(strongCard!)
                }
                strongPermanentsAlreadySpawned[0] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt50 == true && !strongPermanentsAlreadySpawned[1] && deck.count == deckSizeAtStart / 2 {
                let strongCard: Card? = powerfullCards.randomElement()
                if strongCard != nil {
                    addCardToBoard(card: strongCard!)
                    shouldShowStrongPermanent = true
                    strongPermanentsToSpawn.append(strongCard!)
                }
                strongPermanentsAlreadySpawned[1] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt75 == true && !strongPermanentsAlreadySpawned[2] && deck.count == deckSizeAtStart / 4 {
                let strongCard: Card? = powerfullCards.randomElement()
                if strongCard != nil {
                    addCardToBoard(card: strongCard!)
                    shouldShowStrongPermanent = true
                    strongPermanentsToSpawn.append(strongCard!)
                }
                strongPermanentsAlreadySpawned[2] = true
            }
            if gameConfig.classic.spawnStrongPermanentAt100 == true && !strongPermanentsAlreadySpawned[3] && deck.count == 0 {
                let strongCard: Card? = powerfullCards.randomElement()
                if strongCard != nil {
                    addCardToBoard(card: strongCard!)
                    shouldShowStrongPermanent = true
                    strongPermanentsToSpawn.append(strongCard!)
                }
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
            let strongCard: Card? = powerfullCards.randomElement()
            if strongCard != nil {
                addCardToBoard(card: strongCard!)
                shouldShowStrongPermanent = true
                strongPermanentsToSpawn.append(strongCard!)
            }
        }
        // Second Stage, 150 cards with tokens x3
        // Spawn second boss
        else if atStage == 2 {
            var strongCard: Card? = powerfullCards.randomElement()
            if strongCard != nil {
                addCardToBoard(card: strongCard!)
                shouldShowStrongPermanent = true
                strongPermanentsToSpawn.append(strongCard!)
            }
            strongCard = powerfullCards.randomElement()
            if strongCard != nil {
                addCardToBoard(card: strongCard!)
                shouldShowStrongPermanent = true
                strongPermanentsToSpawn.append(strongCard!)
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
        if token.cardType != .instant && token.cardType != .sorcery {
            cardsOnBoard.append(token.recreateCard())
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
        } else {
            sendToGraveyard(card: token)
        }
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

struct SharedParameters {
    var shouldStartWithWeakPermanent: Bool
    var shouldntHaveStrongCardsInFirstQuarter: Bool
    var deckSize: Int
}

struct ClassicModeParameters {
    var shouldSpawnStrongPermanents: Bool
    var spawnStrongPermanentAt25: Bool
    var spawnStrongPermanentAt50: Bool
    var spawnStrongPermanentAt75: Bool
    var spawnStrongPermanentAt100: Bool
}
