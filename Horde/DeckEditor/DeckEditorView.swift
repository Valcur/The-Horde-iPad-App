//
//  DeckEditorView.swift
//  Horde
//
//  Created by Loic D on 11/07/2022.
//

import SwiftUI

struct DeckEditorView: View {
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var username: String = ""
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                HStack(spacing: 0){
                    if !deckEditorViewModel.isDeckTooStrongSelected() && !deckEditorViewModel.isReadOnly {
                        LeftPanelView()
                            .frame(width: EditorSize.cardSearchPanelWidth)
                            .transition(.move(edge: .leading))
                    }
                    RightPanelView()
                }
                PopUpInfoView()
                DeckEditorInfoView().opacity(deckEditorViewModel.showDeckEditorInfoView ? 1 : 0)
            }
        }.ignoresSafeArea()
    }
}

struct PopUpInfoView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var showPopUp = false
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).cornerRadius(40).shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
            MenuTextBoldParagraphView(text: deckEditorViewModel.popUpText)
        }.frame(width: 300, height: 80).position(x: UIScreen.main.bounds.width / 2, y: showPopUp ? 50 : -50)
            .animation(.easeInOut(duration: 0.3), value: showPopUp)
        .onChange(of: deckEditorViewModel.popUpText) { newText in
            print("Pop \(newText)")
            if newText != "" {
                self.showPopUp = true
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    self.showPopUp = false
                }
                Timer.scheduledTimer(withTimeInterval: 2.3, repeats: false) { timer in
                    deckEditorViewModel.popUpText = ""
                }
            }
        }
    }
}

struct RightPanelView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId)
            VStack {
                TopTopControlRowView()
                TopControlRowView()
                Spacer()
                DeckListView()
                Spacer()

            }.ignoresSafeArea()
        }
    }
}

struct LeftPanelView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId)
            VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
            
            ZStack {
                CardSearchView()
                ZStack {
                    if deckEditorViewModel.cardToShow != nil {
                        GradientView(gradientId: hordeAppViewModel.gradientId).transition(.move(edge: .trailing))
                        VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark)).transition(.move(edge: .trailing))
                        CardShowView(card: deckEditorViewModel.cardToShow!).transition(.move(edge: .trailing))
                    }
                }.animation(.easeInOut(duration: 0.3), value: deckEditorViewModel.cardToShow)
            }
        }
    }
}

struct CardSearchView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var cardSearchTextFieldText: String = ""
    @State private var isSearchingForTokens: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // TextField + Selector token/non-token
            HStack {
                ZStack(alignment: .leading) {
                    if cardSearchTextFieldText == "" {
                        Text("Search...")
                            .foregroundColor(.gray)
                            .font(.title3)
                    }

                        TextField("", text: $cardSearchTextFieldText, onCommit: {
                            deckEditorViewModel.searchCardsFor(text: cardSearchTextFieldText, searchingForTokens: isSearchingForTokens)
                        })
                        .foregroundColor(.white)
                        .font(.title3)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.vertical, 10)
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
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(5)
                    })
                }

                Button(action: {
                    isSearchingForTokens.toggle()
                }, label: {
                    Text("Tokens")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(isSearchingForTokens ? .white : .gray)
                })
            }.ignoresSafeArea(.keyboard).padding(10).transition(.opacity)
            
            // Search result
            ScrollView {
                VStack(spacing: 0) {
                    if deckEditorViewModel.searchResult.count > 0 {
                        ForEach(deckEditorViewModel.searchResult.reversed()) { card in
                            CardSearchResultView(card: card).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                        }
                    } else {
                        MenuTextParagraphView(text: deckEditorViewModel.searchProgressInfo).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                            .padding(.bottom, 40)
                    }
                }.rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center).padding(.bottom, 40)
            }.ignoresSafeArea(.keyboard)
        }
    }
}

struct CardSearchResultView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let card: CardFromCardSearch
    
    var body: some View {
        Button(action: {
            deckEditorViewModel.showCard(card: card)
        }, label: {
            HStack {
                ZStack{
                    CardView(card: card, shouldImageBeSaved: false)
                        .frame(width: 66, height: 94)
                        .aspectRatio(contentMode: .fit)
                        .offset(y: 15)
                }.frame(width: 50, height: 40).clipped()
                Text(card.cardName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                CardSearchResultManaCostView(manaCost: card.getManaCostArray())
            }.padding([.top, .bottom, .leading, .trailing], 8)
        })
    }
    
    struct CardSearchResultManaCostView: View {
        
        let manaCost: [String]
        
        var body: some View {
            HStack(spacing: 2) {
                ForEach(manaCost, id: \.self) {
                    Image($0)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

struct CardShowView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State var card: Card
    @State var cardType: CardType
    @State var hasCardFlashback: Bool
    @State var hasCardDefender: Bool
    
    private let gradient = Gradient(colors: [Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.3), Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.0)])
    
    private var selectedCard: Card {
        return deckEditorViewModel.changeCardToFitCardInSelectedDeck(card: self.getSelectedCardFromCarousel())
    }
    
    init(card: Card) {
        self.card = card
        self.cardType = card.cardType
        self.hasCardFlashback = card.hasFlashback
        self.hasCardDefender = card.hasDefender
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottom) {
                    // Card to show
                    CardToShowCarouselView(index: $deckEditorViewModel.carouselIndex.animation(), maxIndex: deckEditorViewModel.cardToShowReprints.count) {
                        if deckEditorViewModel.cardToShow != nil {
                            CarouselCardView(card: deckEditorViewModel.cardToShow!, delay: 0)
                        }
                        ForEach(0..<deckEditorViewModel.cardToShowReprints.count, id: \.self) {
                            CarouselCardView(card: deckEditorViewModel.cardToShowReprints[$0], delay: $0)
                        }
                    }
                    
                    // Add or Remove to selected deck
                    HStack {
                        Spacer()
                        Button(action: {
                            let tmpCard = selectedCard
                            tmpCard.cardType = self.cardType
                            tmpCard.hasFlashback = self.hasCardFlashback
                            tmpCard.hasDefender = self.hasCardDefender
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
                                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                        }).scaleEffect(1.5).disabled(!deckEditorViewModel.isRemoveOneCardButtonEnable(card: selectedCard))
                        
                        Spacer()
                        Spacer()
                        
                        Button(action: {
                            let tmpCard = selectedCard
                            tmpCard.cardType = self.cardType
                            tmpCard.hasFlashback = self.hasCardFlashback
                            tmpCard.hasDefender = self.hasCardDefender
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
                                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                        }).scaleEffect(1.5)
                        Spacer()
                    }.offset(y: 20)
                }.padding(10)
                
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom).frame(height: 60)
                
                // Return Button
                Button(action: {
                    deckEditorViewModel.cardToShow = nil
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                }).padding()
            }
            
            // Enable/Disable flashback
            
            Toggle(isOn: $hasCardFlashback) {
                VStack(alignment: .leading) {
                    Text("Cast from graveyard")
                        .foregroundColor(.white)
                        .font(.title3)
                    Text("then exile")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }
            .padding(20).padding(.top, 50)
            
            .onChange(of: deckEditorViewModel.carouselIndex) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.cardType = selectedCard.cardType
                    self.hasCardFlashback = selectedCard.hasFlashback
                    self.hasCardDefender = selectedCard.hasDefender
                }
            }.onChange(of: cardType) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.selectedCard.cardType = cardType
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
                    self.hasCardFlashback = selectedCard.hasFlashback
                    self.hasCardDefender = selectedCard.hasDefender
                }
            }.onChange(of: deckEditorViewModel.cardToShow) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.cardType = selectedCard.cardType
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
                            .font(.title3)
                    }
                }
                .padding(.horizontal, 20).padding(.top, 0).padding(.bottom, 20)
                
                // Select card type
                Text("Change card type")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                
                HStack {
                    CardShowTypeSelectorView(text: "Creature", cardType: .creature, cardShowedcardType: $cardType)
                    CardShowTypeSelectorView(text: "Token", cardType: .token, cardShowedcardType: $cardType)
                }.padding()
            }
            
            Spacer()
            
        }
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

struct CardShowTypeSelectorView: View {
    
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
                .font(.title3)
                .foregroundColor(cardShowedcardType == cardType ? .white : .gray)
                .padding(.vertical, 15)
        }).frame(maxWidth: .infinity)
    }
}

struct TopControlRowView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    DeckListSelectorView(deckListName: "Horde Deck", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.deckList)
                    Spacer()
                    DeckListSelectorView(deckListName: "Lategame cards", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList)
                    Spacer()
                    DeckListSelectorView(deckListName: "Tokens available", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.availableTokensList)
                }
                Spacer()
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 1, height: 30)
                Spacer()
                DeckListSelectorView(deckListName: "Weak", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList)
                Spacer()
                DeckListSelectorView(deckListName: "Powerful", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList)
            }.frame(height: 40).padding([.leading, .trailing], 20)
            
            HStack() {
                MenuTextParagraphView(text: deckEditorViewModel.deckSelectionInfo)
                Spacer()
                MenuTextParagraphView(text: deckEditorViewModel.cardCountForSelectedDeck)
            }.frame(height: 20)
        }.padding([.leading, .trailing], 15)
    }
}

struct DeckListSelectorView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let deckListName: String
    let deckListNumber: Int
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    deckEditorViewModel.changeSelectedDeckTo(newSelectedDeck: deckListNumber)
                }
            }, label: {
                Text(deckListName)
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(deckEditorViewModel.selectedDeckListNumber == deckListNumber ? .white : .gray)
            })
        }
    }
}

struct TopTopControlRowView: View {
    
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
                    withAnimation(.easeInOut(duration: 0.5)) {
                        deckEditorViewModel.showDeckEditorInfoView.toggle()
                    }
                } else {
                    deckEditorViewModel.popUpText = "Premium required"
                }
            }, label: {
                HStack {
                    Text(deckName)
                        .font(.title2)
                        .foregroundColor(.white)
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
                }.padding(.leading, 30).padding(.trailing, 80) // To make the button bigger
            })

            if !deckEditorViewModel.isReadOnly {
                // Save
                Button(action: {
                    deckEditorViewModel.saveDeck()
                }, label: {
                    HStack {
                        Text("Save")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Image(systemName: "arrow.down.doc")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }).padding(.leading, 30).padding(.trailing, 80) // To make the button bigger
                    .opacity(deckEditorViewModel.showSaveButton ? 1 : 0)
            }
            
            Spacer()
            
            if !deckEditorViewModel.isReadOnly {
                // Import
                Button(action: {
                    deckEditorViewModel.importDeckFromClipboard()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                
                Text("/")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            // Export
            Button(action: {
                deckEditorViewModel.exportDeckToClipboard()
            }, label: {
                Image(systemName: "doc.on.doc")
                    .font(.title3)
                    .foregroundColor(.white)
            })
            
            Text("/")
                .font(.title2)
                .foregroundColor(.white)
            
            ShareOnDiscordView()
            
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
            })
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
        }.padding(10)
    }
}

struct DeckListView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    var deckListToShow: [Card] {
        if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.availableTokensList {
            return deckEditorViewModel.deck.availableTokensList + deckEditorViewModel.deck.deckList.tokens
        } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList {
            return deckEditorViewModel.deck.weakPermanentsList
        } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList {
            return deckEditorViewModel.deck.powerfullPermanentsList
        }
        return []
    }
    
    var body: some View {
        // Show the current selected list
        if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.deckList {
            ScrollView(.horizontal, showsIndicators: false) {
                DeckListMainDeckView()
                    .animation(Animation.easeInOut(duration: 0.5), value: deckListToShow)
            }
        } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList {
            ScrollView(.horizontal, showsIndicators: false) {
                DeckListTooStrongView()
                    .animation(Animation.easeInOut(duration: 0.5), value: deckListToShow)
            }
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                    ForEach(deckListToShow) { card in
                        Button(action: {
                            deckEditorViewModel.showCard(card: card)
                        }, label: {
                            CardOnDeckListView(card: card, showCardCount: !(deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.availableTokensList))
                        }).transition(.scale.combined(with: .opacity)).disabled(deckEditorViewModel.isReadOnly)
                    }
                }.padding([.leading, .trailing], 10).padding(.bottom, 10)
            }.animation(Animation.easeInOut(duration: 0.5), value: deckListToShow)
        }
    }
}

struct CarouselCardView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let card: Card
    let delay: Int
    @State var showCard: Bool = false
    
    var body: some View {
        if showCard {
            CardView(card: card, shouldImageBeSaved: false)
                .aspectRatio(contentMode: .fit)
                .frame(width: EditorSize.cardToShowWidth, height: EditorSize.cardToShowHeight)
                .cornerRadius(EditorSize.cardToShowCornerRadius)
        } else {
            Rectangle().opacity(0.000001)
                .onAppear() {
                    Timer.scheduledTimer(withTimeInterval: Double(delay) * 0.1, repeats: false) { timer in
                        self.showCard = true
                    }
                }
        }
    }
}

struct CardToShowCarouselView<Content>: View where Content: View {

    @Binding var index: Int
    let maxIndex: Int
    let content: () -> Content

    @State private var offset = CGFloat.zero
    @State private var dragging = false

    init(index: Binding<Int>, maxIndex: Int, @ViewBuilder content: @escaping () -> Content) {
        self._index = index
        self.maxIndex = maxIndex
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.index) * (geometry.size.width + 10) + value.translation.width
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.index) * (geometry.size.width + 10) + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -(geometry.size.width + 10)))
                        self.index = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeOut) {
                            self.dragging = false
                        }
                    }
                )
            }.frame(height: EditorSize.cardToShowHeight)
            .clipped()

            PageControl(index: $index, maxIndex: maxIndex)
                .offset(y: UIDevice.current.userInterfaceIdiom == .pad ? 45 : 40)
        }
    }

    func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.maxIndex) * (geometry.size.width + 10))
        } else {
            return -CGFloat(self.index) * (geometry.size.width + 10)
        }
    }

    func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.index - 1), self.index + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= maxIndex else { return maxIndex }
        return newIndex
    }
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        VStack() {
            /*
             Dot style
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.gray)
                    .frame(width: 8, height: 8)
            }
             */
            if maxIndex > 0 {
                Text("swipe")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    
                Text("\(index + 1)/\(maxIndex + 1)")
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }.scaleEffect(UIDevice.current.userInterfaceIdiom == .pad ? 1 : 0.7)
        .padding(15)
        .animation(nil)
    }
}

struct DeckListMainDeckView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        HStack(spacing: 80) {
            ForEach(0..<4, id: \.self) { i in
                if deckEditorViewModel.getAllDecksInMainDeckList()[i].count > 0 {
                    LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                        ForEach(deckEditorViewModel.getAllDecksInMainDeckList()[i]) { card in
                            Button(action: {
                                deckEditorViewModel.showCard(card: card)
                            }, label: {
                                CardOnDeckListView(card: card)
                            }).transition(.scale.combined(with: .opacity)).disabled(deckEditorViewModel.isReadOnly)
                        }
                    }.padding([.leading, .trailing], 10).padding(.bottom, 10)
                }
            }
        }
    }
}

struct DeckListTooStrongView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        HStack(spacing: 80) {
            ForEach(0..<4, id: \.self) { i in
                if deckEditorViewModel.getAllDecksInMainDeckList()[i].count > 0 {
                    LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                        ForEach(deckEditorViewModel.getAllDecksInMainDeckList()[i]) { card in
                            Button(action: {
                                deckEditorViewModel.addCardToSelectedDeck(card: card)
                            }, label: {
                                CardOnDeckListView(card: card)
                                    .opacity(deckEditorViewModel.deck.tooStrongPermanentsList.contains(card) ? 1 : 0.5)
                            }).transition(.scale.combined(with: .opacity)).disabled(deckEditorViewModel.isReadOnly)
                        }
                    }.padding([.leading, .trailing], 10).padding(.bottom, 10)
                }
            }
        }
    }
}

struct CardOnDeckListView: View {
    
    let card: Card
    private var showCardCount: Bool
    
    init(card: Card, showCardCount: Bool = true) {
        self.card = card
        self.showCardCount = showCardCount
    }
    
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                .cornerRadius(CardSize.cornerRadius.normal)
            if card.cardCount > 1 && showCardCount{
                Text("x\(card.cardCount)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
            }
            if card.hasFlashback {
                Image(systemName: "arrow.clockwise")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                    .offset(x: CardSize.width.normal / 3, y: -CardSize.height.normal / 3)
            }
            if card.hasDefender {
                Text("Can't attack")
                    .headline()
                    .padding()
                    .blurredBackground()
                    .offset(y: -CardSize.height.normal / 6)
            }
        }
        .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
        .onChange(of: card.cardCount) { _ in
            print("Change detected")
        }
    }
}

struct DeckEditorView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckEditorView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            DeckEditorView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
        }
    }
}

struct EditorSize {
    static let cardSearchPanelWidth: CGFloat = CardSize.width.normal + 80
    static let cardToShowWidth: CGFloat = (cardSearchPanelWidth - 20) as CGFloat
    static let cardToShowHeight: CGFloat = cardToShowWidth * (8.8 / 6.3) as CGFloat
    static let cardToShowCornerRadius: CGFloat = cardToShowWidth * 0.058 as CGFloat
}
