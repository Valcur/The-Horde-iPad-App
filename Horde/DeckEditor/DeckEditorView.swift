//
//  DeckEditorView.swift
//  Horde
//
//  Created by Loic D on 11/07/2022.
//

import SwiftUI

struct DeckEditorView: View {
    
    var body: some View {
        HStack(spacing: 0) {
            LeftPanelView()
            RightPanelView()
                .frame(width: CardSize.width.normal + 80)
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
                DeckListView()
                BottomControlRowView()
            }
        }
    }
}

struct RightPanelView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        ZStack {
            Color.black
            GradientView(gradientId: hordeAppViewModel.gradientId)
                .opacity(0.8)
            VStack {
                CardSearchView()
            }.padding(10)
        }.ignoresSafeArea()
    }
}

struct CardSearchView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State private var cardSearchTextFieldText: String = ""
    @State private var isSearchingForTokens: Bool = false
    
    var body: some View {
        VStack {
            // TextField + Selector token/non-token
            HStack {
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
                    }
                }
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(.gray)
                Button(action: {
                    isSearchingForTokens.toggle()
                }, label: {
                    Text("Tokens")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(isSearchingForTokens ? .white : .gray)
                })
            }.frame(height: 50)
            
            // Search result
            ScrollView {
                VStack(spacing: 0) {
                    CardSearchResultView(cardName: "AAA")
                    CardSearchResultView(cardName: "AAA")
                    CardSearchResultView(cardName: "AAA")
                    CardSearchResultView(cardName: "AAA")
                    CardSearchResultView(cardName: "AAA")
                    CardSearchResultView(cardName: "AAA")
                }
            }
        }
    }
}

struct CardSearchResultView: View {
    
    let cardName: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Text(cardName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
            }.padding([.top, .bottom], 6)
        })
    }
}

struct CardShowView: View {
    var body: some View {
        VStack {
            // Return Button
            
            // Card to show
            
            // Select card type
            
            // Add or Remove to selected deck
        }
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
        }.padding([.leading, .trailing, .top], 20)
    }
}

struct DeckListSelectorView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    let deckListName: String
    let deckListNumber: Int
    
    var body: some View {
        VStack {
            Button(action: {
                deckEditorViewModel.changeSelectedDeckTo(newSelectedDeck: deckListNumber)
            }, label: {
                Text(deckListName)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(deckEditorViewModel.selectedDeckList == deckListNumber ? .white : .gray)
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
        }.frame(height: 50).padding([.leading, .trailing, .bottom], 20)
    }
}

struct DeckListView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    var deckListToShow: [Card] {
        if deckEditorViewModel.selectedDeckList == DeckEditorViewModel.DeckSelectionNumber.deckList {
            return deckEditorViewModel.deck.deckList
        } else if deckEditorViewModel.selectedDeckList == DeckEditorViewModel.DeckSelectionNumber.tooStrongPermanentsList {
            return deckEditorViewModel.deck.tooStrongPermanentsList
        } else if deckEditorViewModel.selectedDeckList == DeckEditorViewModel.DeckSelectionNumber.availableTokensList {
            return deckEditorViewModel.deck.availableTokensList
        } else if deckEditorViewModel.selectedDeckList == DeckEditorViewModel.DeckSelectionNumber.weakPermanentsList {
            return deckEditorViewModel.deck.weakPermanentsList
        } else if deckEditorViewModel.selectedDeckList == DeckEditorViewModel.DeckSelectionNumber.powerfullPermanentsList {
            return deckEditorViewModel.deck.powerfullPermanentsList
        }
        return []
    }
    
    var body: some View {
        // Show the current selected list
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 0), count: 2), alignment: .top, spacing: 15) {
                ForEach(deckListToShow) { card in
                    CardOnBoardView(card: card)
                        .transition(.scale.combined(with: .opacity))
                }
            }.padding(.leading, 10).animation(Animation.easeInOut(duration: 0.5), value: deckListToShow)
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
