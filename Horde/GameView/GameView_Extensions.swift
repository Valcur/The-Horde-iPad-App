//
//  GameView_Extensions.swift
//  Horde
//
//  Created by Loic D on 13/10/2022.
//

import SwiftUI

struct AddCountersOnPermanentsView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        HStack {
            Button(action: {
                gameViewModel.toggleRemoveCounters()
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(15)
            }).opacity(gameViewModel.removeCountersModeEnable ? 0.5 : 1)
            Text("/")
                .foregroundColor(.white)
                .font(.subheadline)
            Button(action: {
                gameViewModel.toggleAddCounters()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(15)
            }).opacity(gameViewModel.addCountersModeEnable ? 0.5 : 1)
        }
        .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).onTapGesture {
            gameViewModel.resetModes()
        })
        .cornerRadius(40)
        .padding(10)
        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
    }
}

struct ReturnToHandView: View {
    @EnvironmentObject var gameViewModel: GameViewModel
    var body: some View {
        Button(action: {
            gameViewModel.toggleReturnToHand()
        }, label: {
            Image(systemName: "hand.wave.fill")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(15)
                .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
        }).opacity(gameViewModel.returnToHandModeEnable ? 0.5 : 1)
        .cornerRadius(40)
        .padding(10)
        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
    }
}

struct HandView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let maxCardsBeforeShrinking = 4
    var cardSizeCoeff: CGFloat {
        return gameViewModel.hand.count > maxCardsBeforeShrinking ? CGFloat(maxCardsBeforeShrinking) / CGFloat(gameViewModel.hand.count) : 1
    }
    
    var body: some View {
        HStack {
            ForEach(gameViewModel.hand) { card in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        gameViewModel.discardACardAtRandom()
                    }
                }, label: {
                    CardBackView()
                        .frame(width: CardSize.width.hand * cardSizeCoeff, height: CardSize.height.hand * cardSizeCoeff)
                        .cornerRadius(CardSize.cornerRadius.hand * cardSizeCoeff)
                        .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
                }).offset(y: CardSize.height.hand / 2)
                    .frame(width: CardSize.width.hand * cardSizeCoeff + 10, height: CardSize.height.hand + 10).clipped()                        .rotationEffect(.degrees(180)).transition(.move(edge: .top))
                    
            }
        }.position(x: UIScreen.main.bounds.width / 2, y: CardSize.height.hand / 2)
    }
}

struct CardBackView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    private var customArtId: Int {
        return hordeAppViewModel.customSleeveArtId
    }
    private var customBorderColorId: Int {
        return hordeAppViewModel.customSleeveBorderColorId
    }
    
    var body: some View {
        if customArtId >= 0 {
            GeometryReader { geo in
                SleeveArtImageView(artId: customArtId).frame(width: geo.size.width, height: geo.size.height).clipped()
                    .border(customBorderColorId == 0 ? .black : .white, width: geo.size.width * 0.03)
            }
        } else {
            Image("MTGBackground")
                .resizable()
        }
    }
}
