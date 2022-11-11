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
    
    @State private var showHideIntroAlert = false
    @State private var showHideDiscordAlert = false
    
    var body: some View {
        ZStack{
            Color(.black)
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if deckPickerViewModel.showIntro {
                            ZStack(alignment: .topTrailing) {
                                DeckPickingIntro()
                                Button(action: {
                                    showHideIntroAlert = true
                                }, label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                }).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
                            }.padding(.trailing, 25)
                                .alert(isPresented: $showHideIntroAlert) {
                                    Alert(
                                        title: Text("Hide Intro"),
                                        message: Text("You won't see the intro ever again"),
                                        primaryButton: .destructive(
                                            Text("Cancel"),
                                            action: {showHideIntroAlert = false}
                                        ),
                                        secondaryButton: .default(
                                            Text("Confirm"),
                                            action: {deckPickerViewModel.hideIntro()}
                                        )
                                    )
                                }
                        }
                        
                        if deckPickerViewModel.showDiscordInvite {
                            ZStack(alignment: .topTrailing) {
                                DeckPickingDiscordView()
                                Button(action: {
                                    showHideDiscordAlert = true
                                }, label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                }).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
                            }.padding(.trailing, 45)
                                .alert(isPresented: $showHideDiscordAlert) {
                                    Alert(
                                        title: Text("Hide Discord invite"),
                                        message: Text("You can still find a link in the options under 'contact'"),
                                        primaryButton: .destructive(
                                            Text("Cancel"),
                                            action: {showHideDiscordAlert = false}
                                        ),
                                        secondaryButton: .default(
                                            Text("Confirm"),
                                            action: {deckPickerViewModel.hideDiscordInvite()}
                                        )
                                    )
                                }
                        }
                        
                        ZStack() {}.frame(width: 30, height: 1)
                        
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
                                .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 10)
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
                .onChange(of: isDeckSelected) { _ in
                    withAnimation(.easeIn(duration: 0.3)) {
                        confirmDeckDeletion = false
                    }
                }
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
    @State private var showingBuyInfo = false
    let rotationInDegrees: CGFloat = 5
    @State var price = "Unknow"
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                
                Text("Get more deck slots")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                
                Text(" - As many deck slots as you want \n - Full control over the starting decks and the ability to delete them \n - Custom sleeves : choose one of ours or upload any art from your device")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.subheadline)
                
                HStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        showingBuyInfo = true
                    }) {
                        HStack(spacing: 0) {
                            Text(price)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title)
                            
                            Text(" / Month")
                                .foregroundColor(.white)
                                .font(.title)
                        }.padding(15)
                        .background(Color("MainColor").cornerRadius(10))
                        .onAppear() {
                            price = IAPManager.shared.price() ?? "Unknow"
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                if self.price == "Unknow" {
                                    price = IAPManager.shared.price() ?? "Unknow"
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showingBuyInfo) {
                        Alert(
                            title: Text("Subscription information"),
                            message: Text("You may purchase an auto-renewing subscription through an In-App Purchase.\n\n • (in USD) Premium - 1 month ($1.99) \n\n • Your subscription will be charged to your iTunes account at confirmation of purchase and will automatically renew (at the duration selected) unless auto-renew is turned off at least 24 hours before the end of the current period.\n\n • Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase\n\n • Being Premium will give you, for the duration of your subsription, acess to an unlimited number of deck slots and the ability to delete the 7 decks already in the app."),
                            primaryButton: .destructive(
                                Text("Cancel"),
                                action: {showingBuyInfo = false}
                            ),
                            secondaryButton: .default(
                                Text("Continue"),
                                action: {hordeAppViewModel.buy()}
                            )
                        )
                    }
                    
                    Text("Already premium ? ")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .padding(.leading, 20)
                    
                    Button(action: {
                        hordeAppViewModel.restore()
                    }) {
                        Text("Restore")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(15)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark)).cornerRadius(10))
                    }
                }
                
                HStack(spacing: 0) {
                    Text("View our ")
                        .foregroundColor(.white)
                    
                    Link("Privacy policy",
                          destination: URL(string: "http://www.burning-beard.com/against-the-horde-app-policy")!)
                    
                    Text(", ")
                        .foregroundColor(.white)
                    
                    Link("EULA",
                          destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                }
                
            }.rotationEffect(Angle.degrees(-rotationInDegrees))
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 760 : 640, height: UIScreen.main
                    .bounds.height)
        }.frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 760 : 640, height: UIScreen.main.bounds.height + 150).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
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
        
        }.frame(width: UIScreen.main.bounds.width / 3).padding([.leading, .trailing], 35).scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
    }
}

struct DeckPickingDiscordView: View {
    
    var body: some View {
        Link(destination: URL(string: "https://discord.com/invite/wzm7bu6KDJ")!) {
            VStack(alignment: .leading, spacing: 30) {
                Image("DiscordIcon")
                    .resizable()
                    .frame(width: 280, height: 75)
                
                MenuTextBoldParagraphView(text: "Join us on Discord")
                
                MenuTextParagraphView(text: "Share your horde decks or find new decks in our Discord server.")
                
                MenuTextBoldParagraphView(text: "Tap here to join")
                
            }.frame(width: 280)
            .scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
        }.padding([.leading, .trailing], 35).padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 40 : 0)
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
    static let vStackSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 30 : 10
    static let titleFontSize: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 70 : 60
}
