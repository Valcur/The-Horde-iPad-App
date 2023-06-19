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
                Text("Explore")
                    .headline()
                
                Spacer()
      
                TextField("", text: $searchText)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    .cornerRadius(15).frame(maxWidth: 200)
                
                Button(action: {}, label: {
                    PurpleButtonLabel(text: "Search")
                })
            }
            Rectangle().frame(height: 1).foregroundColor(.white)
            ScrollView {
                LazyVGrid(columns: gridLayout) {
                    ForEach(deckBrowserVM.decks[0..<deckBrowserVM.decks.count]) { deck in
                        DeckView(deck: deck)
                    }
                }
            }.padding()
        }.padding()
    }
    
    struct DeckView: View {
        @EnvironmentObject var deckBrowserVM: DeckBrowserViewModel
        let deck: DeckBrowserDeck
        var body: some View {
            Button(action: {
                deckBrowserVM.setSelectedDeck(deck)
            }, label: {
                ZStack {
                    Color.black
                    Image(deck.artId)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                    Color.black.opacity(0.3)
                    VStack(alignment: .leading) {
                        Text(deck.title)
                            .title()
                        Spacer()
                        Text(deck.author)
                            .headline()
                    }
                }.cornerRadius(10)
            }).frame(height: 200).padding()
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
                    
                    Image(deck.artId)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                    Text(deck.intro)
                        .headline()
                    
                    Text("Special rules")
                        .title()
                    
                    Text(deck.rules)
                        .headline()
                    
                    Spacer()
                }
            }.padding()
        }.frame(width: 350).frame(maxHeight: .infinity).background(
            ZStack {
                if let deck = selectedDeck {
                    Image(deck.artId)
                        .resizable()
                        .scaledToFill()
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
