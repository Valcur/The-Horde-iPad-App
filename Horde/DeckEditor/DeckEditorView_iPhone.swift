//
//  DeckEditorView_iPhone.swift
//  Horde
//
//  Created by Loic D on 24/07/2022.
//

import SwiftUI

struct DeckEditorView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var username: String = ""
    @State private var zoomViewOpacity: CGFloat = 0
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                HStack(spacing: 0){
                    if !deckEditorViewModel.isDeckTooStrongSelected() && !deckEditorViewModel.isReadOnly {
                        LeftPanelView_iPhone()
                            .frame(width: EditorSize.cardSearchPanelWidth)
                            .transition(.move(edge: .leading))
                    }
                    RightPanelView_iPhone()
                }
                PopUpInfoView().scaleEffect(0.7, anchor: .top)
                DeckEditorInfoView_iPhone().opacity(deckEditorViewModel.showDeckEditorInfoView ? 1 : 0)
                ZoomCardView()
                    .opacity(zoomViewOpacity)
                    .scaleEffect(1.4)
                    .onChange(of: deckEditorViewModel.shouldZoomOnCard) { shouldZoom in
                        if shouldZoom {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                zoomViewOpacity = 1
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                zoomViewOpacity = 0
                            }
                        }
                    }
            }
        }
    }
}

struct RightPanelView_iPhone: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId, colorOnly: true)
            VStack(spacing: 0) {
                TopTopControlRowView_iPhone()
                    .background(Color("DarkGray").ignoresSafeArea())
                TopControlRowView_iPhone()
                Spacer()
                DeckListView().ignoresSafeArea(edges: [.trailing, .bottom])
                Spacer()

            }
        }
    }
}

struct TopTopControlRowView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var deckName: String = ""
    @State private var showSaveAlert = false
    
    var isUserAllowedToModifyDeckInfo: Bool {
        return !deckEditorViewModel.isReadOnly && ((deckEditorViewModel.deckId < 7 && hordeAppViewModel.isPremium) || deckEditorViewModel.deckId >= 7)
    }
    
    var body: some View {
        HStack {
            
            // Edit deck info
            Button(action: {
                if isUserAllowedToModifyDeckInfo {
                    //withAnimation(.easeInOut(duration: 0.5)) {
                        deckEditorViewModel.showDeckEditorInfoView.toggle()
                    //}
                } else {
                    deckEditorViewModel.popUpText = "Premium required"
                }
            }, label: {
                HStack {
                    Text(deckName)
                        .font(.title2)
                        .foregroundColor(.white)
                        .scaleEffect(0.7)
                        .onChange(of: deckEditorViewModel.showDeckEditorInfoView) { _ in
                            deckName = deckEditorViewModel.loadDeckName()
                        }
                        .onAppear() {
                            deckName = deckEditorViewModel.loadDeckName()
                        }
                        .onChange(of: deckEditorViewModel.deckId) { _ in
                            deckName = deckEditorViewModel.loadDeckName()
                        }
                    Image(systemName: "pencil")
                        .font(.title2)
                        .foregroundColor(.white)
                        .opacity(isUserAllowedToModifyDeckInfo ? 1 : 0)
                        .scaleEffect(0.7, anchor: .leading)
                }.padding(.leading, 0).padding(.trailing, 40) // To make the button bigger
            })

            
            // Save
            if !deckEditorViewModel.isReadOnly {
                Button(action: {
                    deckEditorViewModel.saveDeck()
                }, label: {
                    HStack {
                        Text("Save")
                            .font(.title2)
                            .foregroundColor(.white)
                            .scaleEffect(0.7)
                        
                        Image(systemName: "arrow.down.doc")
                            .font(.title2)
                            .foregroundColor(.white)
                    }.scaleEffect(0.7)
                }).padding(.leading, 0).padding(.trailing, 40) // To make the button bigger
                    .opacity(deckEditorViewModel.showSaveButton ? 1 : 0)
            }
            
            Spacer()
            
            // Import
            if !deckEditorViewModel.isReadOnly {
                Button(action: {
                    deckEditorViewModel.importDeckFromClipboard()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title2)
                        .foregroundColor(.white)
                }).scaleEffect(0.7)
                
                Text("/")
                    .font(.title2)
                    .foregroundColor(.white)
                    .scaleEffect(0.7)
            }
            
            // Export
            Button(action: {
                deckEditorViewModel.exportDeckToClipboard()
            }, label: {
                Image(systemName: "doc.on.doc")
                    .font(.title3)
                    .foregroundColor(.white)
            }).scaleEffect(0.7)
            
            Text("/")
                .font(.title2)
                .foregroundColor(.white)
                .scaleEffect(0.7)
            
            ShareOnDiscordView().scaleEffect(0.7)
            
            Spacer()
            
            // Exit
            Button(action: {
                if deckEditorViewModel.showSaveButton {
                    showSaveAlert = true
                } else {
                    withAnimation(.easeIn(duration: 0.5)) {
                        hordeAppViewModel.showDeckEditor = false
                        DownloadQueue.queue.resetQueue()
                    }
                }
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
            }).scaleEffect(0.7).padding(.trailing, 5)
                .alert(isPresented: $showSaveAlert) {
                    Alert(
                        title: Text("Leave DeckEditor"),
                        message: Text("You have unsaved changes."),
                        primaryButton: .destructive(
                            Text("Cancel"),
                            action: {showSaveAlert = false}
                        ),
                        secondaryButton: .default(
                            Text("Exit without saving"),
                            action: {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    hordeAppViewModel.showDeckEditor = false
                                    DownloadQueue.queue.resetQueue()
                                }
                            }
                        )
                    )
                }
        }.padding(.horizontal, 10).padding(.vertical, 2)
    }
}

struct TopControlRowView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    DeckListSelectorView_iPhone(deckListName: "Horde Deck", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.deckList)
                    Spacer()
                    DeckListSelectorView_iPhone(deckListName: "Lategame", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList)
                    Spacer()
                    DeckListSelectorView_iPhone(deckListName: "Create row", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.availableTokensList)
                }
                Spacer()
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 1, height: 20)
                Spacer()
                DeckListSelectorView_iPhone(deckListName: "Start", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList)
                Spacer()
                DeckListSelectorView_iPhone(deckListName: "Milestones", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList)
            }.frame(height: 28).background(Color("DarkGray").shadowed().ignoresSafeArea())
            
            HStack() {
                Text(deckEditorViewModel.deckSelectionInfo)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(deckEditorViewModel.cardCountForSelectedDeck)
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .multilineTextAlignment(.leading)
            }.frame(height: 10).padding([.leading, .trailing], 15)
        }
    }
}

struct DeckListSelectorView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let deckListName: String
    let deckListNumber: Int
    var isSelected: Bool {
        deckEditorViewModel.selectedDeckListNumber == deckListNumber
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    deckEditorViewModel.changeSelectedDeckTo(newSelectedDeck: deckListNumber)
                }
            }, label: {
                VStack {
                   Text(deckListName)
                       .fontWeight(.bold)
                       .font(.footnote
                       )
                       .foregroundColor(isSelected ? .white : .gray)
                       .padding(.bottom, 0)
                   Rectangle()
                       .frame(height: 2)
                       .foregroundColor(isSelected ? .white : Color("DarkGray"))
               }
            })
        }
    }
}

struct LeftPanelView_iPhone: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId, colorOnly: true)
            
            
            ZStack {
                CardSearchView_iPhone()
                ZStack {
                    if deckEditorViewModel.cardToShow != nil {
                        ZStack {
                            GradientView(gradientId: hordeAppViewModel.gradientId, colorOnly: true).transition(.move(edge: .trailing))
                            CardShowView_iPhone(card: deckEditorViewModel.cardToShow!).transition(.move(edge: .trailing))
                                .background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark)).ignoresSafeArea())
                        }
                        
                    }
                }.animation(.easeInOut(duration: 0.3), value: deckEditorViewModel.cardToShow)
            }.background(VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark)).ignoresSafeArea())
        }
    }
}

struct CardShowView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State var card: Card
    @State var cardType: CardType
    @State var hasCardCastFromGraveyard: Bool
    @State var hasCardFlashback: Bool
    @State var hasCardDefender: Bool
    
    private var selectedCard: Card {
        return deckEditorViewModel.changeCardToFitCardInSelectedDeck(card: self.getSelectedCardFromCarousel())
    }
    
    init(card: Card) {
        self.card = card
        self.cardType = card.cardType
        self.hasCardCastFromGraveyard = card.hasCardCastFromGraveyard
        self.hasCardFlashback = card.hasFlashback
        self.hasCardDefender = card.hasDefender
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottom) {
                    // Card to show
                    CardToShowCarouselView(index: $deckEditorViewModel.carouselIndex.animation(), maxIndex: deckEditorViewModel.cardToShowReprints.count) {
                        if deckEditorViewModel.cardToShow != nil {
                            CarouselCardView(card: deckEditorViewModel.cardToShow!, delay: 0)
                        }
                        ForEach(deckEditorViewModel.cardToShowReprints.indices, id: \.self) { i in
                            CarouselCardView(card: deckEditorViewModel.cardToShowReprints[i], delay: i)
                        }
                    }
                    
                    // Add or Remove to selected deck
                    HStack {
                        Spacer()
                        Button(action: {
                            let tmpCard = selectedCard
                            tmpCard.cardType = self.cardType
                            tmpCard.hasCardCastFromGraveyard = self.hasCardCastFromGraveyard
                            tmpCard.hasFlashback = self.hasCardFlashback
                            if deckEditorViewModel.removeCardShouldBeAnimated(card: tmpCard) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    deckEditorViewModel.removeCardFromSelectedDeck(card: tmpCard)
                                }
                            } else {
                                deckEditorViewModel.removeCardFromSelectedDeck(card: tmpCard)
                            }
                        }, label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 2, x: 0, y: 2)
                        }).disabled(!deckEditorViewModel.isRemoveOneCardButtonEnable(card: selectedCard))
                        
                        Spacer()
                        Spacer()
                        
                        Button(action: {
                            let tmpCard = selectedCard
                            tmpCard.cardType = self.cardType
                            tmpCard.hasCardCastFromGraveyard = self.hasCardCastFromGraveyard
                            tmpCard.hasFlashback = self.hasCardFlashback
                            if deckEditorViewModel.addCardShouldBeAnimated(card: tmpCard) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    deckEditorViewModel.addCardToSelectedDeck(card: tmpCard)
                                }
                            } else {
                                deckEditorViewModel.addCardToSelectedDeck(card: tmpCard)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 2, x: 0, y: 2)
                        })
                        Spacer()
                    }.offset(y: 25)
                }.padding(.horizontal, 10).padding(.top, 2)
                
                // Return Button
                Button(action: {
                    deckEditorViewModel.cardToShow = nil
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(.white)
                        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
                }).padding()
            }
            
            // Enable/Disable flashback
            
            VStack(alignment: .leading) {
                Toggle(isOn: $hasCardCastFromGraveyard) {
                    Text("Cast from graveyard")
                        .foregroundColor(.white)
                        .font(.body)
                }
                
                if hasCardCastFromGraveyard {
                    Toggle(isOn: $hasCardFlashback) {
                        HStack(spacing: 15) {
                            Color.white.frame(width: 1, height: 30).padding(.leading, 5)
                            Text("Then exile")
                                .foregroundColor(.white)
                                .font(.body)
                        }
                    }
                }
            }.frame(width: EditorSize.cardSearchPanelWidth * 1.3)
            .scaleEffect(0.7, anchor: .top).frame(width: EditorSize.cardSearchPanelWidth)
            .padding(.top, 35)
            .onChange(of: deckEditorViewModel.carouselIndex) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.cardType = selectedCard.cardType
                    self.hasCardCastFromGraveyard = selectedCard.hasCardCastFromGraveyard
                    self.hasCardFlashback = selectedCard.hasFlashback
                    self.hasCardDefender = selectedCard.hasDefender
                }
            }.onChange(of: cardType) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selectedCard.cardType = cardType
                }
            }.onChange(of: hasCardCastFromGraveyard) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selectedCard.hasCardCastFromGraveyard = self.hasCardCastFromGraveyard
                    withAnimation(nil) {
                        deckEditorViewModel.changeCardGraveyardFromSelectedDeck(card: selectedCard, newGraveyardValue: hasCardCastFromGraveyard)
                    }
                }
            }.onChange(of: hasCardFlashback) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selectedCard.hasFlashback = self.hasCardFlashback
                    withAnimation(nil) {
                        deckEditorViewModel.changeCardFlashbackFromSelectedDeck(card: selectedCard, newFlashbackValue: hasCardFlashback)
                    }
                }
            }.onChange(of: hasCardDefender) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selectedCard.hasDefender = self.hasCardDefender
                    withAnimation(nil) {
                        deckEditorViewModel.changeCardDefenderFromSelectedDeck(card: selectedCard, newDefenderValue: hasCardDefender)
                    }
                }
            }.onChange(of: deckEditorViewModel.selectedDeckListNumber) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.cardType = selectedCard.cardType
                    self.hasCardCastFromGraveyard = selectedCard.hasCardCastFromGraveyard
                    self.hasCardFlashback = selectedCard.hasFlashback
                    self.hasCardDefender = selectedCard.hasDefender
                }
            }.onChange(of: deckEditorViewModel.cardToShow) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.cardType = selectedCard.cardType
                    self.hasCardCastFromGraveyard = selectedCard.hasCardCastFromGraveyard
                    self.hasCardFlashback = selectedCard.hasFlashback
                    self.hasCardDefender = selectedCard.hasDefender
                }
            }
                
            if selectedCard.cardType == .creature || selectedCard.cardType == .token {
                
                // Enable/Disable defender
                Toggle(isOn: $hasCardDefender) {
                    VStack(alignment: .leading) {
                        Text("Can't attack")
                            .foregroundColor(.white)
                            .font(.body)
                    }
                }
                .frame(width: EditorSize.cardSearchPanelWidth * 1.3)
                .padding(.top, 0).padding(.bottom, 10)
                .scaleEffect(0.7).frame(width: EditorSize.cardSearchPanelWidth)
                
                // Select card type
                Text("Change card type")
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.top, 10)
                    .padding(.leading, 0)
                    .scaleEffect(0.7)
      
                HStack {
                    CardShowTypeSelectorView_iPhone(text: "Creature", cardType: .creature, cardShowedcardType: $cardType)
                    CardShowTypeSelectorView_iPhone(text: "Token", cardType: .token, cardShowedcardType: $cardType)
                }.padding(.top, 0)
            }
            
            Spacer()

        }.scrollableVStask()
    }
    
    func getSelectedCardFromCarousel() -> Card {
        if deckEditorViewModel.cardToShow == nil {
            return Card(cardName: "Adult Gold Dragon", cardType: .creature, specificSet: "AFR")
        }
        if deckEditorViewModel.carouselIndex == 0 || deckEditorViewModel.cardToShowReprints.count == 0 {
            return deckEditorViewModel.cardToShow!.recreateCard()
        }
        
        return deckEditorViewModel.cardToShowReprints[deckEditorViewModel.carouselIndex - 1].recreateCard()
    }
}

struct CardShowTypeSelectorView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let text: String
    let cardType: CardType
    @Binding var cardShowedcardType: CardType
    
    private var selectedCard: Card {
        return deckEditorViewModel.changeCardToFitCardInSelectedDeck(card: self.getSelectedCardFromCarousel())
    }
    func getSelectedCardFromCarousel() -> Card {
        if deckEditorViewModel.cardToShow == nil {
            return Card(cardName: "Adult Gold Dragon", cardType: .creature, specificSet: "AFR")
        }
        if deckEditorViewModel.carouselIndex == 0 || deckEditorViewModel.cardToShowReprints.count == 0 {
            return deckEditorViewModel.cardToShow!.recreateCard()
        }
        
        return deckEditorViewModel.cardToShowReprints[deckEditorViewModel.carouselIndex - 1].recreateCard()
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                deckEditorViewModel.changeCardTypeFromSelectedDeck(card: selectedCard, newCardType: cardType)
                cardShowedcardType = cardType
            }
        }, label: {
            Text(text)
                .fontWeight(.bold)
                .font(.footnote)
                .foregroundColor(cardShowedcardType == cardType ? .white : .gray)
                .scaleEffect(0.8)
                .padding(.vertical, 5)
        }).frame(maxWidth: .infinity)
    }
}

struct CardSearchView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var cardSearchTextFieldText: String = ""
    @State private var isSearchingForTokens: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack(alignment: .leading) {
                    if cardSearchTextFieldText == "" {
                        Text("Search...")
                            .foregroundColor(.gray)
                            .font(.body)
                    }

                        TextField("", text: $cardSearchTextFieldText, onCommit: {
                            deckEditorViewModel.searchCardsFor(text: cardSearchTextFieldText, searchingForTokens: isSearchingForTokens)
                        })
                        .foregroundColor(.white)
                        .font(.body)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.vertical, 2)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                        .foregroundColor(.gray)
                }

                if cardSearchTextFieldText.count > 0 {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            cardSearchTextFieldText = ""
                        }
                    }, label: {
                        Image(systemName: "clear")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(5)
                    })
                }
                
                Button(action: {
                    isSearchingForTokens.toggle()
                }, label: {
                    Text("Tokens")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(isSearchingForTokens ? .white : .gray)
                })
            }.ignoresSafeArea(.keyboard).padding(5).padding(.leading, 10).transition(.move(edge: .leading))
            
            // Search result
            ScrollView {
                VStack(spacing: 0) {
                    if deckEditorViewModel.searchResult.count > 0 {
                        ForEach(deckEditorViewModel.searchResult.reversed()) { card in
                            CardSearchResultView_iPhone(card: card).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    } else {
                        MenuTextParagraphView(text: deckEditorViewModel.searchProgressInfo).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            .scaleEffect(0.9)
                            .padding(.bottom, 40)
                    }
                }.rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center).padding(.bottom, 40)
            }.ignoresSafeArea(.keyboard)
        }
    }
}

struct CardSearchResultView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let card: CardFromCardSearch
    
    var body: some View {
        Button(action: {
            deckEditorViewModel.showCard(card: card)
        }, label: {
            HStack {
                ZStack{
                    CardView(card: card, shouldImageBeSaved: false)
                        .frame(width: 46, height: 65)
                        .aspectRatio(contentMode: .fit)
                        .offset(y: 10)
                }.frame(width: 35, height: 28).clipped()
                Text(card.cardName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                CardSearchResultManaCostView(manaCost: card.getManaCostArray())
            }.padding([.top, .bottom, .leading, .trailing], 5)
        })
    }
    
    struct CardSearchResultManaCostView: View {
        
        let manaCost: [String]
        
        var body: some View {
            HStack(spacing: 2) {
                ForEach(manaCost, id: \.self) {
                    Image($0)
                        .resizable()
                        .frame(width: 14, height: 14)
                }
            }
        }
    }
}

struct DeckEditorView_iPhone_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckEditorInfoView_iPhone()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                //.previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            DeckEditorView_iPhone()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
        }
    }
}

struct DeckEditorInfoView_iPhone: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var changingImage: Bool = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image = Image("Dinosaur")
    @StateObject var deckNametextBindingManager = TextBindingManager(limit: 14)
    @State var deckIntro: String = ""
    @State var deckRules: String = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            
            image
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height)

            VStack {
                Spacer()
                Button(action: {
                    showingImagePicker = true
                }, label: {
                    ZStack {
                        VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        Text("Select picture from your library")
                            .font(.title3)
                            .foregroundColor(.white)
                    }.frame(width: 320, height: 60).cornerRadius(30).shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4).scaleEffect(0.7)
                    
                }).opacity(changingImage ? 1 : 0)
                    .onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
            }.padding(50)

            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).opacity(changingImage ? 0 : 1)
            
            VStack(alignment: .center, spacing: 5) {
                
                // Deck Name
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .font(.title3)
                        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
                        .padding()
                    
                    TextField("", text: $deckNametextBindingManager.text, onCommit: {

                    })
                    .foregroundColor(.white)
                    .font(.system(size: PickerSize.titleFontSize  * 0.6).bold())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 2)
                }.padding(.bottom, 10).frame(width: UIScreen.main.bounds.width / 2)
                
                HStack(spacing: 10) {

                    HStack(spacing: 0) {
                        Image(systemName: "pencil")
                            .font(.title3)
                            .foregroundColor(.white)
                            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
                            .padding()
                        
                        if deckEditorViewModel.showDeckEditorInfoView {
                            ScrollView {
                                MultilineTextField("Deck Intro", text: $deckIntro, onCommit: {
                                    
                                })
                            }
                            .frame(height: 70)
                            .padding(2)
                            .border(.white, width: 2)
                        }
                    }

                    HStack(spacing: 0) {
                        Image(systemName: "pencil")
                            .font(.title3)
                            .foregroundColor(.white)
                            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
                            .padding()
                        
                        if deckEditorViewModel.showDeckEditorInfoView {
                            ScrollView {
                                MultilineTextField("", text: $deckRules, onCommit: {
                                    
                                })
                            }
                            .frame(height: 70)
                            .padding(2)
                            .border(.white, width: 2)
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    deckEditorViewModel.showDeckEditorInfoView.toggle()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        deckEditorViewModel.saveDeckName(text: deckNametextBindingManager.text)
                        deckEditorViewModel.saveIntroText(text: deckIntro)
                        deckEditorViewModel.saveRulesText(text: deckRules)
                    }
                }, label: {
                    MenuTextTitleView(text: "Back to deck editor")
                        .scaleEffect(0.7)
                })
                Spacer()
            }.padding([.top], 10).padding(.horizontal, 35).opacity(changingImage ? 0 : 1)
            
            // Switch between text/image edit mode
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.changingImage.toggle()
                }
            }, label: {
                Image(systemName: "photo")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
            }).position(x: UIScreen.main.bounds.width - 30, y: 25)
        }.ignoresSafeArea()
            .onChange(of: deckEditorViewModel.deckId) { deckId in
                if deckId >= 0 {
                    deckNametextBindingManager.text = deckEditorViewModel.loadDeckName()
                    deckIntro = deckEditorViewModel.loadIntroText()
                    deckRules = deckEditorViewModel.loadRulesText()
                    inputImage = deckEditorViewModel.loadImage()
                    loadImage()
                }
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            image = Image("BlackBackground")
            return
        }
        deckEditorViewModel.saveImage(image: inputImage)
        image = Image(uiImage: inputImage)
    }
}
