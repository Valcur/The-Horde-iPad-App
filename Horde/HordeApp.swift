//
//  HordeApp.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

@main
struct HordeApp: App {
    
    let gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameViewModel)
                .statusBar(hidden: true)
        }
    }
}
