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
    
    var body: some View {
        HStack(spacing: 0) {
            MainView()
            
            DeckView(selectedDeck: deckBrowserVM.selectedDeck).shadow(radius: 5)
        }.background(GradientView(gradientId: hordeAppViewModel.gradientId)).ignoresSafeArea()
    }
}

struct MainView: View {
    @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
    @State var searchText = ""
    var gridLayout = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    PurpleButtonLabel(text: "Exit")
                })
                Text("Explore")
                    .headline()
                
                Spacer()
      
                TextField("", text: $searchText)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    .cornerRadius(15).frame(maxWidth: 200)
                
                Button(action: {
                    deckBrowserVM.searchForDecks(withText: searchText)
                }, label: {
                    PurpleButtonLabel(text: "Search")
                })
            }
            Rectangle().frame(height: 1).foregroundColor(.white)
            ScrollView {
                LazyVGrid(columns: gridLayout) {
                    if deckBrowserVM.decks.count == 0 {
                        Text(deckBrowserVM.searchResultMessage)
                            .headline()
                    } else {
                        ForEach(deckBrowserVM.decks[0..<deckBrowserVM.decks.count]) { deck in
                            DeckView(deck: deck)
                        }
                    }
                }
            }.padding()
        }.padding(.horizontal, 8).padding(.vertical, 10)
    }
    
    struct DeckView: View {
        @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
        @ObservedObject var deck: DeckBrowserDeck
        
        var body: some View {
            Button(action: {
                deckBrowserVM.setSelectedDeck(deck)
            }, label: {
                ZStack {
                    if let image = deck.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
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
                }.cornerRadius(10)
            }).frame(height: 150).padding(5)
        }
    }
}

struct DeckView: View {
    let selectedDeck: DeckBrowserDeck?
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let deck = selectedDeck {
                    Text(deck.title)
                        .title()
                        .multilineTextAlignment(.leading)
                    
                    if let image = deck.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                    } else {
                        Color.black
                    }
                    
                    Button(action: {}, label: {
                        PurpleButtonLabel(text: "Play")
                    })
                    
                    Text(deck.intro)
                        .headline()
                    
                    Text("Special rules")
                        .title()
                    
                    Text(deck.rules)
                        .headline()
                    
                    HStack {
                        Button(action: {}, label: {
                            PurpleButtonLabel(text: "Decklist")
                        })
                        Button(action: {}, label: {
                            PurpleButtonLabel(text: "Add")
                        })
                    }
                    
                    Spacer()
                }
            }.padding()
        }.frame(width: 350).frame(maxHeight: .infinity).background(
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
    }
}



struct DeckBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckBrowserView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckBrowserViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        } else {
            DeckBrowserView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckBrowserViewModel())
        }
    }
}

extension Text {
    func title() -> Text {
        self
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    func headline() -> Text {
        self
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}
