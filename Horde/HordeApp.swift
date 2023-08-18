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
        GeometryReader { _ in
            HordeAppView(hordeVM: hordeAppViewModel)
                .environmentObject(hordeAppViewModel)
        }.ignoresSafeArea()
    }
}

struct HordeAppView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let gameViewModel = GameViewModel()
    let deckPickerViewModel = DeckPickerViewModel()
    let deckEditorViewModel = DeckEditorViewModel()
    @State var deckBrowserVM: DeckBrowserViewModel
    
    init(hordeVM: HordeAppViewModel) {
        deckBrowserVM = DeckBrowserViewModel(hordeVM: hordeVM)
    }

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
            } else if hordeAppViewModel.showDeckBrowser != 0 {
                DeckBrowserView()
                    .environmentObject(deckBrowserVM)
                    .statusBar(hidden: true)
                    .onChange(of: hordeAppViewModel.showDeckEditor) { isShowing in
                        if isShowing {
                            if let selectedDeck = deckBrowserVM.selectedDeck {
                                deckEditorViewModel.iniWithDeckBrowser(deckList: selectedDeck.deckList)
                            }
                        } else {
                            deckEditorViewModel.deckId = -1
                        }
                    }
            } else {
                DeckPickerView()
                    .environmentObject(deckPickerViewModel)
                    .statusBar(hidden: true)
                    .transition(.opacity)
                    .onChange(of: hordeAppViewModel.showDeckEditor) { isShowing in
                        if isShowing {
                            deckEditorViewModel.loadExistingDeck(deckId: deckPickerViewModel.deckPickedId)
                        } else {
                            deckEditorViewModel.deckId = -1
                        }
                    }
            }
            if hordeAppViewModel.showDeckEditor {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    DeckEditorView()
                        .environmentObject(deckEditorViewModel)
                        .statusBar(hidden: true)
                        .transition(.opacity)
                } else {
                    DeckEditorView_iPhone()
                        .environmentObject(deckEditorViewModel)
                        .statusBar(hidden: true)
                        .transition(.opacity)
                }
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
        .onChange(of: hordeAppViewModel.showDeckBrowser) { isShowing in
            if isShowing == 1 {
                deckBrowserVM = DeckBrowserViewModel(hordeVM: hordeAppViewModel)
                deckBrowserVM.iniRecentDecks()
            } else if isShowing == 2 {
                deckBrowserVM = DeckBrowserViewModel(hordeVM: hordeAppViewModel)
                deckBrowserVM.iniTopDecks()
            }
        }
    }
}
