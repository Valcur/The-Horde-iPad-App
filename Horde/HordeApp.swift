//
//  HordeApp.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//


// Icon by Superarticons

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
                    .transition(.slide)
                    .onAppear() {
                        gameViewModel.startGame()
                    }
            } else {
                DeckPickerView()
                    .environmentObject(deckPickerViewModel)
                    .statusBar(hidden: true)
                    .transition(.slide)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: hordeAppViewModel.readyToPlay)
    }
}
