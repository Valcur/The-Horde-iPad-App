//
//  DeckBrowserView.swift
//  Horde
//
//  Created by Loic D on 19/06/2023.
//

import SwiftUI

struct DeckBrowserView: View {
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
        
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                MainView().padding(.leading, safeAreaInsets.leading)
                
                SelectedDeckView(selectedDeck: deckBrowserVM.selectedDeck).shadow(radius: 5)
            }.background(GradientView(gradientId: hordeAppViewModel.gradientId, colorOnly: true))
        }
    }
}

struct MainView: View {
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
    @State var searchText = ""
    var gridLayout: [GridItem] {
        if UIDevice.isIPhone {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
        return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    hordeAppViewModel.showDeckBrowser = 0
                }, label: {
                    PurpleButtonLabel(text: "Exit")
                }).iPhoneScaler(maxHeight: 50, maxWidth: 100, anchor: .leading).padding(.leading, 10)
                
                Spacer()
      
                HStack {
                    TextField("", text: $searchText, onCommit: {
                        deckBrowserVM.searchForDecks(withText: searchText)
                    })
                    .font(.title3)
                    .foregroundColor(.white)
                    .placeholder("Search for decks", when: searchText.isEmpty)
                    .padding(.horizontal, 15).padding(.vertical, 12)
                    .blurredBackground().frame(width: 200)
                    
                    Button(action: {
                        deckBrowserVM.searchForDecks(withText: searchText)
                    }, label: {
                        PurpleButtonLabel(text: "Search")
                    })
                }.iPhoneScaler(maxHeight: 50, maxWidth: 290, anchor: .trailing).offset(x: UIDevice.isIPhone ? -15 : 0)
            }
            //Rectangle().frame(height: 1).foregroundColor(.white)
            ScrollView {
                VStack {
                    if deckBrowserVM.resultStatus == .progress {
                        Text(deckBrowserVM.searchResultMessage)
                            .headline()
                            .iPhoneScaler(maxHeight: 50, anchor: .leading)
                    } else {
                        if deckBrowserVM.resultStatus == .error {
                            HStack {
                                Text("Error")
                                    .headline()
                                    .iPhoneScaler(maxHeight: 50, anchor: .leading)
                                
                                Spacer()
                                
                                Button(action: {
                                    deckBrowserVM.iniRecentDecks()
                                }, label: {
                                    PurpleButtonLabel(text: "Return")
                                }).iPhoneScaler(maxHeight: 50, anchor: .trailing)
                            }
                        } else if deckBrowserVM.resultStatus == .nameSearch {
                            HStack {
                                Text(deckBrowserVM.decks.count == 0 ? "No result found for \(searchText)" : "Search result for \(searchText)")
                                    .headline()
                                    .iPhoneScaler(maxHeight: 50, anchor: .leading)
                                
                                Spacer()
                                
                                Button(action: {
                                    deckBrowserVM.iniRecentDecks()
                                }, label: {
                                    PurpleButtonLabel(text: "Return")
                                }).iPhoneScaler(maxHeight: 50, anchor: .trailing)
                            }
                        }
                        LazyVGrid(columns: gridLayout) {
                            ForEach(deckBrowserVM.decks[0..<deckBrowserVM.decks.count]) { deck in
                                DeckView(deck: deck)
                            }

                            if deckBrowserVM.resultStatus == .mostRecent {
                                Button(action: {
                                    deckBrowserVM.seeAllDecks()
                                }, label: {
                                    PurpleButtonLabel(text: "See all")
                                })
                            }
                        }
                    }
                }.padding()//.iPhoneScaler(maxHeight: .infinity, scaleEffect: 0.95, anchor: .topTrailing)
            }
        }
    }
    
    struct DeckView: View {
        @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
        @ObservedObject var deck: DeckBrowserDeck
        
        var body: some View {
            Button(action: {
                deckBrowserVM.setSelectedDeck(deck)
            }, label: {
                ZStack {
                    GeometryReader { geo in
                        if let image = deck.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: 150)
                        } else {
                            Color.black
                        }
                        
                        Color.black.opacity(0.2)
                        VStack(alignment: .leading) {
                            Text(deck.title)
                                .title()
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Text(deck.author)
                                .headline()
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.padding(5)
                    }
                }.cornerRadius(10)
            }).frame(height: 150).padding(5).shadowed()
        }
    }
}

struct SelectedDeckView: View {
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
    @State var progressMessage = ""
    let selectedDeck: DeckBrowserDeck?
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                if let deck = selectedDeck {
                    Text(deck.title)
                        .title()
                        .multilineTextAlignment(.leading)
                    
                    if let image = deck.image {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIDevice.isIPhone ? 230 : 330, height: UIDevice.isIPhone ? 150 : 250)
                                .clipped()
                            HStack {
                                Button(action: {}, label: {
                                    PurpleButtonLabel(text: "Like", isPrimary: true)
                                })
                                if deck.likes.count > 0 {
                                    Text("\(deck.likes.count)")
                                        .headline()
                                    Image(systemName: "heart.fill")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    } else {
                        Color.black
                            .frame(width: UIDevice.isIPhone ? 230 : 330, height: UIDevice.isIPhone ? 150 : 250)
                    }
                    
                    Button(action: {
                        deckBrowserVM.playWithSelectedDeck()
                        hordeAppViewModel.readyToPlay = true
                    }, label: {
                        PurpleButtonLabel(text: "Play", isPrimary: true)
                    })
                    
                    if deck.intro.count > 0 {
                        Text(deck.intro)
                            .text()
                    }
                    
                    if deck.rules.count > 0 {
                        Text("Special rules")
                            .headline()
                        
                        Text(deck.rules)
                            .text()
                    }
                    
                    Text(progressMessage)
                        .headline()
                    
                    HStack {
                        Button(action: {
                            hordeAppViewModel.showDeckEditor = true
                        }, label: {
                            PurpleButtonLabel(text: "Decklist")
                        })
                        if deck.image != nil && progressMessage != "Deck added" {
                            Button(action: {
                                deckBrowserVM.addToYourDecks(progressMessage: $progressMessage)
                            }, label: {
                                PurpleButtonLabel(text: "Add")
                            })
                        }
                    }
                    
                    Spacer()
                }
            }.padding(.horizontal, 10).padding(.top, 15)
        }.frame(width: UIDevice.isIPhone ? 250 : 350)
            .padding(.trailing, safeAreaInsets.leading)
            .frame(maxHeight: .infinity).background(
            ZStack {
                if let deck = selectedDeck {
                    if let image = deck.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color.black
                    }
                }
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
            }.allowsHitTesting(false)
        ).clipped()
        .onChange(of: selectedDeck) { _ in
            progressMessage = ""
        }
    }
}

struct DeckBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckBrowserView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckBrowserViewModel(hordeVM: HordeAppViewModel()))
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        } else {
            DeckBrowserView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckBrowserViewModel(hordeVM: HordeAppViewModel()))
        }
    }
}
