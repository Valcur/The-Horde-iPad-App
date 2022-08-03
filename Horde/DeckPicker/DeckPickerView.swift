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
                        
                        ForEach(0..<hordeAppViewModel.numberOfDeckSlot, id: \.self) { i in
                            if deckPickerViewModel.deckForIdExist(id: i) {
                                DeckPickingView(deckPicker: deckPickerViewModel.getDeck(id: i)).id(i)
                            } else {
                                CreateNewDeckView(deckId: i).id(i)
                            }
                        }
                        
                        if !hordeAppViewModel.isPremium {
                            GetMoreDeckSlotView()
                        }
                    }.padding(.trailing, 400)
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
    @State var confirmDeckDeletion: Bool = false
    let deckPicker: DeckPicker
    
    let rotationInDegrees: CGFloat = 5
    var isDeckSelected: Bool {
        return deckPickerViewModel.deckPickedId == deckPicker.id
    }
    
    var isDeckBigEnough: Bool {
        return DeckManager.getDeckForId(deckPickedId: deckPicker.id, difficulty: 1).0.count >= 50
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                if isDeckSelected {
                    if isDeckBigEnough {
                        print("Start game with deck \(deckPicker.id)")
                        hordeAppViewModel.readyToPlay = true
                    }
                } else {
                    print("Deck \(deckPicker.id) picked")
                    deckPickerViewModel.pickDeck(deckId: deckPicker.id)
                }
            }) {
                ZStack {
                    deckPicker.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .rotationEffect(Angle.degrees(-rotationInDegrees))
                        .frame(width: PickerSize.width.picked + 250)
                    VisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
                        .opacity(isDeckSelected ? 0.7 : 0).scaleEffect(1.2)
                    VStack(alignment: .center, spacing: PickerSize.vStackSpacing) {
                        
                        // Title
                        
                        Text(deckPicker.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: PickerSize.titleFontSize))
                            .padding(.top, isDeckSelected ? PickerSize.titlePaddingTop : 0)
                            .scaleEffect(isDeckSelected ? 1 : 0.5)
                        
                        if isDeckSelected {
                            Spacer()
                            
                            // Intro
                            Text(deckPicker.intro)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            // Special Rules
                            
                            Text("Special Rules")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            Text(deckPicker.specialRules)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            
                            // Play
                            
                            Text(isDeckBigEnough ? "Press again to start" : "Deck need at least 50 cards")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title)
                                .padding(.bottom, PickerSize.titlePaddingTop)
                                .padding(.top, 50)
                        }
                        
                    }.rotationEffect(Angle.degrees(-rotationInDegrees))
                        .frame(width: 500, height: UIScreen.main
                            .bounds.height)
                        .transition(.opacity)
                }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7).frame(width: pickerWidth(), height: UIScreen.main.bounds.height + 150)
                    .clipped()
                .rotationEffect(Angle.degrees(rotationInDegrees))
                
            }// .buttonStyle(StaticButtonStyle())
            
            HStack {
                // Delete
                if confirmDeckDeletion {
                    HStack {
                        Text("Are you sure ?")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(10)
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                deckPickerViewModel.deleteDeck(id: deckPicker.id)
                                hordeAppViewModel.deleteDeck()
                                confirmDeckDeletion = false
                                if !((deckPicker.id < 7 && hordeAppViewModel.isPremium) || deckPicker.id >= 7) {
                                    DeckManager.createStarterDecks()
                                }
                            }
                        }) {
                            Text("Yes")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                        }
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                confirmDeckDeletion = false
                            }
                        }) {
                            Text("No")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(10)
                        }
                    }.transition(.opacity).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
                } else {
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.3)) {
                            confirmDeckDeletion = true
                        }
                    }) {
                        if (deckPicker.id < 7 && hordeAppViewModel.isPremium) || deckPicker.id >= 7 {
                            Image(systemName: "trash")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .transition(.opacity)
                        } else {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .transition(.opacity)
                        }
                    }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
                }
                
                Spacer()
                
                // Edit
                Button(action: {
                    deckPickerViewModel.editDeck(id: deckPicker.id)
                    //withAnimation(.easeIn(duration: 0.5)) {
                        hordeAppViewModel.showDeckEditor = true
                    //}
                }) {
                    Image(systemName: "pencil")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
            }.background(Rectangle().opacity(0.00001)).padding(.horizontal, 30).opacity(isDeckSelected ? 1 : 0).offset(x: 25, y: -UIScreen.main.bounds.height / 2.3)
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

struct CreateNewDeckView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let rotationInDegrees: CGFloat = 5
    let deckId: Int
    
    var body: some View {
        Button(action: {
            deckPickerViewModel.createDeck(id: deckId)
            //withAnimation(.easeIn(duration: 0.5)) {
                hordeAppViewModel.showDeckEditor = true
                hordeAppViewModel.createDeck(deckId: deckId)
            //}
        }) {
            ZStack {
                VStack(alignment: .center, spacing: 40) {
                    
                    Text("Create new deck")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, PickerSize.titlePaddingTop)
                    
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                }.rotationEffect(Angle.degrees(-rotationInDegrees))
                    .frame(width: 500, height: UIScreen.main
                        .bounds.height)
            }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7).frame(width: PickerSize.width.unpicked, height: UIScreen.main.bounds.height + 150)
                .border(.white, width: 3)
            .rotationEffect(Angle.degrees(rotationInDegrees))
        }.animation(.easeInOut(duration: 0.5), value: deckPickerViewModel.deckPickedId)
    }
}

struct GetMoreDeckSlotView: View {
    
    @EnvironmentObject var deckPickerViewModel: DeckPickerViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let rotationInDegrees: CGFloat = 5
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                
                Text("Get more deck slots")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                
                Text(" - As many deck slots as you want \n - Full control over the starting decks and the ability to delete them")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.subheadline)
                
                Button(action: {
                    hordeAppViewModel.buy()
                }) {
                    HStack(spacing: 0) {
                        Text(IAPManager.shared.price() ?? "Unknow")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Text(" / Month")
                            .foregroundColor(.white)
                            .font(.title)
                    }.padding(15)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark)).cornerRadius(10))
                }
                
                Image(systemName: "cart")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
            }.rotationEffect(Angle.degrees(-rotationInDegrees))
                .frame(width: 520, height: UIScreen.main
                    .bounds.height)
        }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7).frame(width: 520, height: UIScreen.main.bounds.height + 150)
            .border(.white, width: 3)
        .rotationEffect(Angle.degrees(rotationInDegrees))
    }
}

struct DeckPickingIntro: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            MenuTextTitleView(text: "Introduction")
            
            MenuTextBoldParagraphView(text: "Never played the horde format ?")
            
            MenuTextWithImageParagraphView(text1: "The horde is a cooperative format where player teams up against a self played deck. ", image: Image(systemName: "gear"), text2: "> Rules to read the rules")
            
            MenuTextBoldParagraphView(text: "Before starting your first game")
            
            MenuTextWithImageParagraphView(text1: "", image: Image(systemName: "gear"), text2: "> How To Play to learn how to use this app")
        
        }.frame(width: UIScreen.main.bounds.width / 3).padding([.leading, .trailing], 80).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
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
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        } else {
            DeckPickerView()
                .environmentObject(DeckPickerViewModel())
                .environmentObject(HordeAppViewModel())
        }
    }
}

struct PickerSize {
    struct width {
        static let unpicked: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 300 : 250
        static let picked: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 700 : 450
    }
    static let titlePaddingTop: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 100 : 0
    static let vStackSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 30 : 15
    static let titleFontSize: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 70 : 60
}
