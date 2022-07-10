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
    @Published var menuToShowId: Int
    @Published var difficulty: Int
    @Published var gradientId: Int
    @Published var oneRowBoardInsteadOfTwo: Bool
    
    init() {
        self.readyToPlay = false
        self.shouldShowMenu = false
        self.menuToShowId = 1
        self.difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
        self.gradientId = UserDefaults.standard.object(forKey: "GradientId") as? Int ?? 1
        self.oneRowBoardInsteadOfTwo = UserDefaults.standard.object(forKey: "OneRowBoardInsteadOfTwo") as? Bool ?? true
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
    
    func saveBattlefieldRowStylePreference() {
        UserDefaults.standard.set(self.oneRowBoardInsteadOfTwo, forKey: "OneRowBoardInsteadOfTwo")
    }
}
