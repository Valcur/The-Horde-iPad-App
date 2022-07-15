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
            HStack(spacing: 0) {
                LeftPanelView()
                if deckEditorViewModel.selectedDeckListNumber != DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList {
                    RightPanelView()
                        .frame(width: CardSize.width.normal + 80)
                        .transition(.move(edge: .trailing))
                }
            }
        }.ignoresSafeArea()
    }
}

struct LeftPanelView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId)
            VStack {
                TopControlRowView()
                Spacer()
                DeckListView()
                Spacer()
                BottomControlRowView()
            }.ignoresSafeArea()
        }
    }
}

struct RightPanelView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        ZStack {
            Color.black
            GradientView(gradientId: hordeAppViewModel.gradientId)
                .opacity(0.8)
            
            if deckEditorViewModel.cardToShow == nil {
                CardSearchView().padding(10)
            } else {
                CardShowView(card: deckEditorViewModel.cardToShow!).padding(10)
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

                Button(action: {
                    isSearchingForTokens.toggle()
                }, label: {
                    Text("Tokens")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(isSearchingForTokens ? .white : .gray)
                })
            }.ignoresSafeArea(.keyboard)
            
            // Search result
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(deckEditorViewModel.searchResult, id: \.self) { card in
                        CardSearchResultView(card: card)
                    }
                }
            }.ignoresSafeArea(.keyboard)
        }
    }
}

struct CardSearchResultView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let card: Card
    
    var body: some View {
        Button(action: {
            deckEditorViewModel.cardToShow = card
        }, label: {
            HStack {
                Text(card.cardName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
            }.padding([.top, .bottom], 6)
        })
    }
}

struct CardShowView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State var card: Card
    @State var cardType: CardType
    
    init(card: Card) {
        self.card = card
        self.cardType = card.cardType
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                ZStack(alignment: .bottom) {
                    // Card to show
                    CardView(card: card)
                        //.frame(width: CardSize.width.normal, height: CardSize.height.normal)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(CardSize.cornerRadius.normal)
                        .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                    
                    // Add or Remove to selected deck
                    HStack {
                        Spacer()
                        Button(action: {
                            if deckEditorViewModel.removeCardShouldBeAnimated() {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    deckEditorViewModel.removeCardFromSelectedDeck(card: self.card)
                                }
                            } else {
                                deckEditorViewModel.removeCardFromSelectedDeck(card: self.card)
                            }
                        }, label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                        }).scaleEffect(1.5).disabled(!deckEditorViewModel.isRemoveOneCardButtonEnable())
                        
                        Spacer()
                        
                        Button(action: {
                            if deckEditorViewModel.addCardShouldBeAnimated() {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    deckEditorViewModel.addCardToSelectedDeck(card: self.card)
                                }
                            } else {
                                deckEditorViewModel.addCardToSelectedDeck(card: self.card)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                        }).scaleEffect(1.5)
                        Spacer()
                    }.offset(y: 20)
                }
                
                // Return Button
                Button(action: {
                    deckEditorViewModel.cardToShow = nil
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }).padding()
            }
            
            //Spacer()
            
            // Select card type
            MenuTextParagraphView(text: "Change card type").padding(.top, 50)
            
            VStack(spacing: 10) {
                HStack {
                    CardShowTypeSelectorView(text: "Creature", cardType: .creature, cardShowedcardType: $cardType)
                    CardShowTypeSelectorView(text: "Token", cardType: .token, cardShowedcardType: $cardType)
                }
                HStack {
                    CardShowTypeSelectorView(text: "Instant", cardType: .instant, cardShowedcardType: $cardType)
                    CardShowTypeSelectorView(text: "Sorcery", cardType: .sorcery, cardShowedcardType: $cardType)
                }
                HStack {
                    CardShowTypeSelectorView(text: "Artifact", cardType: .artifact, cardShowedcardType: $cardType)
                    CardShowTypeSelectorView(text: "Enchantment", cardType: .enchantment, cardShowedcardType: $cardType)
                }
            }.padding().onChange(of: card) { _ in
                self.cardType = self.card.cardType
            }.onChange(of: cardType) { _ in
                self.card.cardType = cardType
            }.onChange(of: deckEditorViewModel.cardToShow) { _ in
                if deckEditorViewModel.cardToShow != nil {
                    self.card = deckEditorViewModel.cardToShow!
                }
            }
            
            // Enable/Disable flashback
            
            Toggle("Should this card be cast by the Horde from graveyard ? (like flashback)", isOn: $card.hasFlashback)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
        }
    }
}

struct CardShowTypeSelectorView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    var text: String
    var cardType: CardType
    @Binding var cardShowedcardType: CardType
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                deckEditorViewModel.changeCardTypeFromSelectedDeck(card: deckEditorViewModel.cardToShow!, newCardType: cardType)
                cardShowedcardType = cardType
            }
        }, label: {
            Text(text)
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(cardShowedcardType == cardType ? .white : .gray)
        }).frame(maxWidth: .infinity)
    }
}

struct TopControlRowView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        VStack {
            HStack() {
                DeckListSelectorView(deckListName: "Deck", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.deckList)
                Spacer()
                DeckListSelectorView(deckListName: "Strong", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList)
                Spacer()
                DeckListSelectorView(deckListName: "Tokens", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.availableTokensList)
                Spacer()
                DeckListSelectorView(deckListName: "Weak", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList)
                Spacer()
                DeckListSelectorView(deckListName: "Powerfull", deckListNumber: DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList)
            }.frame(height: 50)
            
            HStack() {
                MenuTextParagraphView(text: deckEditorViewModel.deckSelectionInfo)
                Spacer()
            }.frame(height: 30)
        }.padding([.leading, .trailing, .top], 10)
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
                    .font(.title2)
                    .foregroundColor(deckEditorViewModel.selectedDeckListNumber == deckListNumber ? .white : .gray)
            })
        }
    }
}

struct BottomControlRowView: View {
    var body: some View {
        HStack {
            MenuTextSubtitleView(text: "Exit")
            Spacer()
            MenuTextSubtitleView(text: "Import")
            MenuTextSubtitleView(text: "Export")
        }.padding([.leading, .trailing, .bottom], 10).frame(height: 50)
    }
}

struct DeckListView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    var deckListToShow: [Card] {
        if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.availableTokensList {
            return deckEditorViewModel.deck.availableTokensList
        } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList {
            return deckEditorViewModel.deck.weakPermanentsList
        } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList {
            return deckEditorViewModel.deck.powerfullPermanentsList
        }
        return []
    }
    
    var body: some View {
        // Show the current selected list
        ScrollView(.horizontal, showsIndicators: false) {
            if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.deckList {
                DeckListMainDeckView()
                    .animation(Animation.easeInOut(duration: 0.5), value: deckListToShow).frame(height: CardSize.height.normal * 2)
            } else if deckEditorViewModel.selectedDeckListNumber == DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList {
                DeckListTooStrongView()
                    .animation(Animation.easeInOut(duration: 0.5), value: deckListToShow).frame(height: CardSize.height.normal * 2)
            } else {
                LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                    ForEach(deckListToShow) { card in
                        Button(action: {
                            deckEditorViewModel.cardToShow = card
                        }, label: {
                            CardOnDeckListView(card: card)
                        }).transition(.scale.combined(with: .opacity))
                    }
                }.padding(.leading, 10).animation(Animation.easeInOut(duration: 0.5), value: deckListToShow).frame(height: CardSize.height.normal * 2)
            }
        }
    }
}

struct DeckListMainDeckView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        HStack(spacing: 40) {
            // Creatures
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 10), spacing: 20), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.creatures) { card in
                    Button(action: {
                        deckEditorViewModel.cardToShow = card
                    }, label: {
                        CardOnDeckListView(card: card)
                    }).transition(.scale.combined(with: .opacity))
                }
            }
            // Artifacts and Enchantments
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.artifactsAndEnchantments) { card in
                    Button(action: {
                        deckEditorViewModel.cardToShow = card
                    }, label: {
                        CardOnDeckListView(card: card)
                    }).transition(.scale.combined(with: .opacity))
                }
            }
            // Instant and Sorceries
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.instantsAndSorceries) { card in
                    Button(action: {
                        deckEditorViewModel.cardToShow = card
                    }, label: {
                        CardOnDeckListView(card: card)
                    }).transition(.scale.combined(with: .opacity))
                }
            }
            // Tokens
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.tokens) { card in
                    Button(action: {
                        deckEditorViewModel.cardToShow = card
                    }, label: {
                        CardOnDeckListView(card: card)
                    }).transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

struct DeckListTooStrongView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    
    var body: some View {
        HStack(spacing: 40) {
            // Creatures
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 10), spacing: 20), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.creatures) { card in
                    Button(action: {
                        deckEditorViewModel.addCardToSelectedDeck(card: card)
                    }, label: {
                        CardOnDeckListView(card: card)
                            .transition(.scale.combined(with: .opacity))
                            .opacity(deckEditorViewModel.deck.tooStrongPermanentsList.contains(card) ? 1 : 0.5)
                    })
                }
            }
            // Artifacts and Enchantments
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.artifactsAndEnchantments) { card in
                    Button(action: {
                        deckEditorViewModel.addCardToSelectedDeck(card: card)
                    }, label: {
                        CardOnDeckListView(card: card)
                            .transition(.scale.combined(with: .opacity))
                            .opacity(deckEditorViewModel.deck.tooStrongPermanentsList.contains(card) ? 1 : 0.5)
                    })
                }
            }
            // Instant and Sorceries
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.instantsAndSorceries) { card in
                    Button(action: {
                        deckEditorViewModel.addCardToSelectedDeck(card: card)
                    }, label: {
                        CardOnDeckListView(card: card)
                            .transition(.scale.combined(with: .opacity))
                            .opacity(deckEditorViewModel.deck.tooStrongPermanentsList.contains(card) ? 1 : 0.5)
                    })
                }
            }
            // Tokens
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal - 5), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckEditorViewModel.deck.deckList.tokens) { card in
                    Button(action: {
                        deckEditorViewModel.addCardToSelectedDeck(card: card)
                    }, label: {
                        CardOnDeckListView(card: card)
                            .transition(.scale.combined(with: .opacity))
                            .opacity(deckEditorViewModel.deck.tooStrongPermanentsList.contains(card) ? 1 : 0.5)
                    })
                }
            }
        }
    }
}

struct CardOnDeckListView: View {
    
    var card: Card
    
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                .cornerRadius(CardSize.cornerRadius.normal)
            if card.cardCount > 1 {
                Text("x\(card.cardCount)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
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
