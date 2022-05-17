//
//  DeckPickerView.swift
//  Horde
//
//  Created by Loic D on 14/05/2022.
//

import SwiftUI

struct DeckPickerView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    
    var body: some View {
        ZStack{
            Color(.black)
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<deckPickerViewModel.deckPickers.count, id: \.self) { i in
                            DeckPickingView(deckId: i, deckPicker: deckPickerViewModel.deckPickers[i])
                                .id(i)
                        }
                    }//.frame(width: PickerSize.width.unpicked * 3 + PickerSize.width.picked + 350)
                        .padding([.leading, .trailing], 200)
                    .onChange(of: deckPickerViewModel.deckPickedId) { _ in
                        withAnimation {
                            proxy.scrollTo(deckPickerViewModel.deckPickedId, anchor: .center)
                       }
                    }
                    .onAppear() {
                        proxy.scrollTo(deckPickerViewModel.deckPickedId, anchor: .center)
                    }
                }
            }
        }.ignoresSafeArea()
    }
}

struct DeckPickingView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let deckId: Int
    let deckPicker: DeckPicker
    
    let rotationInDegrees: CGFloat = 5
    var isDeckSelected: Bool {
        return deckPickerViewModel.deckPickedId == deckId
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                if isDeckSelected {
                    print("Start game with deck \(deckId)")
                    hordeAppViewModel.readyToPlay = true
                } else {
                    print("Deck \(deckId) picked")
                    deckPickerViewModel.pickDeck(deckId: deckId)
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
                        //.opacity(isDeckSelected ? 1 : 0)
                        //
                }.frame(width: pickerWidth(), height: UIScreen.main.bounds.height + 150)
                    .clipped()
                .rotationEffect(Angle.degrees(rotationInDegrees))
                //.animation(.easeInOut(duration: 0.5), value: deckPickerViewModel.deckPickedId)
                
            }// .buttonStyle(StaticButtonStyle())
            
            if isDeckSelected {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Difficulty")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Button(action: {
                            print("Difficulty set to 1x")
                            hordeAppViewModel.setDifficulty(newDifficulty: 1)
                        }) {
                            Text("1X")
                                .foregroundColor(hordeAppViewModel.difficulty == 1 ? .white : .gray)
                                .fontWeight(.bold)
                                .font(.title)
                                .frame(width: 80, height: 40)
                        }.offset(x: -30)
                        
                        Button(action: {
                            print("Difficulty set to 2x")
                            hordeAppViewModel.setDifficulty(newDifficulty: 2)
                        }) {
                            Text("2X")
                                .foregroundColor(hordeAppViewModel.difficulty == 2 ? .white : .gray)
                                .fontWeight(.bold)
                                .font(.title)
                                .frame(width: 80, height: 40)
                        }.offset(x: -40)
                        
                        Button(action: {
                            print("Difficulty set to 3x")
                            hordeAppViewModel.setDifficulty(newDifficulty: 3)
                        }) {
                            Text("3X")
                                .foregroundColor(hordeAppViewModel.difficulty == 3 ? .white : .gray)
                                .fontWeight(.bold)
                                .font(.title)
                                .frame(width: 80, height: 40)
                        }.offset(x: -50)
                        
                        Spacer()
                    }
                    Spacer()
                }.offset(x: 80, y: 110).opacity(isDeckSelected ? 1 : 0).transition(.move(edge: .top))
            }
            
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
        // First and larst larger to compensate hidden part
        /*if deckId == 0 || deckId == 4 {
            width = width + 50
        }*/
        return width
    }
}

struct DeckPickerView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckPickerView()
                .environmentObject(DeckPickerViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            DeckPickerView()
                .environmentObject(DeckPickerViewModel())
        }
    }
}

struct PickerSize {
    struct width {
        static let unpicked: CGFloat = 300
        static let picked: CGFloat = 700
    }
}
