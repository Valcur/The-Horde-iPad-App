//
//  GameViewModel.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published var turnStep: Int = -1
    @Published var cardsToCast: CardsToCast
    @Published var cardsOnBoard: [Card] = []
    @Published var cardsOnGraveyard: [Card] = []
    @Published var deck: [Card] = []
    @Published var hand: [Card] = []
    
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
    
    @Published var addCountersModeEnable: Bool = false
    @Published var removeCountersModeEnable: Bool = false
    @Published var returnToHandModeEnable: Bool = false
    
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
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardsFromHand: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImageURL: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")
        
        turnStep = -1
        marathonStage = -1
        
        gameConfig = GameConfig(isClassicMode: true, shared: SharedParameters(shouldStartWithWeakPermanent: false, shouldntHaveStrongCardsInFirstQuarter: true, deckSize: 100, tokensAreRealCards: true), classic: ClassicModeParameters(shouldSpawnStrongPermanents: false, spawnStrongPermanentAt25: false, spawnStrongPermanentAt50: true, spawnStrongPermanentAt75: false, spawnStrongPermanentAt100: false))
        
        strongPermanentsAlreadySpawned = [false, false, false, false]
        
        setupDeck(deckPickedId: 1)
    }
    
    func startGame() {
        cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardsFromHand: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImageURL: ""))
        
        deckPickedId = UserDefaults.standard.object(forKey: "DeckPickedId") as? Int ?? 0
        print("Game initiating with deck \(deckPickedId)")
        
        setupDeck(deckPickedId: deckPickedId)
        
        cardsOnBoard = []
        cardsOnGraveyard = []
        hand = []
        
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
            hand = regroupSameCardInArray(cardArray: hand)
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
            
            for card in cardsToCast.cardsFromHand {
                castCard(card: card)
            }

            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
        }
        
        showLibraryTopCard = false
        resetModes()
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

        // No strong cards in first quarter
        if (gameConfig.shared.shouldntHaveStrongCardsInFirstQuarter) && marathonStage <= 0 {
            
            let difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
            let sizeAndnbrOfTokens = getSafeZoneCardCountAndAverageTokens(difficulty: difficulty)
            let quarter = sizeAndnbrOfTokens.0
            let averageNumberOfTokens = sizeAndnbrOfTokens.1
            let minNumberOfTokens = averageNumberOfTokens - averageNumberOfTokens / 5
            
            var nbrOfTokens = 0
            
            var n = 0
            
            // For each card in safe zone if too strong, switch it with a random not strong card from the non safe zone
            repeat {
                nbrOfTokens = 0
                deck.shuffle()
                for i in 1..<quarter {
                    
                    if isCardAStrongCard(card: deck[deck.count - i], cardsToCheck: lateGameCards) {
                        var cardIdToSwitchWith: Int
                        repeat {
                            cardIdToSwitchWith = Int.random(in: 0..<deck.count - quarter)
                            let cardTmp = deck[deck.count - i]
                            deck[deck.count - i] = deck[cardIdToSwitchWith]
                            deck[cardIdToSwitchWith] = cardTmp
                        } while isCardAStrongCard(card: deck[deck.count - i], cardsToCheck: lateGameCards)
                    }
                    
                    if deck[deck.count - i].cardType == .token {
                        nbrOfTokens += 1
                    }
                }
                print("loop \(n) + in \(quarter) max \(averageNumberOfTokens) min \(minNumberOfTokens) has \(nbrOfTokens) tokens ")
                n += 1
            } while (nbrOfTokens >= averageNumberOfTokens || nbrOfTokens <= minNumberOfTokens) && n < 100 && averageNumberOfTokens > quarter / 8
            
            // Can't suffle without no strong cards wich means too many strong cards -> wouldn't be fun -> let's get a new deck
            if n >= 100 {
                setupHorde(withDifficulty: withDifficulty)
                return
            } else if averageNumberOfTokens > quarter / 8 {
                // Once safeZone has the good amount of cards, space them to make interesting rounds
                let maxNumberOfTokensInARow = Int(ceil(Double(quarter) / Double(averageNumberOfTokens) + 1.0))
                var currentNumberOfTokensInARow = 0
                var previousCardWasAlreadyNonToken = true
                
                for i in 1..<quarter {
                    if deck[deck.count - i].cardType == .token {
                        currentNumberOfTokensInARow += 1
                        if currentNumberOfTokensInARow > maxNumberOfTokensInARow {
                            currentNumberOfTokensInARow = 0
                            
                            var j = i + 1
                            while j < quarter - 1 && deck[deck.count - i].cardType == .token {
                                if deck[deck.count - j].cardType != .token {
                                    let tmp = deck[deck.count - i].recreateCard()
                                    deck[deck.count - i] = deck[deck.count - j].recreateCard()
                                    deck[deck.count - j] = tmp
                                }
                                j += 1
                            }
                            if j == quarter - 2 {
                                print("fail finding non token")
                            }
                        }
                    } else {
                        if previousCardWasAlreadyNonToken {
                            previousCardWasAlreadyNonToken = false
                            
                            var j = i + 1
                            while j < quarter - 1 && deck[deck.count - i].cardType != .token {
                                if deck[deck.count - j].cardType == .token {
                                    let tmp = deck[deck.count - i].recreateCard()
                                    deck[deck.count - i] = deck[deck.count - j].recreateCard()
                                    deck[deck.count - j] = tmp
                                }
                                j += 1
                            }
                            if j == quarter - 2 {
                                print("fail finding token")
                            }
                        } else {
                            previousCardWasAlreadyNonToken = true
                        }
                    }
                }
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
        let safeZoneSize: Int = Int((25.0 * Double(deck.count) / 100.0).rounded(.up))
        
        // We count the number of tokens and spells
        var nbrOfSpells = 0
        var nbrOfTokens = 0
        for card in deck {
            if card.cardType == .token {
                nbrOfTokens += 1
            } else {
                nbrOfSpells += 1
            }
        }
        
        let tokensRatioInDeck: Double = Double(nbrOfTokens) / Double(deck.count)
        let averageNbrOfToken: Int = Int(Double(safeZoneSize) * tokensRatioInDeck)
        let n: Int = safeZoneSize - averageNbrOfToken // Number of real cards you want to draw on average before storng cards come
        
        print("For a deck size of \(deck.count) with diff : \(difficulty) - deckSize : \(gameConfig.shared.deckSize) we have safe zone of \(safeZoneSize), n = \(n), nbrOfTokens = \(averageNbrOfToken)")
        return (safeZoneSize, averageNbrOfToken + (difficulty <= 2 ? 1 : 2))
    }
    
    func drawUntilNonToken() -> CardsToCast {
        
        var cardRevealed: Card
        var tokensRevealed: [Card] = []
        let cardsFromHand: [Card] = regroupSameCardInArray(cardArray: hand)
        hand = []
        
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
        
        return CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: tokensRevealed, cardsFromHand: cardsFromHand, cardFromLibrary: cardRevealed)
    }
    
    func regroupSameCardInArray(cardArray: [Card]) -> [Card] {
        var tmpArray = cardArray
        var i = 0
        while i < tmpArray.count {
            var j = i + 1
            while j < tmpArray.count {
                if tmpArray[i] == tmpArray[j]  && tmpArray[i].countersOnCard == 0 && tmpArray[j].countersOnCard == 0 {
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
        if card.cardType != .token || gameConfig.shared.tokensAreRealCards {
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
            strongCard = weakCards.randomElement()
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
            if tmpArray[i] == card  && tmpArray[i].countersOnCard == card.countersOnCard {
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
    
    func exileOneCardOnBoard(card: Card) {
        var tmpArray = cardsOnBoard
        for i in 0..<tmpArray.count {
            if tmpArray[i] == card  && tmpArray[i].countersOnCard == card.countersOnCard {
                card.cardCount -= 1
                if card.cardCount <= 0 {
                    tmpArray.remove(at: i)
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
                for _ in 0..<tmpCard.cardCount {
                    sendToGraveyard(card: tmpCard)
                }
                i -= 1
            }
            i += 1
        }
    }
    
    func resetModes(addCountersModeEnable: Bool = false, removeCountersModeEnable: Bool = false, returnToHandModeEnable: Bool = false) {
        self.addCountersModeEnable = addCountersModeEnable
        self.removeCountersModeEnable = removeCountersModeEnable
        self.returnToHandModeEnable = returnToHandModeEnable
    }
    
    func toggleAddCounters() {
        addCountersModeEnable.toggle()
        resetModes(addCountersModeEnable: addCountersModeEnable)
    }
    
    func toggleRemoveCounters() {
        removeCountersModeEnable.toggle()
        resetModes(removeCountersModeEnable: removeCountersModeEnable)
    }
    
    func toggleReturnToHand() {
        returnToHandModeEnable.toggle()
        resetModes(returnToHandModeEnable: returnToHandModeEnable)
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
    
    func castCard(card: Card) {
        if card.cardType == .token || card.cardType == .creature || card.cardType == .enchantment || card.cardType == .artifact {
            addCardToBoard(card: card)
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
        } else {
            cardsOnGraveyard.append(card)
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
            if card.cardType != .token || gameConfig.shared.tokensAreRealCards {
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
        guard deck.count > 0 else { return }
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
    
    func addCountersToCardOnBoard(card: Card) {
        if card.cardCount > 1 {
            let tmpCard = card.recreateCard()
            tmpCard.cardCount = card.cardCount - 1
            card.cardCount = 1
            card.countersOnCard += 1
            var cardIndexOnBoard = 0
            for i in 0..<cardsOnBoard.count {
                if cardsOnBoard[i] == card {
                    cardIndexOnBoard = i
                }
            }
            cardsOnBoard.insert(tmpCard, at: cardIndexOnBoard + 1)
        } else {
            card.countersOnCard += 1
        }
        
        cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
    }
    
    func removeCountersFromCardOnBoard(card: Card) {
        if card.countersOnCard > 0 {
            card.countersOnCard -= 1
        }
        cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
    }
    
    func drawOneCard() {
        if deck.count > 0 {
            let card = deck.last!
            showLibraryTopCard = false
            hand.append(card)
            deck.removeLast()
        }
    }
    
    func playHand() {
        if hand.count > 0 {
            hand = regroupSameCardInArray(cardArray: hand)
            let empty: [Card] = []
            cardsToCast = CardsToCast(cardsFromGraveyard: empty, tokensFromLibrary: empty, cardsFromHand: hand, cardFromLibrary: Card.emptyCard())
            turnStep = 1
            hand = []
        }
    }
    
    func returnToHandFromBoard(card: Card) {
        exileOneCardOnBoard(card: card)
        
        if card.cardType != .token || gameConfig.shared.tokensAreRealCards {
            let tmpCard = card.recreateCard()
            tmpCard.cardCount = 1
            withAnimation(.easeInOut(duration: 0.5)) {
                hand.append(tmpCard)
            }
        } else {
            cardsOnBoard = regroupSameCardInArray(cardArray: cardsOnBoard)
        }
    }
    
    func discardACardAtRandom() {
        if hand.count > 0 {
            let card = hand.remove(at: Int.random(in: 0..<hand.count))
            if card.cardType != .token || gameConfig.shared.tokensAreRealCards {
                cardsOnGraveyard.append(card)
            }
        }
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
    var tokensAreRealCards: Bool
}

struct ClassicModeParameters {
    var shouldSpawnStrongPermanents: Bool
    var spawnStrongPermanentAt25: Bool
    var spawnStrongPermanentAt50: Bool
    var spawnStrongPermanentAt75: Bool
    var spawnStrongPermanentAt100: Bool
}
