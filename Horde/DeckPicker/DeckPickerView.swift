//
//  DeckPickerView.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import SwiftUI

struct DeckPickerView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        ZStack{
            Color(.black)
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        DeckPickingIntro().id(-1)
                        ForEach(deckPickerViewModel.deckPickers, id: \.self) { deck in
                            DeckPickingView(deckPicker: deck).id(deck.id)
                        }
                        //DeckPickingMore()
                    }.padding([.leading, .trailing], 200)
                    .onChange(of: deckPickerViewModel.deckPickedId) { _ in
                        withAnimation {
                            proxy.scrollTo(deckPickerViewModel.deckPickedId, anchor: .center)
                       }
                    }
                    .onAppear() {
                        proxy.scrollTo(deckPickerViewModel.deckPickedId, anchor: .center)
                    }
                }
            }.frame(height: UIScreen.main.bounds.height)
            Button(action: {
                print("Menu button tapped")
                hordeAppViewModel.showMenu()
            }) {
                Image(systemName: "gear")
                    .font(.title)
                    .foregroundColor(.white)
            }.frame(width: 80)
                .position(x: 30, y: UIScreen.main.bounds.height - 30)
        }.ignoresSafeArea().frame(height: UIScreen.main.bounds.height)
    }
}

struct DeckPickingView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let deckPicker: DeckPicker
    
    let rotationInDegrees: CGFloat = 5
    var isDeckSelected: Bool {
        return deckPickerViewModel.deckPickedId == deckPicker.id
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                if isDeckSelected {
                    print("Start game with deck \(deckPicker.id)")
                    hordeAppViewModel.readyToPlay = true
                } else {
                    print("Deck \(deckPicker.id) picked")
                    deckPickerViewModel.pickDeck(deckId: deckPicker.id)
                }
            }) {
                ZStack {
                    Image(deckPicker.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .rotationEffect(Angle.degrees(-rotationInDegrees))
                        .frame(width: PickerSize.width.picked + 150)
                    VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
                        .opacity(isDeckSelected ? 0.7 : 0)
                    VStack(alignment: .center, spacing: 30) {
                        
                        // Title
                        
                        Text(deckPicker.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.top, 100)
                            .scaleEffect(isDeckSelected ? 2 : 1)
                        
                        if isDeckSelected {
                            Spacer()
                            
                            // Intro
                            Text(deckPicker.intro)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            
                            // Special Rules
                            
                            Text("Special Rules")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            Text(deckPicker.specialRules)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            
                            // Play
                            
                            Text("Press again to start")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title)
                                .padding(.bottom, 100)
                        }
                        
                    }.rotationEffect(Angle.degrees(-rotationInDegrees))
                        .frame(width: 500, height: UIScreen.main
                            .bounds.height)
                        .transition(.opacity)
                }.frame(width: pickerWidth(), height: UIScreen.main.bounds.height + 150)
                    .clipped()
                .rotationEffect(Angle.degrees(rotationInDegrees))
                
            }// .buttonStyle(StaticButtonStyle())
            
            Text("art by \(deckPicker.imageArtist)")
                .foregroundColor(.white)
                .offset(x: isDeckSelected ? 0 : -25, y: UIScreen.main.bounds.height / 2 - 60)
                .animation(.easeInOut(duration: 0.5), value: deckPickerViewModel.deckPickedId)
        }.animation(.easeInOut(duration: 0.5), value: deckPickerViewModel.deckPickedId)
    }
    
    private func pickerWidth() -> CGFloat {
        var width: CGFloat = PickerSize.width.picked
        if !isDeckSelected {
            width = PickerSize.width.unpicked
        }
        return width
    }
}

struct DeckPickingIntro: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            MenuTextTitleView(text: "Intro")
            
            MenuTextBoldParagraphView(text: "Never played the horde format ?")
            
            // Would be cool to put Image as a parameter of MenuParagraphView
            Text("The horde is a cooperative format created by Peter Knudson where player teams up against a self played deck. Go to \(Image(systemName: "gear")) > Rules to read the rules")
                .foregroundColor(.white)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            
            MenuTextBoldParagraphView(text: "Before starting your first match")
            
            Text("Go to \(Image(systemName: "gear")) > How To Play to learn how tu use this app")
                .foregroundColor(.white)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        
        }.frame(width: UIScreen.main.bounds.width / 3).padding(.trailing, 80)
    }
}

struct DeckPickingMore: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // Suggestion like using quests
        }.frame(width: UIScreen.main.bounds.width / 2).padding([.leading, .trailing], 60)
    }
}

struct DeckPickerView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckPickerView()
                .environmentObject(DeckPickerViewModel())
                .environmentObject(HordeAppViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            DeckPickerView()
                .environmentObject(DeckPickerViewModel())
                .environmentObject(HordeAppViewModel())
        }
    }
}

struct PickerSize {
    struct width {
        static let unpicked: CGFloat = 300
        static let picked: CGFloat = 700
    }
}
