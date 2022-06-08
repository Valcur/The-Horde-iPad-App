//
//  GameIntroView.swift
//  Horde
//
//  Created by Loic D on 30/05/2022.
//

import SwiftUI

struct GameIntroView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        // The button to leave the menu is the background
        Button(action: {
            print("Start game button pressed")
            gameViewModel.nextButtonPressed()
        }, label: {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        }).buttonStyle(StaticButtonStyle())
        
        VStack(spacing: 50) {
            
            if gameViewModel.turnStep == -1 {
                IntroSetupView()
            } else if gameViewModel.turnStep == 0 {
                IntroBeforeGameStartView()
            }
            
        }.padding([.leading, .trailing], 40)
            .transition(AnyTransition.slide)
    }
}

struct IntroSetupView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        HStack(spacing: 100) {
            GameModeSwitchButtonView(title: "Classic", setModeToClassic: true)
            GameModeSwitchButtonView(title: "Marathon", setModeToClassic: false)
        }
        
        HStack(alignment: .top, spacing: 50) {

            VStack(spacing: 30) {
                
                MenuTextSubtitleView(text: "Token multiplicator")
                
                MenuTextParagraphView(text: "Increase the amount of tokens to make the horde draw more cards")
                
                HStack(spacing: 20) {
                    IntroDifficultyChoiceButtonView(multiplicator: 1)
                    IntroDifficultyChoiceButtonView(multiplicator: 2)
                    IntroDifficultyChoiceButtonView(multiplicator: 3)
                }
                
                if gameViewModel.isClassicMode {
                    
                    MenuTextSubtitleView(text: "DeckSize")
                    
                    MenuTextParagraphView(text: "Reduce the library size depending on the number of players.")
                    
                    HStack(spacing: 20) {
                        IntroPlayerChoiceButtonView(percent: 100)
                        IntroPlayerChoiceButtonView(percent: 75)
                        IntroPlayerChoiceButtonView(percent: 50)
                        IntroPlayerChoiceButtonView(percent: 25)
                    }
                }
            }
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 2)
                .padding([.top, .bottom], 70)
            
            VStack(spacing: 30) {
                
                MenuTextSubtitleView(text: "Config")
                
                if gameViewModel.isClassicMode {
                    Toggle("Horde start with a random enchantment different for every deck", isOn: $gameViewModel.shouldStartWithEnchantment)
                        .foregroundColor(.white)
                    
                    Toggle("Spawn a random general different for every deck when half of the deck has been removed", isOn: $gameViewModel.shouldSpawnGeneralAtHalf)
                        .foregroundColor(.white)
                }
                
                Toggle("No board wipes in the first quarter", isOn: $gameViewModel.shouldntHaveBoardWipeInFirstQuarter)
                    .foregroundColor(.white)
            }
            
        }.background(Color(.white).opacity(0.00000001))
            .frame(height: UIScreen.main.bounds.height / 2)
            .animation(.easeInOut(duration: 0.3), value: gameViewModel.isClassicMode)
        
        MenuTextBoldParagraphView(text: "Touch anywhere to continue")
    }
}

struct GameModeSwitchButtonView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let title: String
    let setModeToClassic: Bool
    var isSelected: Bool {
        return gameViewModel.isClassicMode == setModeToClassic
    }
    
    var body: some View {
        Button(action: {
            print("Set mode to \(title)")
            gameViewModel.isClassicMode = setModeToClassic
        }, label: {
            Text(title)
                .foregroundColor(isSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(.largeTitle)
                .scaleEffect(isSelected ? 1 : 0.7)
        }).animation(.easeInOut(duration: 0.3), value: gameViewModel.isClassicMode)
    }
}

struct IntroBeforeGameStartView: View {
    var body: some View {
        MenuTextSubtitleView(text: "Lifepoints")
        
        MenuTextParagraphView(text: "The horde start with 20 life points and start to mill its library only when its lifepoints are equal to 0. The Horde gains life equal to any lose of life it causes the Survivors or damage it causes to planeswalkers the Survivors control. (This app can't keep tracks of lifepoint, use another app to handle Surviors and Horde's lifepoints)")
        
        MenuTextSubtitleView(text: "Recommanded horde draw per turn")
        
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
                .font(.title)
        })
    }
}

struct IntroPlayerChoiceButtonView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let percent: Int
    
    var isSelected: Bool {
        return gameViewModel.deckPercentToKeepAtStart == percent
    }
    
    var body: some View {
        Button(action: {
            print("Set deck size to \(percent)%")
            gameViewModel.reduceLibrarySize(percentToKeep: percent)
        }, label: {
            Text("\(percent)%")
                .foregroundColor(isSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(.title)
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
