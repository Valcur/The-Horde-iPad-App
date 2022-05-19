//
//  HordeApp.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

@main
struct HordeApp: App {
    
    let hordeAppViewModel = HordeAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            HordeAppView()
                .environmentObject(hordeAppViewModel)
        }
    }
}

struct HordeAppView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let gameViewModel = GameViewModel()
    let deckPickerViewModel = DeckPickerViewModel()

    var body: some View {
        ZStack {
            if hordeAppViewModel.readyToPlay {
                GameView()
                    .environmentObject(gameViewModel)
                    .statusBar(hidden: true)
                    .transition(.opacity)
                    .onAppear() {
                        gameViewModel.startGame()
                    }
            } else {
                DeckPickerView()
                    .environmentObject(deckPickerViewModel)
                    .statusBar(hidden: true)
                    .transition(.opacity)
            }
            if hordeAppViewModel.shouldShowMenu {
                MenuView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: hordeAppViewModel.shouldShowMenu)
        .animation(.easeInOut(duration: 0.8), value: hordeAppViewModel.readyToPlay)
    }
}
