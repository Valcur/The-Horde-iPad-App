//
//  HordeAppViewModel.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import Foundation

class HordeAppViewModel: ObservableObject {
    @Published var readyToPlay: Bool
    @Published var shouldShowMenu: Bool
    @Published var showDeckEditor: Bool
    @Published var menuToShowId: Int
    @Published var difficulty: Int
    @Published var gradientId: Int
    @Published var useLessColorFullBackground: Bool
    @Published var oneRowBoardInsteadOfTwo: Bool
    @Published var useLifepointsCounter: Bool
    @Published var hordeGainLifeLostBySurvivor: Bool
    @Published var survivorStartingLife: Int
    @Published var numberOfDeckSlot: Int
    @Published var isPremium = false
    
    init() {
        self.readyToPlay = false
        self.shouldShowMenu = false
        self.showDeckEditor = false
        self.menuToShowId = 1
        self.difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
        self.gradientId = UserDefaults.standard.object(forKey: "GradientId") as? Int ?? 1
        self.useLessColorFullBackground = UserDefaults.standard.object(forKey: "UseLessColorFullBackground") as? Bool ?? false
        self.oneRowBoardInsteadOfTwo = UserDefaults.standard.object(forKey: "OneRowBoardInsteadOfTwo") as? Bool ?? true
        self.useLifepointsCounter = UserDefaults.standard.object(forKey: "UseLifePointsCounter") as? Bool ?? true
        self.hordeGainLifeLostBySurvivor = UserDefaults.standard.object(forKey: "HordeGainLifeLostBySurvivor") as? Bool ?? true
        self.survivorStartingLife = UserDefaults.standard.object(forKey: "SurvivorStartingLife") as? Int ?? 60
        self.numberOfDeckSlot = 8
        
        IAPManager.shared.startWith(arrayOfIds: [IAPManager.getSubscriptionId()], sharedSecret: IAPManager.getSharedSecret())
        IAPManager.shared.refreshSubscriptionsStatus(callback: {
            let date = UserDefaults.standard.object(forKey: IAPManager.getSubscriptionId()) as? Date ?? Date()
            if date > Date() {
                print("IS PREMIUM UNTIL \(date)")
                self.isPremium = true
                var testNbrOfDeckSlot = UserDefaults.standard.object(forKey: "NumberOfDeckSlot") as? Int ?? 8
                if testNbrOfDeckSlot == 8 && (UserDefaults.standard.object(forKey: "Deck_\(7)_Exist") as? Bool ?? false) == true {
                    testNbrOfDeckSlot += 1
                    UserDefaults.standard.set(testNbrOfDeckSlot, forKey: "NumberOfDeckSlot")
                }
                self.numberOfDeckSlot = testNbrOfDeckSlot
            } else {
                print("IS NOT PREMIUM SINCE \(date)")
                self.isPremium = false
                UserDefaults.standard.set(false, forKey: "IsPremium")
                self.lostPremiumSubscription()
            }
        }, failure: { error in
            print("Error \(String(describing: error))")
        })
    }
    
    func lostPremiumSubscription() {
        self.numberOfDeckSlot = 8
        // Delete starting deck
        var backUpDeckList: [String] = []
        for i in 0..<7 {
            backUpDeckList.append(UserDefaults.standard.object(forKey: "Deck_\(i)") as? String ?? "")
            UserDefaults.standard.set(false, forKey: "Deck_\(i)_Exist")
        }
        // Recreate them
        DeckManager.createStarterDecks()
        
        // Restore changes made by the user to the decklist
        for i in 0..<7 {
            UserDefaults.standard.set(backUpDeckList[i], forKey: "Deck_\(i)")
        }
    }
    
    func createDeck(deckId: Int) {
        if isPremium {
            if deckId + 1 == self.numberOfDeckSlot {
                self.numberOfDeckSlot += 1
                UserDefaults.standard.set(self.numberOfDeckSlot, forKey: "NumberOfDeckSlot")
            }
        }
    }
    
    func deleteDeck() {
        if isPremium {
            var deckId = (UserDefaults.standard.object(forKey: "NumberOfDeckSlot") as? Int ?? 8) - 2
            
            while !(UserDefaults.standard.object(forKey: "Deck_\(deckId)_Exist") as? Bool ?? false) {
                self.numberOfDeckSlot -= 1
                UserDefaults.standard.set(self.numberOfDeckSlot, forKey: "NumberOfDeckSlot")
                deckId -= 1
            }
        }
    }
    
    func setDifficulty(newDifficulty: Int) {
        difficulty = newDifficulty
        UserDefaults.standard.set(newDifficulty, forKey: "Difficulty")
    }
    
    func showMenu() {
        shouldShowMenu = true
    }
    
    func hideMenu() {
        shouldShowMenu = false
    }
    
    func setBackgroundColorGradientTo(gradientId: Int) {
        self.gradientId = gradientId
        UserDefaults.standard.set(gradientId, forKey: "GradientId")
    }
    
    func saveBackgroundColorPreference() {
        UserDefaults.standard.set(self.useLessColorFullBackground, forKey: "UseLessColorFullBackground")
    }
    
    func saveBattlefieldRowStylePreference() {
        UserDefaults.standard.set(self.oneRowBoardInsteadOfTwo, forKey: "OneRowBoardInsteadOfTwo")
    }
    
    func saveUserLifepointsCounterPreference() {
        UserDefaults.standard.set(self.useLifepointsCounter, forKey: "UseLifePointsCounter")
        UserDefaults.standard.set(self.hordeGainLifeLostBySurvivor, forKey: "HordeGainLifeLostBySurvivor")
        UserDefaults.standard.set(self.survivorStartingLife, forKey: "SurvivorStartingLife")
    }
    
    func buy() {
        if IAPManager.shared.products != nil && IAPManager.shared.products!.first != nil {
            IAPManager.shared.purchaseProduct(product: IAPManager.shared.products!.first!, success: {
                if UserDefaults.standard.object(forKey: "IsPremium") as? Bool ?? false {
                    self.isPremium = true
                    var testNbrOfDeckSlot = UserDefaults.standard.object(forKey: "NumberOfDeckSlot") as? Int ?? 8
                    if testNbrOfDeckSlot == 8 && (UserDefaults.standard.object(forKey: "Deck_\(7)_Exist") as? Bool ?? false) == true {
                        testNbrOfDeckSlot += 1
                        UserDefaults.standard.set(testNbrOfDeckSlot, forKey: "NumberOfDeckSlot")
                    }
                    self.numberOfDeckSlot = testNbrOfDeckSlot
                }
            }, failure: { error in
                print("Buy Fail \(String(describing: error))")
            })
        }
    }
    
    func restore() {
        if IAPManager.shared.products != nil && IAPManager.shared.products!.first != nil {
            IAPManager.shared.restorePurchases(success: {
                if UserDefaults.standard.object(forKey: "IsPremium") as? Bool ?? false {
                    self.isPremium = true
                    var testNbrOfDeckSlot = UserDefaults.standard.object(forKey: "NumberOfDeckSlot") as? Int ?? 8
                    if testNbrOfDeckSlot == 8 && (UserDefaults.standard.object(forKey: "Deck_\(7)_Exist") as? Bool ?? false) == true {
                        testNbrOfDeckSlot += 1
                        UserDefaults.standard.set(testNbrOfDeckSlot, forKey: "NumberOfDeckSlot")
                    }
                    self.numberOfDeckSlot = testNbrOfDeckSlot
                }
            }, failure: { error in
                print("Restore Fail \(String(describing: error))")
            })
        }
    }
}

