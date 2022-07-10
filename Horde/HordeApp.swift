//
//  HordeApp.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

@main
struct HordeApp: App {
    
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    //let hordeAppViewModel = HordeAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            
        }
    }
}

struct HordeAppNoHomeIndicatorView: View {
    
    let hordeAppViewModel = HordeAppViewModel()
    
    var body: some View {
        HordeAppView()
            .environmentObject(hordeAppViewModel)
    }
}

struct HordeAppView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let gameViewModel = GameViewModel()
    let deckPickerViewModel = DeckPickerViewModel()

    var body: some View {
        ZStack {
            if hordeAppViewModel.readyToPlay {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // It's an iPad (or macOS Catalyst)
                    GameView()
                        .environmentObject(gameViewModel)
                        .statusBar(hidden: true)
                        .transition(.opacity)
                        .onAppear() {
                            gameViewModel.startGame()
                        }
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    // It's an iPhone
                    GameView_iPhone()
                        .environmentObject(gameViewModel)
                        .statusBar(hidden: true)
                        .transition(.opacity)
                        .onAppear() {
                            gameViewModel.startGame()
                        }
                }
            } else {
                DeckPickerView()
                    .environmentObject(deckPickerViewModel)
                    .statusBar(hidden: true)
                    .transition(.opacity)
            }
            if hordeAppViewModel.shouldShowMenu {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // It's an iPad (or macOS Catalyst)
                    MenuView()
                        .transition(.opacity)
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    // It's an iPhone
                    MenuView_iPhone()
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: hordeAppViewModel.shouldShowMenu)
        .animation(.easeInOut(duration: 0.8), value: hordeAppViewModel.readyToPlay)
    }
}
