//
//  GameIntroView.swift
//  Horde
//
//  Created by Loic D on 30/05/2022.
//

import SwiftUI

struct GameIntroView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var isDeckBeingGenerated: Bool = false
    
    var body: some View {
        // The button to leave the menu is the background
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
            
            VStack(spacing: 50) {
                IntroSetupView(isDeckBeingGenerated: $isDeckBeingGenerated)
            }.transition(AnyTransition.slide)
        }.ignoresSafeArea().frame(width: UIScreen.main.bounds.width)
    }
}

struct IntroSetupView: View {
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var gameViewModel: GameViewModel
    @Binding var isDeckBeingGenerated: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color("DarkGray")
                HStack(spacing: 100) {
                    Spacer()
                    GameModeSwitchButtonView(title: "Classic", setModeToClassic: true)
                    GameModeSwitchButtonView(title: "Marathon", setModeToClassic: false)
                    Spacer()
                }
            }.frame(height: UIDevice.isIPhone ? 40 : 70)
            
            ScrollView(.vertical) {
                VStack(spacing: 40) {
                    if isDeckBeingGenerated {
                        MenuTextBoldParagraphView(text: "Generating deck, please wait ...")
                    } else if gameViewModel.turnStep == -1 {
                        Button(action: {
                            print("Start game button pressed")
                            isDeckBeingGenerated = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                gameViewModel.nextButtonPressed()
                                isDeckBeingGenerated = false
                            }
                        }, label: {
                            PurpleButtonLabel(text: "Touch to continue", isPrimary: true, noMaxWidth: true)
                        })
                    }
                    HStack(alignment: .top, spacing: 50) {
                        VStack(spacing: 30) {
                            
                            MenuTextSubtitleView(text: "Token multiplicator")
                            
                            MenuTextParagraphView(text: "Increase the amount of tokens to make the horde reveal more cards each times")
                            
                            HStack(spacing: 20) {
                                IntroDifficultyChoiceButtonView(multiplicator: 1)
                                IntroDifficultyChoiceButtonView(multiplicator: 2)
                                IntroDifficultyChoiceButtonView(multiplicator: 3)
                                IntroDifficultyChoiceButtonView(multiplicator: 4)
                            }
                            
                            MenuTextSubtitleView(text: "Deck Size")
                            
                            MenuTextParagraphView(text: "Reduce the library size for small group of players, or increase it's size to make the game longer")
                            
                            HStack(spacing: UIDevice.isIPhone ? 5 : 20) {
                                IntroPlayerChoiceButtonView(percent: 25)
                                IntroPlayerChoiceButtonView(percent: 50)
                                IntroPlayerChoiceButtonView(percent: 75)
                                IntroPlayerChoiceButtonView(percent: 100)
                                IntroPlayerChoiceButtonView(percent: 200)
                                IntroPlayerChoiceButtonView(percent: 300)
                            }
                            
                            Group {
                                MenuTextSubtitleView(text: "Life counter")
                                
                                Toggle("Show life counter", isOn: $hordeAppViewModel.useLifepointsCounter)
                                    .foregroundColor(.white)
                                
                                Toggle("The Horde heals when survivors lose life", isOn: $hordeAppViewModel.hordeGainLifeLostBySurvivor)
                                    .foregroundColor(.white)
                                
                                MenuTextParagraphView(text: "Survivors starting life")
                                
                                HStack(spacing: 20) {
                                    // Start with 20
                                    Button(action: {
                                        hordeAppViewModel.survivorStartingLife = 20
                                        hordeAppViewModel.saveUserLifepointsCounterPreference()
                                    }, label: {
                                        Text("20")
                                            .foregroundColor(hordeAppViewModel.survivorStartingLife == 20 ? .white : .gray)
                                            .fontWeight(.bold)
                                            .font(UIDevice.isIPhone ? .title3 : .title2)
                                    })
                                    
                                    // Start with 40
                                    Button(action: {
                                        hordeAppViewModel.survivorStartingLife = 40
                                        hordeAppViewModel.saveUserLifepointsCounterPreference()
                                    }, label: {
                                        Text("40")
                                            .foregroundColor(hordeAppViewModel.survivorStartingLife == 40 ? .white : .gray)
                                            .fontWeight(.bold)
                                            .font(UIDevice.isIPhone ? .title3 : .title2)
                                    })
                                    
                                    // Start with 60
                                    Button(action: {
                                        hordeAppViewModel.survivorStartingLife = 60
                                        hordeAppViewModel.saveUserLifepointsCounterPreference()
                                    }, label: {
                                        Text("60")
                                            .foregroundColor(hordeAppViewModel.survivorStartingLife == 60 ? .white : .gray)
                                            .fontWeight(.bold)
                                            .font(UIDevice.isIPhone ? .title3 : .title2)
                                    })
                                    
                                    // Start with 80
                                    Button(action: {
                                        hordeAppViewModel.survivorStartingLife = 80
                                        hordeAppViewModel.saveUserLifepointsCounterPreference()
                                    }, label: {
                                        Text("80")
                                            .foregroundColor(hordeAppViewModel.survivorStartingLife == 80 ? .white : .gray)
                                            .fontWeight(.bold)
                                            .font(UIDevice.isIPhone ? .title3 : .title2)
                                    })
                                }
                            }
                        }
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 2)
                            .padding([.top, .bottom], 70)
                        
                        VStack(spacing: 30) {
                            
                            MenuTextSubtitleView(text: "Options")
                            
                            if gameViewModel.gameConfig.isClassicMode {
                                VStack(spacing: 15)  {
                                    Toggle("Spawn a random powerfull permanent (different for every deck) when reaching milestone", isOn: $gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents)
                                        .foregroundColor(.white)
                                    
                                    if gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents {
                                        HStack(spacing: 20) {
                                            // Spawn at 25
                                            Button(action: {
                                                gameViewModel.gameConfig.classic.spawnStrongPermanentAt25.toggle()
                                            }, label: {
                                                Text("25%")
                                                    .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt25 ? .white : .gray)
                                                    .fontWeight(.bold)
                                                    .font(.title2)
                                            })
                                            
                                            // Spawn at 50
                                            Button(action: {
                                                gameViewModel.gameConfig.classic.spawnStrongPermanentAt50.toggle()
                                            }, label: {
                                                Text("50%")
                                                    .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt50 ? .white : .gray)
                                                    .fontWeight(.bold)
                                                    .font(.title2)
                                            })
                                            
                                            // Spawn at 75
                                            Button(action: {
                                                gameViewModel.gameConfig.classic.spawnStrongPermanentAt75.toggle()
                                            }, label: {
                                                Text("75%")
                                                    .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt75 ? .white : .gray)
                                                    .fontWeight(.bold)
                                                    .font(.title2)
                                            })
                                            
                                            // Spawn at 100
                                            Button(action: {
                                                gameViewModel.gameConfig.classic.spawnStrongPermanentAt100.toggle()
                                            }, label: {
                                                Text("100%")
                                                    .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt100 ? .white : .gray)
                                                    .fontWeight(.bold)
                                                    .font(.title2)
                                            })
                                        }
                                    }
                                }
                            }
                            
                            Toggle("Distribute tokens evenly and remove strong cards during the first turns", isOn: $gameViewModel.gameConfig.shared.shouldntHaveStrongCardsInFirstQuarter)
                                .foregroundColor(.white)
                            
                            Toggle("Tokens are sent to the graveyard and returned to hand", isOn: $gameViewModel.gameConfig.shared.tokensAreRealCards)
                                .foregroundColor(.white)
                            
                            Toggle("Horde starts with a random permanent instead of all (only enable this if the deck ask you to)", isOn: $gameViewModel.gameConfig.shared.shouldStartWithWeakPermanent)
                                .foregroundColor(.white)
                            
                            Toggle("Alternative draw mode : draw a fixed number of cards each turn", isOn: $gameViewModel.gameConfig.shared.useAlternativeDrawMode)
                                .foregroundColor(.white)
                        }
                    }
                }.padding(.top, 40).padding([.leading, .trailing], UIDevice.isIPhone ? 10 : 40).padding(.bottom, 60).scaleEffect(UIDevice.isIPhone ? 0.9 : 1, anchor: .top)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: gameViewModel.gameConfig.isClassicMode)
        .animation(.easeInOut(duration: 0.3), value: gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents)
    }
}

struct GameModeSwitchButtonView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let title: String
    let setModeToClassic: Bool
    var isSelected: Bool {
        return gameViewModel.gameConfig.isClassicMode == setModeToClassic
    }
    
    var body: some View {
        Button(action: {
            print("Set mode to \(title)")
            gameViewModel.changeGameMode(isClassicMode: setModeToClassic)
        }, label: {
            VStack {
                Spacer()
                Text(title)
                    .foregroundColor(isSelected ? .white : .gray)
                    .fontWeight(.bold)
                    .font(UIDevice.isIPhone ? .title2 : .title)
                    .padding(.bottom, 5)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isSelected ? .white : Color("DarkGray"))
            }
        }).animation(.easeInOut(duration: 0.3), value: gameViewModel.gameConfig.isClassicMode)
    }
}

struct IntroBeforeGameStartView: View {
    var body: some View {
        MenuTextSubtitleView(text: "Lifepoints")
        
        MenuTextParagraphView(text: "The horde start with 20 life points and only mills its library when his lifepoints are equal to 0. Each time a permanent or an ability controlled by the horde deals damage to the survivors, the Horde gains that much life.")
            .frame(width: UIScreen.main.bounds.width - 80)
        
        MenuTextSubtitleView(text: "Recommanded horde draw per turn")
            .frame(width: UIScreen.main.bounds.width)
        
        HStack(spacing: 75) {
            HStack(spacing: 25) {
                MenuTextParagraphView(text: "1-2 players")
                MenuTextBoldParagraphView(text: "1 card")
            }
            
            HStack(spacing: 25) {
                MenuTextParagraphView(text: "3-4 players")
                MenuTextBoldParagraphView(text: "2 cards")
            }
        }
        
        MenuTextTitleView(text: "Play 3 turns then touch anywhere to start")
    }
}

struct IntroDifficultyChoiceButtonView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let multiplicator: Int
    
    var isSelected: Bool {
        return hordeAppViewModel.difficulty == multiplicator
    }
    
    var body: some View {
        Button(action: {
            print("Set token to \(multiplicator)x")
            hordeAppViewModel.setDifficulty(newDifficulty: multiplicator)
        }, label: {
            Text("\(multiplicator)x")
                .foregroundColor(isSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(UIDevice.isIPhone ? .title3 : .title2)
        })
    }
}

struct IntroPlayerChoiceButtonView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let percent: Int
    
    var isSelected: Bool {
        return gameViewModel.gameConfig.shared.deckSize == percent
    }
    
    var body: some View {
        Button(action: {
            print("Set deck size to \(percent)%")
            gameViewModel.reduceLibrarySize(percentToKeep: percent)
        }, label: {
            Text("\(percent)%")
                .foregroundColor(isSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(UIDevice.isIPhone ? .title3 : .title2)
        })
    }
}

struct GameIntroView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            GameView()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
        }
    }
}
