//
//  ContentView.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

struct GameView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var castedCardViewOpacity: CGFloat = 0
    @State var graveyardViewOpacity: CGFloat = 0
    @State var gameIntroViewOpacity: CGFloat = 1
    @State var zoomViewOpacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            GradientView(gradientId: hordeAppViewModel.gradientId)
            
            VStack {
                HordeBoardView_iPhone()
                    .frame(height: CardSize_iPhone.height.normal * 2 + 10)
                
                Spacer()
                
                ControlBarView_iPhone().frame(height: 50)
            }
            
            ZStack {
                if gameViewModel.damageTakenThisTurn > 0 {
                    Button(action: {
                        gameViewModel.damageTakenThisTurn = 0
                    }, label: {
                        VStack(spacing: 5) {
                            Text("Damage taken : \(gameViewModel.damageTakenThisTurn)")
                                .fontWeight(.bold)
                                .font(.title2)
                            
                            Text("Touch to dismiss")
                                .font(.subheadline)
                        }
                    })
                    .padding()
                    .frame(width: 300)
                    .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 2)
                    .position(x: UIScreen.main.bounds.width / 2, y: 0)
                    .animation(.easeInOut(duration: 0.3), value: gameViewModel.damageTakenThisTurn)
                    .scaleEffect(0.7)
                }
            }.transition(.move(edge: .top))


            CastedCardView_iPhone()
                .opacity(castedCardViewOpacity)
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
                                gameViewModel.cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardFromLibrary: Card(cardName: "", cardType: .creature, cardImageURL: ""))
                            }
                        }
                    }
                }
            
            GraveyardView_iPhone()
                .opacity(graveyardViewOpacity)
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
            
            ZoomOnCardView()
                .opacity(zoomViewOpacity)
                .scaleEffect(1.4)
                .onChange(of: gameViewModel.shouldZoomOnCard) { _ in
                    if gameViewModel.shouldZoomOnCard {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            zoomViewOpacity = 1
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            zoomViewOpacity = 0
                        }
                    }
                }
            
            GameIntroView_iPhone()
                .opacity(gameIntroViewOpacity)
                .onChange(of: gameViewModel.turnStep) { _ in
                    if gameViewModel.turnStep > 0 {
                        withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                            gameIntroViewOpacity = 0
                        }
                    }
                }
        }.ignoresSafeArea()
    }
}

struct HordeBoardView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let cardThickness: CGFloat = 0.2
    
    var deckThickness: CGFloat {
        return gameViewModel.deck.count < 250 ? CGFloat(gameViewModel.deck.count) * cardThickness : 250 * cardThickness
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 10) {

                // Graveyard
                
                ZStack {
                    if gameViewModel.cardsOnGraveyard.count > 0 {
                        Button(action: {
                            print("Show Graveyard")
                            gameViewModel.showGraveyard = true
                        }, label: {
                            CardView(card: gameViewModel.cardsOnGraveyard.last!)
                                .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                                .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                        })
                    } else {
                        RoundedRectangle(cornerRadius: CardSize_iPhone.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                            .opacity(0.5)
                    }
                    Text("\(gameViewModel.cardsOnGraveyard.count)")
                        .fontWeight(.bold)
                        .font(.title2)
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
                                    .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                                    .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal + deckThickness)
                                
                                Image("MTGBackground")
                                    .resizable()
                                    .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                                    .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                                    .offset(y: -deckThickness)
                                
                                
                                if gameViewModel.showLibraryTopCard {
                                    FlippingCardView(card: gameViewModel.deck.last!)
                                        .offset(y: -deckThickness)
                                }
                            }
                        }).frame(height: CardSize_iPhone.height.normal).offset(y: -deckThickness / 2).shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 2)
                        
                        if gameViewModel.showLibraryTopCard {
                            HStack {
                                // To Bottom of Library
                                Button(action: {
                                    gameViewModel.putTopLibraryCardToBottom()
                                }, label: {
                                    ButtonLabelWithImage_iPhone(imageName: "square.3.stack.3d.bottom.fill")
                                })
                                Spacer()
                                // Shuffle into Librarry
                                Button(action: {
                                    gameViewModel.shuffleLibrary()
                                }, label: {
                                    ButtonLabelWithImage_iPhone(imageName: "shuffle")
                                })
                                Spacer()
                                // To the Battlefield
                                Button(action: {
                                    gameViewModel.castTopLibraryCard()
                                }, label: {
                                    ButtonLabelWithImage_iPhone(imageName: "arrow.up.right.square")
                                })
                            }.offset(y: CardSize_iPhone.height.normal / 2)
                                .frame(width: CardSize_iPhone.width.normal -  40, height: 50).zIndex(50)
                        } else {
                            Button(action: {
                                print("Reveal library top card button pressed")
                                gameViewModel.showLibraryTopCard = true
                            }, label: {
                                PurpleButtonLabel_iPhone(text: "Reveal top")
                            }).offset(y: CardSize_iPhone.height.normal / 2)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: CardSize_iPhone.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                            .opacity(0.5)
                    }

                    Text("\(gameViewModel.deck.count)")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.white)
                        .offset(y: -deckThickness)
                }
            }.frame(height: CardSize_iPhone.height.normal * 2 + 10).padding(.top, 20).padding(.leading, (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) + 5)
            
            // Board
            
            ScrollView(.horizontal, showsIndicators: false) {
                if hordeAppViewModel.oneRowBoardInsteadOfTwo {
                    VStack {
                        Spacer()
                        LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize_iPhone.height.normal), spacing: 0), count: 1), alignment: .top, spacing: 15) {
                            ForEach(gameViewModel.cardsOnBoard) { card in
                                CardOnBoardView_iPhone(card: card)
                                    .scaleEffect(1.5)
                                    .transition(.scale.combined(with: .opacity))
                                    .frame(width: CardSize_iPhone.width.normal * 1.5, height: CardSize_iPhone.height.normal * 1.5)
                            }
                        }.padding(.leading, 10).padding().animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.cardsOnBoard)
                        Spacer()
                    }
                } else {
                    LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize_iPhone.height.normal), spacing: 10), count: 2), alignment: .top, spacing: 15) {
                        ForEach(gameViewModel.cardsOnBoard) { card in
                            CardOnBoardView_iPhone(card: card)
                                .transition(.scale.combined(with: .opacity))
                        }
                    }.padding(.leading, 10).padding().animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.cardsOnBoard)
                }
            }.frame(height: CardSize_iPhone.height.normal * 2 + 10).padding(.top, 20)
        }.frame(maxWidth: .infinity).padding(.leading, 2).padding(.top, 2)
    }
}

struct ControlBarView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var nexButtonDisable = false
    let scale = 0.65
    @GestureState var isDetectingLongPress = false
    
    var body: some View {
        HStack {
            
            // Menu
             
            Button(action: {
                print("Menu button tapped")
                hordeAppViewModel.showMenu()
            }) {
                Image(systemName: "gear")
                    .font(.title)
                    .foregroundColor(.white)
            }.frame(width: 30).padding(.leading, 10).scaleEffect(scale)

            // BoardWipe
            
            HStack(spacing: 0) {
                Text("Destroy all")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 79).scaleEffect(scale)
                
                Button(action: {
                    print("Creatures Wipe button pressed")
                    gameViewModel.destroyAllCreatures()
                }, label: {
                    Text("Creatures")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }).scaleEffect(scale)
                
                Button(action: {
                    print("Permanents Wipe button pressed")
                    gameViewModel.destroyAllPermanents()
                }, label: {
                    Text("Permanents")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }).scaleEffect(scale)
            }//.frame(maxWidth: .infinity)
            
            Spacer()
            
            // CreateToken
            
            HStack(spacing: 10) {
                Text("Create")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 50).scaleEffect(scale)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(gameViewModel.tokensAvailable) { token in
                            Button(action: {
                                //print("Create token button pressed")
                                //gameViewModel.createToken(token: token)
                            }, label: {
                                CardView(card: token)
                                    .frame(width: CardSize_iPhone.width.small, height: CardSize_iPhone.height.small)
                                    .cornerRadius(CardSize_iPhone.cornerRadius.small)
                                    .onTapGesture(count: 1) {
                                        print("Create token button pressed")
                                        gameViewModel.createToken(token: token)
                                    }
                                    .gesture(LongPressGesture(minimumDuration: 0.1)
                                        .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                                        .updating($isDetectingLongPress) { value, state, transaction in
                                            switch value {
                                                case .second(true, nil): //This means the first Gesture completed
                                                    state = true //Update the GestureState
                                                gameViewModel.shouldZoomOnCard = true //Update the @ObservedObject property
                                                gameViewModel.cardToZoomIn = token
                                                default: break
                                            }
                                        })
                                })
                        }
                    }
                }.frame(maxWidth: UIScreen.main.bounds.width / 2)
            }
            Spacer()
            
            // Next
            
            Button(action: {
                print("New turn pressed")
                gameViewModel.nextButtonPressed()
            }, label: {
                PurpleButtonLabel_iPhone(text: "Draw").padding(.trailing, 20)
            }).disabled(gameViewModel.isNextButtonDisabled() || nexButtonDisable)
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

struct CastedCardView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
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
                                    .scaleEffect(0.7)
                                HStack(spacing: 36) {
                                    ForEach(gameViewModel.cardsToCast.cardsFromGraveyard) { card in
                                        CardToCastView_iPhone(card: card)
                                    }
                                }
                            }
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 2, height: CardSize_iPhone.height.big_cast / 2)
                                .padding(.top, 50)
                        }
                        
                        VStack {
                            Text("From Library")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .scaleEffect(0.7)
                            HStack(spacing: 36) {
                                if gameViewModel.cardsToCast.cardFromLibrary.cardType != .token {
                                    CardToCastView_iPhone(card: gameViewModel.cardsToCast.cardFromLibrary)
                                }
                                ForEach(0..<gameViewModel.cardsToCast.tokensFromLibrary.count, id: \.self) {
                                    CardToCastView_iPhone(card: gameViewModel.cardsToCast.tokensFromLibrary[$0])
                                }
                            }
                        }
                    }.frame(minWidth: UIScreen.main.bounds.width - 30).padding([.leading, .trailing], 15).padding()
                }.onTapGesture {
                    print("Next button pressed")
                    gameViewModel.nextButtonPressed()
                }
            }
        }
    }
}

struct GraveyardView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        ZStack {
            // The button to leave the menu is the background
            Button(action: {
                print("Hide graveyard button pressed")
                gameViewModel.showGraveyard = false
            }, label: {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            }).buttonStyle(StaticButtonStyle())
            
            VStack(spacing: 10) {
                // The cards in the graveyard to show
                Text("Touch a permanent card to put it onto the battlefield")
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .scaleEffect(0.7)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        //ForEach(gameViewModel.cardsOnGraveyard, id: \.self) { card in
                        ForEach(0..<gameViewModel.cardsOnGraveyard.count, id: \.self) { i in
                            VStack(spacing: 15) {
                                Button(action: {
                                    print("Exile card in graveyard button pressed")
                                    gameViewModel.removeCardFromGraveyard(card: gameViewModel.cardsOnGraveyard[i])
                                }, label: {
                                    Text("Exile")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .frame(height: 30)
                                }).scaleEffect(0.7)
                                Button(action: {
                                    print("Card in graveyard pressed")
                                    gameViewModel.castCardFromGraveyard(cardId: i)
                                }, label: {
                                    GraveyardCardView_iPhone(card: gameViewModel.cardsOnGraveyard[i])
                                })
                                Text("To library")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                    .frame(height: 30)
                                    .scaleEffect(0.7)
                                HStack {
                                    Button(action: {
                                        print("Put at the bottom of library button pressed")
                                        gameViewModel.putAtBottomOfLibrary(card: gameViewModel.cardsOnGraveyard[i])
                                    }, label: {
                                        Text("Bottom")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .frame(height: 20)
                                    })
                                    Rectangle().frame(width: 2, height: 20).foregroundColor(.white)
                                    Button(action: {
                                        print("Put on top of library button pressed")
                                        gameViewModel.putOnTopOfLibrary(card: gameViewModel.cardsOnGraveyard[i])
                                    }, label: {
                                        Text("Top")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .frame(height: 20)
                                    })
                                    Rectangle().frame(width: 2, height: 20).foregroundColor(.white)
                                    Button(action: {
                                        print("Shuffle into library button pressed")
                                        gameViewModel.shuffleIntofLibrary(card: gameViewModel.cardsOnGraveyard[i])
                                    }, label: {
                                        Text("Shuffle")
                                            .fontWeight(.bold)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .frame(height: 20)
                                    })
                                }.scaleEffect(0.7)
                            }
                        }
                    }.padding([.leading, .trailing], 20).frame(minWidth: UIScreen.main.bounds.width)
                }.onTapGesture {
                    print("Hide graveyard button pressed")
                    gameViewModel.showGraveyard = false
                }.padding(.bottom, 20)
            }
        }
    }
}

struct CardToCastView_iPhone: View {
    
    var card: Card
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize_iPhone.width.big_cast, height: CardSize_iPhone.height.big_cast)
                .cornerRadius(CardSize_iPhone.cornerRadius.big_cast)
                .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 2)
            if card.cardCount > 1 {
                Text("x\(card.cardCount)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
}

struct GraveyardCardView_iPhone: View {
    
    var card: Card
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize_iPhone.width.big_graveyard, height: CardSize_iPhone.height.big_graveyard)
                .cornerRadius(CardSize_iPhone.cornerRadius.big_graveyard)
                .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 2)
        }.frame(height: CardSize_iPhone.height.big_graveyard)
    }
}

struct FlippingCardView_iPhone: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var cardScale = 1.0
    @EnvironmentObject var gameViewModel: GameViewModel
    
    let duration : CGFloat = 0.35
    let delay: CGFloat = 0.0
    
    var card: Card
    
    func flipCard () {
        withAnimation(.easeInOut(duration: duration).delay(delay)) {
            backDegree = 90
        }
        withAnimation(.easeInOut(duration: duration / 1.5).delay(delay)) {
            cardScale = 1.1
        }
        withAnimation(.easeInOut(duration: duration).delay(delay + duration)){
            frontDegree = 0
        }
        withAnimation(.easeInOut(duration: duration / 1.5).delay(delay + duration + duration / 1.5)){
            cardScale = 1.0
        }
    }
 
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                .scaleEffect(cardScale)
            Image("MTGBackground")
                .resizable()
                .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 0, y: 1, z: 0))
                .scaleEffect(cardScale)
        }
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

struct CardOnBoardView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    var card: Card
    @GestureState var isDetectingLongPress = false
    
    var body: some View {
        Button(action: {}, label: {
            ZStack {
                CardView(card: card)
                    .frame(width: CardSize_iPhone.width.normal, height: CardSize_iPhone.height.normal)
                    .cornerRadius(CardSize_iPhone.cornerRadius.normal)
                if card.cardCount > 1 {
                    Text("x\(card.cardCount)")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 2)
            .onTapGesture(count: 1) {
                print("Remove card")
                gameViewModel.removeOneCardOnBoard(card: card)
            }
            .gesture(LongPressGesture(minimumDuration: 0.1)
                .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                .updating($isDetectingLongPress) { value, state, transaction in
                    switch value {
                        case .second(true, nil): //This means the first Gesture completed
                            state = true //Update the GestureState
                        gameViewModel.shouldZoomOnCard = true //Update the @ObservedObject property
                        gameViewModel.cardToZoomIn = self.card
                        default: break
                    }
                })
        })
    }
    
    struct CustomZoomModifier : ViewModifier {
        var active : Bool
        
        @ViewBuilder func body(content: Content) -> some View {
            if active {
                content.position(x: (UIScreen.main.bounds.width - CardSize_iPhone.width.normal) / 2 , y: UIScreen.main.bounds.height / 2 - 50)
            } else {
                content
            }
        }
    }
}

struct ContentView_iPhone_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView_iPhone()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            GameView_iPhone()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
        }
    }
}

struct CardSize_iPhone {
    
    struct width {
        static let big_cast = (UIScreen.main.bounds.height / 100) * 6.3 * 7.5 as CGFloat as CGFloat
        static let big_graveyard = (UIScreen.main.bounds.height / 100) * 6.3 * 5.5 as CGFloat as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 6.3 * 4.5 as CGFloat
        static let small = 37.8 as CGFloat
    }
    
    struct height {
        static let big_cast = (UIScreen.main.bounds.height / 100) * 8.8 * 7.5 as CGFloat as CGFloat
        static let big_graveyard = (UIScreen.main.bounds.height / 100) * 8.8 * 5.5 as CGFloat as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 8.8 * 4.5 as CGFloat
        static let small = 52.5 as CGFloat
    }
    
    struct cornerRadius {
        static let big_cast = (UIScreen.main.bounds.height / 100) * 0.35 * 7.5 as CGFloat
        static let big_graveyard = (UIScreen.main.bounds.height / 100) * 0.35 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 0.35 * 4.5 as CGFloat
        static let small = 2.1 as CGFloat
    }
}

// Change name, not purple anymore
struct PurpleButtonLabel_iPhone: View {
    
    var text: String
    
    var body: some View {
        PurpleButtonLabel(text: text).scaleEffect(0.7).frame(width: 100)
    }
}

struct ButtonLabelWithImage_iPhone: View {
    
    var imageName: String
    
    var body: some View {
        ButtonLabelWithImage(imageName: imageName).scaleEffect(0.7).frame(width: 35)
    }
}


struct GameIntroView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var isDeckBeingGenerated: Bool = false
    
    var body: some View {
        // The button to leave the menu is the background
        ZStack {
            Button(action: {
                print("Start game button pressed")
                isDeckBeingGenerated = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    gameViewModel.nextButtonPressed()
                    isDeckBeingGenerated = false
                }
            }, label: {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            }).buttonStyle(StaticButtonStyle())
            
            VStack(alignment: .center) {
                
                if gameViewModel.turnStep == -1 {
                    IntroSetupView_iPhone(isDeckBeingGenerated: $isDeckBeingGenerated).scaleEffect(0.65).frame(height: 50)
                } else if gameViewModel.turnStep == 0 {
                    IntroBeforeGameStartView().scaleEffect(0.65)
                }
            }.padding([.leading, .trailing], 40)
                .transition(AnyTransition.slide)
        }.frame(width: UIScreen.main.bounds.width)
    }
}

struct IntroSetupView_iPhone: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @Binding var isDeckBeingGenerated: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.white).frame(width: 600, height: 100).opacity(0.000001)
                HStack(spacing: 100) {
                    GameModeSwitchButtonView(title: "Classic", setModeToClassic: true)
                    GameModeSwitchButtonView(title: "Marathon", setModeToClassic: false)
                }
            }.frame(height: 80).padding(.bottom, 30)
            
            ZStack {
                Color(.white).opacity(0.000001)
                HStack(alignment: .top, spacing: 30) {

                    VStack(spacing: 30) {
                        
                        MenuTextSubtitleView(text: "Token multiplicator")
                        
                        MenuTextParagraphView(text: "Increase the amount of tokens to make the horde reveal more cards each times")
                        
                        HStack(spacing: 20) {
                            IntroDifficultyChoiceButtonView(multiplicator: 1)
                            IntroDifficultyChoiceButtonView(multiplicator: 2)
                            IntroDifficultyChoiceButtonView(multiplicator: 3)
                            IntroDifficultyChoiceButtonView(multiplicator: 4)
                        }
                            
                        MenuTextSubtitleView(text: "Deck Size")
                        
                        MenuTextParagraphView(text: "Reduce the library size for small group of players, or increase it's size to make the game longer")
                        
                        HStack(spacing: 20) {
                            IntroPlayerChoiceButtonView(percent: 25)
                            IntroPlayerChoiceButtonView(percent: 50)
                            IntroPlayerChoiceButtonView(percent: 75)
                            IntroPlayerChoiceButtonView(percent: 100)
                            IntroPlayerChoiceButtonView(percent: 200)
                            IntroPlayerChoiceButtonView(percent: 300)
                        }
                    }
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 2)
                        .padding([.top, .bottom], 70)
                    
                    VStack(spacing: 30) {
                        
                        MenuTextSubtitleView(text: "Config")
                        
                        Toggle("Horde starts with a random permanent (different for every deck)", isOn: $gameViewModel.gameConfig.shared.shouldStartWithWeakPermanent)
                            .foregroundColor(.white)
                        
                        if gameViewModel.gameConfig.isClassicMode {
                            VStack(spacing: 15)  {
                                Toggle("Spawn a random powerfull permanent (different for every deck) when reaching milestone", isOn: $gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents)
                                    .foregroundColor(.white)
                                
                                if gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents {
                                    HStack(spacing: 20) {
                                        // Spawn at 25
                                        Button(action: {
                                            gameViewModel.gameConfig.classic.spawnStrongPermanentAt25.toggle()
                                        }, label: {
                                            Text("25%")
                                                .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt25 ? .white : .gray)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                        })
                                        
                                        // Spawn at 50
                                        Button(action: {
                                            gameViewModel.gameConfig.classic.spawnStrongPermanentAt50.toggle()
                                        }, label: {
                                            Text("50%")
                                                .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt50 ? .white : .gray)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                        })
                                        
                                        // Spawn at 75
                                        Button(action: {
                                            gameViewModel.gameConfig.classic.spawnStrongPermanentAt75.toggle()
                                        }, label: {
                                            Text("75%")
                                                .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt75 ? .white : .gray)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                        })
                                        
                                        // Spawn at 100
                                        Button(action: {
                                            gameViewModel.gameConfig.classic.spawnStrongPermanentAt100.toggle()
                                        }, label: {
                                            Text("100%")
                                                .foregroundColor(gameViewModel.gameConfig.classic.spawnStrongPermanentAt100 ? .white : .gray)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                        })
                                    }
                                }
                            }
                        }
                        
                        Toggle("Remove the strongest cards from the beginning of the deck", isOn: $gameViewModel.gameConfig.shared.shouldntHaveStrongCardsInFirstQuarter)
                            .foregroundColor(.white)
                    }
                }.padding([.leading, .trailing], 50)
            }.frame(width: UIScreen.main.bounds.width * 1.6  - ((UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) * 5), height: UIScreen.main.bounds.height).background(Color(.white).opacity(0.00000001))
                .animation(.easeInOut(duration: 0.3), value: gameViewModel.gameConfig.isClassicMode)
                .animation(.easeInOut(duration: 0.3), value: gameViewModel.gameConfig.classic.shouldSpawnStrongPermanents)

            Spacer()
            
            MenuTextBoldParagraphView(text: isDeckBeingGenerated ? "Generating deck, please wait ..." : "Touch to continue").scaleEffect(isDeckBeingGenerated ? 1.2 : 1)
            
            Spacer()
            
        }
    }
}

struct MenuView_iPhone: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
            Button(action: {
                print("Return to menu button pressed")
                hordeAppViewModel.shouldShowMenu = false
            }, label: {
                Rectangle()
                    .opacity(0.00000001)
            }).buttonStyle(StaticButtonStyle())
            
            if hordeAppViewModel.readyToPlay {
                Button(action: {
                    print("Return to menu button pressed")
                    hordeAppViewModel.shouldShowMenu = false
                    hordeAppViewModel.readyToPlay = false
                }, label: {
                    Text("Exit")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .font(.title)
                        .frame(width: 100, height: 80)
                }).position(x: -90, y: -40).scaleEffect(0.7)
            }
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .trailing, spacing: 0) {
                    MenuButtonView_iPhone(title: "Rules", id: 1).scaleEffect(0.7)
                    MenuButtonView_iPhone(title: "How to", id: 2).scaleEffect(0.7)
                    MenuButtonView_iPhone(title: "Custom", id: 4).scaleEffect(0.7)
                    MenuButtonView_iPhone(title: "Contact", id: 3).scaleEffect(0.7)
                    Spacer()
                }.padding(.top, 20)
                if hordeAppViewModel.menuToShowId == 1 {
                    ScrollView(.vertical) {
                        MenuRulesView().scaleEffect(0.85)
                    }.frame(width: UIScreen.main.bounds.width * 0.78)
                } else if hordeAppViewModel.menuToShowId == 2 {
                    ScrollView(.vertical) {
                        MenuHowToPlayView().scaleEffect(0.85)
                    }.frame(width: UIScreen.main.bounds.width * 0.78)
                } else if hordeAppViewModel.menuToShowId == 3 {
                   ScrollView(.vertical) {
                       MenuContactView().scaleEffect(0.85)
                   }.frame(width: UIScreen.main.bounds.width * 0.78)
               } else {
                    ScrollView(.vertical) {
                        MenuCustomView().scaleEffect(0.85)
                    }.frame(width: UIScreen.main.bounds.width * 0.78)
                }
            }.padding(.trailing, 0).padding(.top, hordeAppViewModel.readyToPlay ? 40 : 30).padding(.bottom, 30)
        }.ignoresSafeArea()
    }
}

struct MenuButtonView_iPhone: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let title: String
    let id: Int
    
    var isMenuSelected: Bool {
        return id == hordeAppViewModel.menuToShowId
    }
    
    var body: some View {
        Button(action: {
            print("Menu \(title) button pressed")
            hordeAppViewModel.menuToShowId = id
        }, label: {
            Text(title)
                .foregroundColor(isMenuSelected ? .white : .gray)
                .fontWeight(.bold)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .trailing).frame(height: 55).padding(.trailing, 15)
        })
    }
}
