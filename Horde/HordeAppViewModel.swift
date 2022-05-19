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
    
    init() {
        self.readyToPlay = false
        self.shouldShowMenu = false
        self.menuToShowId = 1
        self.difficulty = UserDefaults.standard.object(forKey: "Difficulty") as? Int ?? 1
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
}
