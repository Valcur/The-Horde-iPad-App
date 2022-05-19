//
//  ContentView.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var castedCardViewOpacity: CGFloat = 0
    @State var graveyardViewOpacity: CGFloat = 0
    @State var gameIntroViewOpacity: CGFloat = 1
    let gradient = Gradient(colors: [Color("GradientLightColor"), Color("GradientDarkColor")])
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HordeBoardView()
                    //.frame(height: UIScreen.main.bounds.height - 89)
                    .frame(height: CardSize.height.normal * 2 + 60)
                
                Spacer()
                
                ControlBarView()
            }.ignoresSafeArea()
            
            if gameViewModel.damageTakenThisTurn > 0 {
                Text("Damage taken by the horde this turn : \(gameViewModel.damageTakenThisTurn)")
                    .fontWeight(.bold)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 300)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                    .position(x: UIScreen.main.bounds.width / 2, y: 70)
            }

            CastedCardView()
                .opacity(castedCardViewOpacity)
                .ignoresSafeArea()
                .onChange(of: gameViewModel.turnStep) { _ in
                    if gameViewModel.turnStep == 1 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            castedCardViewOpacity = 1
                        }
                    }
                    if gameViewModel.turnStep == 2 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            castedCardViewOpacity = 0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                gameViewModel.cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImage: ""))
                            }
                        }
                    }
                }
            
            GraveyardView()
                .opacity(graveyardViewOpacity)
                .ignoresSafeArea()
                .onChange(of: gameViewModel.showGraveyard) { _ in
                    if gameViewModel.showGraveyard {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            graveyardViewOpacity = 1
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            graveyardViewOpacity = 0
                        }
                    }
                }
            
            GameIntroView()
                .opacity(gameIntroViewOpacity)
                .ignoresSafeArea()
                .onChange(of: gameViewModel.turnStep) { _ in
                    if gameViewModel.turnStep != 0 {
                        withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                            gameIntroViewOpacity = 0
                        }
                    }
                }
            
        }.ignoresSafeArea()
    }
}

struct HordeBoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    let cardThickness: CGFloat = 0.4
    
    var body: some View {
        HStack {
            VStack(spacing: 40) {

                // Graveyard
                
                ZStack {
                    if gameViewModel.cardsOnGraveyard.count > 0 {
                        Button(action: {
                            print("Show Graveyard")
                            gameViewModel.showGraveyard = true
                        }, label: {
                            CardView(cardName: gameViewModel.cardsOnGraveyard.last!.cardName, imageUrl: gameViewModel.cardsOnGraveyard.last!.cardImage)
                                .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                                .cornerRadius(15)
                        })
                    } else {
                        RoundedRectangle(cornerRadius: CardSize.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                            .opacity(0.5)
                    }
                    Text("\(gameViewModel.cardsOnGraveyard.count)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                // Library
                
                ZStack {
                    if gameViewModel.deck.count > 0 {
                        Button(action: {
                            print("Library pressed")
                            gameViewModel.sendTopLibraryCardToGraveyard()
                        }, label: {
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .foregroundColor(Color("CardThicknessColor"))
                                    .cornerRadius(CardSize.cornerRadius.normal)
                                    .frame(width: CardSize.width.normal, height: CardSize.height.normal + CGFloat(gameViewModel.deck.count) * cardThickness)
                                
                                Image("BackgroundTest")
                                    .resizable()
                                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                                    .cornerRadius(CardSize.cornerRadius.normal)
                                    .offset(y: -CGFloat(gameViewModel.deck.count) * cardThickness)
                            }
                        }).frame(height: CardSize.height.normal).offset(y: -CGFloat(gameViewModel.deck.count) * cardThickness / 2).shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                    } else {
                        RoundedRectangle(cornerRadius: CardSize.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                            .opacity(0.5)
                    }

                    Text("\(gameViewModel.deck.count)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .offset(y: -CGFloat(gameViewModel.deck.count) * cardThickness)
                }
            }.frame(height: CardSize.height.normal * 2 + 50).padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 40), count: 2), alignment: .top, spacing: 15) {
                    ForEach(gameViewModel.cardsOnBoard) { card in
                        CardOnBoardView(card: card)
                            .transition(.scale.combined(with: .opacity))
                    }
                    /*
                    ForEach(0..<gameViewModel.cardsOnBoard.count, id: \.self) { i in
                        CardOnBoardView(card: gameViewModel.cardsOnBoard[i])
                            .transition(.asymmetric(insertion: AnyTransition.scale, removal: .offset(x: -floor(i / 2 + 1) * CardSize.width.normal, y: (i % 2) * CardSize.height.normal).combined(with: .opacity)))
                    }*/
                }.padding(.leading, 10).animation(Animation.easeInOut(duration: 0.5))
            }.frame(height: CardSize.height.normal * 2 + 50)
        }.frame(maxWidth: .infinity).padding(.leading, 10).padding(.top, 10)
    }
}

struct ControlBarView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var nexButtonDisable = false
    
    var body: some View {
        HStack {
            
            // Menu
             
            Button(action: {
                print("Menu button tapped")
                hordeAppViewModel.showMenu()
            }) {
                Image(systemName: "questionmark")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }.frame(maxWidth: .infinity)

            // Undo
            /*
            Button(action: {
                print("Undo button tapped")
            }) {
                Image(systemName: "arrow.counterclockwise")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }.frame(width: 80)
             */
            // BoardWipe
            
            HStack {
                Text("Destroy all")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.gray)
                    .padding(10)
                    .frame(width: 140)
                
                Button(action: {
                    print("Creatures Wipe button pressed")
                    gameViewModel.destroyAllCreatures()
                }, label: {
                    Text("Creatures")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 100)
                })
                
                Button(action: {
                    print("Permanents Wipe button pressed")
                    gameViewModel.destroyAllPermanents()
                }, label: {
                    Text("Permanents")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .frame(width: 100)
                })
            }//.frame(maxWidth: .infinity)
            
            // CreateToken
            
            HStack {
                Text("Create")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.gray)
                    .padding(10)
                    .frame(width: 140)
                ForEach(gameViewModel.tokensAvailable) { token in
                    Button(action: {
                        print("Create token button pressed")
                        gameViewModel.createToken(token: token)
                    }, label: {
                        CardView(cardName: token.cardName, imageUrl: token.cardImage)
                            .frame(width: CardSize.width.small, height: CardSize.height.small)
                            .cornerRadius(CardSize.cornerRadius.small)
                    })
                }
            }.frame(maxWidth: .infinity)
            
            // Next
            
            Button(action: {
                print("New turn pressed")
                gameViewModel.nextButtonPressed()
            }, label: {
                PurpleButtonLabel(text: "New Turn")
            }).disabled(gameViewModel.deck.count == 0 || nexButtonDisable)
                .onChange(of: gameViewModel.turnStep) { _ in
                    if gameViewModel.turnStep == 1 {
                        nexButtonDisable = true
                    }
                    if gameViewModel.turnStep == 2 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                nexButtonDisable = false
                            }
                        }
                    }
                }
        }
    }
}

struct CastedCardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        // The button to leave the menu is the background
        Button(action: {
            print("Next button pressed")
            gameViewModel.nextButtonPressed()
        }, label: {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        }).buttonStyle(StaticButtonStyle())
        
        VStack(spacing: 30) {
            // The cards to show
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 50) {
                    // Flahsback cards if any
                    if gameViewModel.cardsToCast.cardsFromGraveyard.count > 0 {
                        VStack {
                            Text("From Graveyard")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            HStack(spacing: 36) {
                                ForEach(gameViewModel.cardsToCast.cardsFromGraveyard) { card in
                                    CardToCastView(card: card)
                                }
                            }
                        }
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 2, height: CardSize.height.big / 2)
                            .padding(.top, 50)
                    }
                    
                    VStack {
                        Text("From Library")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(height: 50)
                        HStack(spacing: 36) {
                            // Library revealed non token card
                            /*
                            // Have to do this wierd thing otherwise the card from library don't update the cardOrder
                            if gameViewModel.cardsToCast.tokensFromLibrary.count == 0 && gameViewModel.cardsToCast.cardFromLibrary.cardType != .token{
                                FlippingCardView(card: gameViewModel.cardsToCast.cardFromLibrary, cardOrder: gameViewModel.cardsToCast.tokensFromLibrary.count, proxy: proxy)
                                    .id(0)
                            }

                            ForEach(0..<gameViewModel.cardsToCast.tokensFromLibrary.count, id: \.self) {
                                if $0 == 0 && gameViewModel.cardsToCast.cardFromLibrary.cardType != .token{
                                    FlippingCardView(card: gameViewModel.cardsToCast.cardFromLibrary, cardOrder: gameViewModel.cardsToCast.tokensFromLibrary.count, proxy: proxy)
                                        .id(0)
                                }
                                if $0 == gameViewModel.cardsToCast.tokensFromLibrary.count - 1 {
                                    FlippingCardView(card: gameViewModel.cardsToCast.tokensFromLibrary[$0], cardOrder: gameViewModel.cardsToCast.tokensFromLibrary.count - 1 - $0, proxy: proxy)
                                        .id(1)
                                } else {
                                    FlippingCardView(card: gameViewModel.cardsToCast.tokensFromLibrary[$0], cardOrder: gameViewModel.cardsToCast.tokensFromLibrary.count - 1 - $0, proxy: proxy)
                                }
                                
                            }.onChange(of: gameViewModel.cardsToCast.tokensFromLibrary.count) { _ in
                                proxy.scrollTo(1, anchor: .center)
                                withAnimation(.easeInOut(duration: 0.1 + 0.5 * Double((gameViewModel.cardsToCast.tokensFromLibrary.count)))) {
                                    proxy.scrollTo(0, anchor: .center)
                                }
                            }*/
                            
                            if gameViewModel.cardsToCast.cardFromLibrary.cardType != .token {
                                CardToCastView(card: gameViewModel.cardsToCast.cardFromLibrary)
                            }
                            ForEach(0..<gameViewModel.cardsToCast.tokensFromLibrary.count, id: \.self) {
                                CardToCastView(card: gameViewModel.cardsToCast.tokensFromLibrary[$0])
                            }
                        }.padding([.leading, .trailing], 30)
                    }
                }.frame(minWidth: UIScreen.main.bounds.width, minHeight: CardSize.height.normal + 160)
            }.onTapGesture {
                print("Next button pressed")
                gameViewModel.nextButtonPressed()
            }
        }
    }
}

struct GameIntroView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        // The button to leave the menu is the background
        Button(action: {
            print("Start game button pressed")
            gameViewModel.nextButtonPressed()
        }, label: {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        }).buttonStyle(StaticButtonStyle())
        
        VStack(spacing: 50) {
            
            MenuTextTitleView(text: "DeckSize")
            
            MenuTextParagraphView(text: "To adjust the challenge, you can reduce the library size depending on the number of players.")
            
            HStack(spacing: 50) {
                IntroPlayerChoiceButtonView(text: "100%", isSelected: true)
                IntroPlayerChoiceButtonView(text: "75%", isSelected: false)
                IntroPlayerChoiceButtonView(text: "50%", isSelected: false)
                IntroPlayerChoiceButtonView(text: "25%", isSelected: false)
            }
            
            MenuTextTitleView(text: "Alternate start")
            
            MenuTextParagraphView(text: "To increse the difficulty, you can make the horde start with 30 life points. The horde start to mill its library only when its lifepoints are equal to 0")
            
            MenuTextSubtitleView(text: "Play 3 turns before sarting the horde")
            
            MenuTextBoldParagraphView(text: "Touch anywhere to start the horde")
            
        }.frame(width: UIScreen.main.bounds.width / 2)
        .onTapGesture {
            print("Start game button pressed")
            gameViewModel.nextButtonPressed()
        }
    }
}

struct IntroPlayerChoiceButtonView: View {
    
    let text: String
    var isSelected: Bool
    
    var body: some View {
        Button(action: {
            print("Start game button pressed")
            //gameViewModel.nextButtonPressed()
        }, label: {
            Text(text)
                .foregroundColor(isSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(.title)
        })
    }
}

struct GraveyardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        // The button to leave the menu is the background
        Button(action: {
            print("Hide graveyard button pressed")
            gameViewModel.showGraveyard = false
        }, label: {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        }).buttonStyle(StaticButtonStyle())
        
        VStack(spacing: 30) {
            // The cards in the graveyard to show
            Text("Touch a permanent card to put it onto the battlefield")
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 50) {
                    Rectangle().frame(width: 40, height: 0)
                    ForEach(gameViewModel.cardsOnGraveyard) { card in
                        VStack(spacing: 15) {
                            Button(action: {
                                print("Exile card in graveyard button pressed")
                                gameViewModel.removeCardFromGraveyard(card: card)
                            }, label: {
                                Text("Exile")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                            })
                            Button(action: {
                                print("Card in graveyard pressed")
                                gameViewModel.castCardFromGraveyard(card: card)
                            }, label: {
                                CardToCastView(card: card)
                            })
                            Text("To library")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.gray)
                                .frame(height: 30)
                            HStack {
                                Button(action: {
                                    print("Put on top of library button pressed")
                                    gameViewModel.putOnTopOfLibrary(card: card)
                                }, label: {
                                    Text("Top")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(height: 30)
                                })
                                Rectangle().frame(width: 2, height: 20).foregroundColor(.white)
                                Button(action: {
                                    print("Shuffle into library button pressed")
                                    gameViewModel.shuffleIntofLibrary(card: card)
                                }, label: {
                                    Text("Shuffle")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(height: 30)
                                })
                                Rectangle().frame(width: 2, height: 20).foregroundColor(.white)
                                Button(action: {
                                    print("Put at the bottom of library button pressed")
                                    gameViewModel.putAtBottomOfLibrary(card: card)
                                }, label: {
                                    Text("Bottom")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(height: 40)
                                })
                            }
                        }
                    }
                    Rectangle().frame(width: 40, height: 0)
                }.frame(minWidth: UIScreen.main.bounds.width, minHeight: CardSize.height.normal + 220)
            }.onTapGesture {
                print("Hide graveyard button pressed")
                gameViewModel.showGraveyard = false
            }
        }
    }
}

struct CardView: View {
    @ObservedObject var downloadManager: DownloadManager
    @State var image:UIImage = UIImage()
    //var cardName: String
    //var imageUrl: String
    
    var CardImage: Image {
        if downloadManager.imageReadyToShow {
            return Image(uiImage: UIImage(data: downloadManager.data)!)
                
        }
        return Image("BackgroundTest")
    }
    
    init(cardName: String, imageUrl: String) {
        //self.imageUrl = imageUrl
        downloadManager = DownloadManager(cardName: cardName, urlString: imageUrl)
    }
    
    var body: some View {
        CardImage
            .resizable()
    }
}

struct CardToCastView: View {
    
    var card: Card
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            CardView(cardName: card.cardName, imageUrl: card.cardImage)
                .frame(width: CardSize.width.big, height: CardSize.height.big)
                .cornerRadius(CardSize.cornerRadius.big)
                .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
            if card.cardCount > 1 {
                Text("x\(card.cardCount)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
            }
        }.frame(height: CardSize.height.big + 60)
    }
}
/*
struct FlippingCardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @EnvironmentObject var gameViewModel: GameViewModel
    
    let duration : CGFloat = 0.5
    let delay: CGFloat
    let cardOrder: Int
    let proxy: ScrollViewProxy
    
    var card: Card
    
    init(card: Card, cardOrder: Int, proxy: ScrollViewProxy) {
        self.card = card
        self.cardOrder = cardOrder
        self.delay = 0.1 + CGFloat(cardOrder) * 0.5
        self.proxy = proxy
        print("\(card.cardType == .token ? "token" : "creature") : \(cardOrder)")
    }
    
    func flipCard () {
        withAnimation(.linear(duration: duration).delay(delay)) {
            backDegree = 90
        }
        withAnimation(.linear(duration: duration).delay(delay + duration)){
            frontDegree = 0
        }
    }
 
    var body: some View {
        ZStack {
            CardToCastView(card: card)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
            Image("BackgroundTest")
                .resizable()
                .frame(width: CardSize.width.big, height: CardSize.height.big)
                .cornerRadius(CardSize.cornerRadius.normal)
                .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
        }.id(cardOrder)
        .frame(height: CardSize.height.big + 200)
        .onChange(of: gameViewModel.turnStep) { _ in
            if gameViewModel.turnStep == 1 {
                backDegree = 0.0
                frontDegree = -90.0
                flipCard ()
            }
        }.onAppear() {
            flipCard ()
        }
    }
}
*/
struct CardOnBoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    var card: Card
    
    var body: some View {
        Button(action: {
            print("Remove card")
            gameViewModel.removeOneCardOnBoard(card: card)
        }, label: {
            ZStack {
                CardView(cardName: card.cardName, imageUrl: card.cardImage)
                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                    .cornerRadius(CardSize.cornerRadius.normal)
                if card.cardCount > 1 {
                    Text("x\(card.cardCount)")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                }
            }.shadow(color: Color("ShadowColor"), radius: 5, x: 0, y: 4)
        })
    }
}


// card's size is 6.3 by 8.8

struct CardSize {
    
    struct width {
        static let big = (UIScreen.main.bounds.height / 100) * 6.3 * 5.5 as CGFloat as CGFloat
        //static let normal = 226.8 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 6.3 * 4.5 as CGFloat
        static let small = 54 as CGFloat
    }
    
    struct height {
        static let big = (UIScreen.main.bounds.height / 100) * 8.8 * 5.5 as CGFloat as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 8.8 * 4.5 as CGFloat
        //static let normal = 316.8 as CGFloat
        static let small = 75 as CGFloat
    }
    
    struct cornerRadius {
        static let big = (UIScreen.main.bounds.height / 100) * 0.35 * 5.5 as CGFloat as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 0.35 * 4.5 as CGFloat
        //static let normal = 316.8 as CGFloat
        static let small = 3 as CGFloat
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView()
                .environmentObject(GameViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            GameView()
                .environmentObject(GameViewModel())
        }
    }
}

// Might remove this view, if no button have this style
struct PurpleButtonLabel: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.subheadline)
            .padding()
            .frame(width: 150)
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
            .cornerRadius(40)
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
    }
}

