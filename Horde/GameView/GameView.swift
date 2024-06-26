//
//  ContentView.swift
//  Horde
//
//  Created by Loic D on 08/05/2022.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var castedCardViewOpacity: CGFloat = 0
    @State var graveyardViewOpacity: CGFloat = 0
    @State var gameIntroViewOpacity: CGFloat = 1
    @State var zoomViewOpacity: CGFloat = 0
    @State var strongPermanentsViewOpacity: CGFloat = 0
    @State var lifepointsViewModel: LifePointsViewModel?
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                HordeBoardView()
                    .frame(height: CardSize.height.normal * 2 + 60)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 20 : 0)
            }
                
            if lifepointsViewModel != nil && gameViewModel.turnStep != -1 && hordeAppViewModel.useLifepointsCounter {
                HStack {
                    Spacer()
                    LifePointsView()
                        .environmentObject(lifepointsViewModel!)
                        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 2)
                        .cornerRadius(15)
                        .padding(.trailing, 10)
                        .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                }
            }
            
            ZStack(alignment: .bottomTrailing) {
                HandView()
                
                if gameViewModel.hand.count > 0 {
                    Button(action: {
                        gameViewModel.playHand()
                    }, label: {
                        PurpleButtonLabel(text: "Play hand")
                    })
                }
            }
            
            VStack {
                ControlBarView()
                    .background(Color.black.opacity(0.65).ignoresSafeArea())
                
                Spacer()
            }
            
            ZStack {
                if gameViewModel.damageTakenThisTurn > 0 {
                    Button(action: {
                        gameViewModel.damageTakenThisTurn = 0
                    }, label: {
                        VStack(spacing: 5) {
                            Text("Milled cards : \(gameViewModel.damageTakenThisTurn)")
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
                    .shadow(color: Color("ShadowColor"), radius: 6, x: 0, y: 4)
                    .position(x: UIScreen.main.bounds.width / 2, y: 70)
                    .animation(.easeInOut(duration: 0.3), value: gameViewModel.damageTakenThisTurn)
                }
            }.transition(.move(edge: .top))

            ZStack {
                StrongPermanentView()
                    .opacity(castedCardViewOpacity == 1 ? 0 : strongPermanentsViewOpacity)
                    .onChange(of: gameViewModel.shouldShowStrongPermanent) { show in
                        if show {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                strongPermanentsViewOpacity = 1
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                strongPermanentsViewOpacity = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                gameViewModel.strongPermanentsToSpawn = []
                            }
                        }
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
                                    gameViewModel.cardsToCast = CardsToCast(cardsFromGraveyard: [], tokensFromLibrary: [], cardsFromHand: [], cardFromLibrary: Card(cardName: "", cardType: .token, cardImageURL: ""))
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
                
                GameIntroView()
                    .opacity(gameIntroViewOpacity)
                    .onChange(of: gameViewModel.turnStep) { _ in
                        if gameViewModel.turnStep >= 0 {
                            withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                                gameIntroViewOpacity = 0
                            }
                        }
                    }
            }.ignoresSafeArea()
            
        }
        .background(
            GradientView(gradientId: hordeAppViewModel.gradientId)
            .onChange(of: gameIntroViewOpacity) { opacity in
                if opacity == 0 {
                    lifepointsViewModel = LifePointsViewModel(startingLife: hordeAppViewModel.survivorStartingLife)
                }
            })
    }
}

struct HordeBoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let cardThickness: CGFloat = 0.4
    @State var toggler: Bool = false
    @State var lastMilledTokenOpacity: Double = 1
    @State var lastMilledTokenScale: Double = 1
    
    var deckThickness: CGFloat {
        return gameViewModel.deck.count < 250 ? CGFloat(gameViewModel.deck.count) * cardThickness : 250 * cardThickness
    }
    
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
                            ZStack {
                                ForEach( gameViewModel.cardsOnGraveyard) { card in
                                    if card == gameViewModel.cardsOnGraveyard.last! {
                                        CardView(card: card)
                                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                                            .cornerRadius(CardSize.cornerRadius.normal)
                                            .opacity(toggler ? 1 : 1)
                                    }
                                }
                            }
                            .onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                    toggler.toggle()
                                }
                            }
                        })
                    } else {
                        RoundedRectangle(cornerRadius: CardSize.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                            .opacity(0.5)
                    }
                    ForEach(gameViewModel.lastMilledToken, id:\.id) { lastMilledToken in
                        CardView(card: lastMilledToken)
                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                            .cornerRadius(CardSize.cornerRadius.normal)
                            .opacity(lastMilledTokenOpacity)
                            .scaleEffect(lastMilledTokenScale)
                            .id(lastMilledToken.id)
                            .onAppear() {
                                print("new token")
                                lastMilledTokenOpacity = 1
                                lastMilledTokenScale = 1
                                withAnimation(.easeInOut(duration: 1)) {
                                    lastMilledTokenOpacity = 0
                                }
                                withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
                                    lastMilledTokenScale = 0
                                }
                            }
                    }
                    Text("\(gameViewModel.cardsOnGraveyard.count)")
                        .fontWeight(.bold)
                        .font(.cardCount())
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
                                    .frame(width: CardSize.width.normal, height: CardSize.height.normal + deckThickness)
                                
                                CardBackView()
                                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                                    .cornerRadius(CardSize.cornerRadius.normal)
                                    .offset(y: -deckThickness)
                                
                                
                                if gameViewModel.showLibraryTopCard {
                                    FlippingCardView(card: gameViewModel.deck.last!)
                                        .offset(y: -deckThickness)
                                }
                            }
                        }).frame(height: CardSize.height.normal).offset(y: -deckThickness / 2).shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                        
                        if gameViewModel.showLibraryTopCard {
                            HStack {
                                // To Bottom of Library
                                Button(action: {
                                    gameViewModel.putTopLibraryCardToBottom()
                                }, label: {
                                    ButtonLabelWithImage(imageName: "square.3.stack.3d.bottom.fill")
                                })
                                Spacer()
                                // Shuffle into Librarry
                                Button(action: {
                                    gameViewModel.shuffleLibrary()
                                }, label: {
                                    ButtonLabelWithImage(imageName: "shuffle")
                                })
                                Spacer()
                                // To the Battlefield
                                Button(action: {
                                    gameViewModel.castTopLibraryCard()
                                }, label: {
                                    ButtonLabelWithImage(imageName: "arrow.up.right.square")
                                })
                            }.offset(y: CardSize.height.normal / 2)
                                .frame(width: CardSize.width.normal -  20, height: 50)
                        } else {
                            Button(action: {
                                print("Reveal library top card button pressed")
                                gameViewModel.showLibraryTopCard = true
                            }, label: {
                                PurpleButtonLabel(text: "Reveal top")
                            }).offset(y: CardSize.height.normal / 2)
                        }
                    } else {
                        RoundedRectangle(cornerRadius: CardSize.cornerRadius.normal)
                            .foregroundColor(.black)
                            .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                            .opacity(0.5)
                    }

                    Text("\(gameViewModel.deck.count)")
                        .fontWeight(.bold)
                        .font(.cardCount())
                        .foregroundColor(.white)
                        .offset(y: -deckThickness)
                }
            }.frame(height: CardSize.height.normal * 2 + 50).padding(.bottom, 10)
            
            // Board
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: Array(repeating: .init(.fixed(CardSize.height.normal), spacing: 40), count: 2), alignment: .top, spacing: 15) {
                    ForEach(gameViewModel.cardsOnBoard) { card in
                        CardOnBoardView(card: card)
                            .transition(.scale.combined(with: .opacity))
                    }
                }.padding(.leading, 10).padding(.trailing, hordeAppViewModel.useLifepointsCounter ? UIScreen.main.bounds.width / 6 + 20 : 10).animation(Animation.easeInOut(duration: 0.5), value: gameViewModel.cardsOnBoard)
            }.frame(height: CardSize.height.normal * 2 + 50)
        }.frame(maxWidth: .infinity).padding(.leading, 10).padding(.top, 10)
    }
}

struct ControlBarView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var nexButtonDisable = false
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
            }.frame(width: 60)
            
            // Return to hand
            
            ReturnToHandView()
            
            // Draw a card
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    gameViewModel.drawOneCard()
                }
            }, label: {
                Text("Draw one")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.white)
            })
            
            // Add/Remove counters
            
            AddCountersOnPermanentsView()
            
            // BoardWipe
            
            Button(action: {
                print("Creatures Wipe button pressed")
                gameViewModel.destroyAllCreatures()
            }, label: {
                Text("Destroy all creatures")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.white)
            })
            
            Spacer()
            
            // CreateToken
            
            HStack(spacing: 10) {
                Text("Create")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 80)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(gameViewModel.tokensAvailable) { token in
                            Button(action: {
                            }, label: {
                                CardView(card: token)
                                    .frame(width: CardSize.width.small, height: CardSize.height.small)
                                    .cornerRadius(CardSize.cornerRadius.small)
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
            
            VStack(spacing: 0) {
                if gameViewModel.gameConfig.shared.useAlternativeDrawMode {
                    HStack {
                        Button(action: {
                            if gameViewModel.alternativeDrawCount > 1 {
                                gameViewModel.alternativeDrawCount -= 1
                            }
                        }, label: {
                            PurpleButtonLabel(text: "-", minWidth: 50)
                        }).frame(width: 70)
                        Button(action: {
                            gameViewModel.alternativeDrawCount += 1
                        }, label: {
                            PurpleButtonLabel(text: "+", minWidth: 50)
                        }).frame(width: 70)
                    }
                }
                
                Button(action: {
                    print("New turn pressed")
                    gameViewModel.nextButtonPressed()
                }, label: {
                    PurpleButtonLabel(text: gameViewModel.gameConfig.shared.useAlternativeDrawMode ? "Draw \(gameViewModel.alternativeDrawCount)" : "Draw", isPrimary: true)
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
            }.offset(y: gameViewModel.gameConfig.shared.useAlternativeDrawMode ? -35 : 0)
        }
    }
}

struct CastedCardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @State var cardToCastFromLibrary: Card = Card.emptyCard()
    
    var isCastingSomethingFromLibrary: Bool {
        return gameViewModel.cardsToCast.cardFromLibrary != Card.emptyCard() || gameViewModel.cardsToCast.tokensFromLibrary.count > 0
    }
    
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
                    
                    if isCastingSomethingFromLibrary {
                        VStack {
                            Text("From Library")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            HStack(spacing: 36) {
                                if cardToCastFromLibrary.cardType != .token {
                                    CardToCastView(card: cardToCastFromLibrary, showCardCount: false)
                                }
                                ForEach(gameViewModel.cardsToCast.tokensFromLibrary, id: \.id) { card in
                                    CardToCastView(card: card)
                                }
                            }
                        }
                    }
                    
                    if gameViewModel.cardsToCast.cardsFromHand.count > 0 {
                        
                        if isCastingSomethingFromLibrary {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 2, height: CardSize.height.big / 2)
                                .padding(.top, 50)
                        }
                        
                        VStack {
                            Text("From Hand")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(height: 50)
                            HStack(spacing: 36) {
                                ForEach(gameViewModel.cardsToCast.cardsFromHand, id: \.id) { card in
                                    CardToCastView(card: card)
                                }
                            }
                        }
                    }
                }.frame(minWidth: UIScreen.main.bounds.width, minHeight: CardSize.height.normal + 160).padding([.leading, .trailing], 30)
            }.onTapGesture {
                print("Next button pressed")
                gameViewModel.nextButtonPressed()
            }.onChange(of: gameViewModel.cardsToCast.cardFromLibrary) { newCard in
                cardToCastFromLibrary = newCard
            }
        }
    }
}

struct StrongPermanentView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    //@State var milestoneReached: Int
    var infoText: String {
        if gameViewModel.gameConfig.isClassicMode {
            return "Milestone reached"
        } else {
            return "Stage \(gameViewModel.marathonStage) completed"
        }
    }
    
    var body: some View {
        // The button to leave the menu is the background
        Button(action: {
            gameViewModel.shouldShowStrongPermanent = false
        }, label: {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        }).buttonStyle(StaticButtonStyle())
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 30) {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Text(infoText)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(height: 50)
                    } else {
                        Text(infoText)
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                            .scaleEffect(0.7)
                    }

                    HStack(spacing: 36) {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            ForEach(gameViewModel.strongPermanentsToSpawn, id: \.id) { card in
                                CardView(card: card)
                                    .frame(width: CardSize.width.big, height: CardSize.height.big)
                                    .cornerRadius(CardSize.cornerRadius.big)
                                    .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
                            }
                        } else {
                            ForEach(gameViewModel.strongPermanentsToSpawn, id: \.id) { card in
                                CardView(card: card)
                                    .frame(width: CardSize_iPhone.width.big_cast, height: CardSize_iPhone.height.big_cast)
                                    .cornerRadius(CardSize_iPhone.cornerRadius.big_cast)
                                    .shadow(color: Color("ShadowColor"), radius: 2, x: 0, y: 2)
                            }
                        }
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIDevice.current.userInterfaceIdiom == .pad ? CardSize.height.big + 160 : CardSize_iPhone.height.big_cast + 50).padding([.leading, .trailing], 30)
            }
        }
        .onTapGesture {
            gameViewModel.shouldShowStrongPermanent = false
        }
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
                LazyHStack(spacing: 20) {
                    VStack {
                        Button(action: {
                            gameViewModel.graveyardAllExile()
                        }, label: {
                            PurpleButtonLabel(text: "Exile all", isPrimary: true, noMaxWidth: true, minWidth: 220)
                        })
                        
                        Button(action: {
                            gameViewModel.graveyardAllBattlefield()
                        }, label: {
                            PurpleButtonLabel(text: "All battlefield", isPrimary: true, noMaxWidth: true, minWidth: 220)
                        })
                        
                        Button(action: {
                            gameViewModel.graveyardAllShuffle()
                        }, label: {
                            PurpleButtonLabel(text: "Shuffle all", isPrimary: true, noMaxWidth: true, minWidth: 220)
                        })
                        
                        Button(action: {
                            gameViewModel.graveyardAllTop()
                        }, label: {
                            PurpleButtonLabel(text: "All top", isPrimary: true, noMaxWidth: true, minWidth: 220)
                        })
                        
                        Button(action: {
                            gameViewModel.graveyardAllBottom()
                        }, label: {
                            PurpleButtonLabel(text: "All bottom", isPrimary: true, noMaxWidth: true, minWidth: 220)
                        })
                    }.padding(.trailing, 20).padding(.bottom, 50)
                    ForEach(0..<gameViewModel.cardsOnGraveyard.count, id: \.self) { i in
                        VStack(spacing: 15) {
                            Button(action: {
                                print("Exile card in graveyard button pressed")
                                gameViewModel.removeCardFromGraveyard(card: gameViewModel.cardsOnGraveyard[i])
                            }, label: {
                                Text("Exile")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                            })
                            Button(action: {
                                print("Card in graveyard pressed")
                                gameViewModel.castCardFromGraveyard(cardId: i)
                            }, label: {
                                CardToCastView(card: gameViewModel.cardsOnGraveyard[i])
                            })
                            Text("To library")
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.gray)
                                .frame(height: 30)
                            HStack {
                                Button(action: {
                                    print("Put at the bottom of library button pressed")
                                    gameViewModel.putAtBottomOfLibrary(card: gameViewModel.cardsOnGraveyard[i])
                                }, label: {
                                    Text("Bottom")
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(height: 40)
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
                                        .frame(height: 30)
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
                                        .frame(height: 30)
                                })
                            }
                        }
                    }
                }.padding([.leading, .trailing], 20).frame(minWidth: UIScreen.main.bounds.width)
                    .frame(height: CardSize.height.normal + 290)
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
    @ObservedObject var card: Card
    let shouldImageBeSaved: Bool
    
    init(card: Card, shouldImageBeSaved: Bool = true) {
        self.downloadManager = DownloadManager(card: card, shouldImageBeSaved: shouldImageBeSaved)
        self.card = card
        self.shouldImageBeSaved = shouldImageBeSaved
    }
    
    var body: some View {
        ZStack {
            if card.showFront {
                if card.cardUIImage != Image("BlackBackground") {
                    card.cardUIImage
                        .resizable()
                } else {
                    card.cardUIImage
                        .resizable()
                        .onAppear() {
                            self.downloadManager.startDownloading()
                        }
                }
            } else {
                if card.cardBackUIImage != Image("BlackBackground") {
                    card.cardBackUIImage
                        .resizable()
                } else {
                    card.cardBackUIImage
                        .resizable()
                        .onAppear() {
                            self.downloadManager.startDownloading()
                        }
                }
            }
        }
    }
}

struct CardToCastView: View {
    
    var card: Card
    @EnvironmentObject var gameViewModel: GameViewModel
    var showCardCount: Bool = true
    
    var body: some View {
        ZStack {
            CardView(card: card)
                .frame(width: CardSize.width.big, height: CardSize.height.big)
                .cornerRadius(CardSize.cornerRadius.big)
                .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
            if showCardCount && card.cardCount > 1 {
                Text("\(card.cardCount)")
                    .fontWeight(.bold)
                    .font(.cardCount())
                    .foregroundColor(.white)
            }
            if card.hasDefender {
                Text("Can't attack")
                    .headline()
                    .padding()
                    .blurredBackground()
                    .offset(y: -CardSize.height.big / 3.5)
            }
        }.frame(height: CardSize.height.big + 60)
    }
}

struct FlippingCardView: View {
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
                .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                .cornerRadius(CardSize.cornerRadius.normal)
                .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 0, y: 1, z: 0))
                .scaleEffect(cardScale)
            CardBackView()
                .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                .cornerRadius(CardSize.cornerRadius.normal)
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

struct CardOnBoardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    var card: Card
    @GestureState var isDetectingLongPress = false
    
    var body: some View {
        Button(action: {}, label: {
            ZStack {
                CardView(card: card)
                    .frame(width: CardSize.width.normal, height: CardSize.height.normal)
                    .cornerRadius(CardSize.cornerRadius.normal)
                if card.cardCount > 1 {
                    Text("\(card.cardCount)")
                        .fontWeight(.bold)
                        .font(.cardCount())
                        .foregroundColor(.white)
                }
                if card.countersOnCard > 0 {
                    CountersOnCardView(countersCount: card.countersOnCard)
                }
                if card.hasDefender {
                    Text("Can't attack")
                        .headline()
                        .padding()
                        .blurredBackground()
                        .offset(y: -CardSize.height.normal / 3.5)
                }
                if card.isDoubleFacedCard {
                    HStack {
                        if card.cardCount > 1 {
                            Button(action: {
                                gameViewModel.flipOne(card: card)
                            }, label: {
                                ZStack {
                                    ButtonLabelWithImage(imageName: "arrow.triangle.2.circlepath", customFont: .title)
                                    Text("1").headline()
                                }
                            }).offset(y: CardSize.height.normal / 2 - 15)
                        }
                        
                        Button(action: {
                            card.showFront.toggle()
                            gameViewModel.regroupBoard()
                        }, label: {
                            ButtonLabelWithImage(imageName: "arrow.triangle.2.circlepath", customFont: .title)
                        }).offset(y: CardSize.height.normal / 2 - 15)
                    }
                }
            }
            .shadow(color: Color("ShadowColor"), radius: 3, x: 0, y: 4)
            .onTapGesture(count: 1) {
                if gameViewModel.addCountersModeEnable {
                    gameViewModel.addCountersToCardOnBoard(card: card)
                } else if gameViewModel.removeCountersModeEnable {
                    gameViewModel.removeCountersFromCardOnBoard(card: card)
                } else if gameViewModel.returnToHandModeEnable {
                    gameViewModel.returnToHandFromBoard(card: card)
                } else {
                    print("Send \(card.cardName) to graveyard")
                    gameViewModel.removeOneCardOnBoard(card: card)
                }
            }
            .gesture(LongPressGesture(minimumDuration: 0.1)
                .sequenced(before: LongPressGesture(minimumDuration: .infinity))
                .updating($isDetectingLongPress) { value, state, transaction in
                    switch value {
                        case .second(true, nil): //This means the first Gesture completed
                            state = true //Update the GestureState
                        DispatchQueue.main.async {
                            gameViewModel.shouldZoomOnCard = true //Update the @ObservedObject property
                            gameViewModel.cardToZoomIn = self.card
                        }
                        default: break
                    }
                })
        })
    }
    
    struct CountersOnCardView: View {
        let countersCount: Int
        var body: some View {
            ZStack {
                Text("\(countersCount)")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(width: 80, height: 80)
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
            .cornerRadius(40)
            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
            .offset(y: -40)
        }
    }
}

struct ZoomOnCardView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    
    var body: some View {
        // The button to leave the menu is the background
        ZStack {
            Button(action: {
                print("UnZoom")
                gameViewModel.shouldZoomOnCard = false
            }, label: {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
            }).buttonStyle(StaticButtonStyle())
            
            CardView(card: gameViewModel.cardToZoomIn)
                .frame(width: CardSize_iPhone.width.big_cast, height: CardSize_iPhone.height.big_cast)
                .cornerRadius(CardSize_iPhone.cornerRadius.big_cast)
        }
    }
}

// card's size is 6.3 by 8.8

struct CardSize {
    
    struct width {
        static let big = (UIScreen.main.bounds.height / 100) * 6.3 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 6.3 * 4.5 as CGFloat
        static let small = 54 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 6.3 * 3.5 as CGFloat
    }
    
    struct height {
        static let big = (UIScreen.main.bounds.height / 100) * 8.8 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 8.8 * 4.5 as CGFloat
        static let small = 75 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 8.8 * 3.5 as CGFloat
    }
    
    struct cornerRadius {
        static let big = (UIScreen.main.bounds.height / 100) * 0.35 * 5.5 as CGFloat
        static let normal = (UIScreen.main.bounds.height / 100) * 0.35 * 4.5 as CGFloat
        static let small = 3 as CGFloat
        static let hand = (UIScreen.main.bounds.height / 100) * 0.35 * 3.5 as CGFloat
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            GameView()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        } else {
            GameView()
                .environmentObject(GameViewModel())
                .environmentObject(HordeAppViewModel())
        }
    }
}

struct ButtonLabelWithImage: View {
    
    let imageName: String
    let customFont: Font
    
    init(imageName: String, customFont: Font = .subheadline) {
        self.imageName = imageName
        self.customFont = customFont
    }
    
    var body: some View {
        Image(systemName: imageName)
            .font(customFont)
            .frame(width: 50, height: 50)
            .padding()
            .frame(width: 50, height: 50)
            .background(VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)))
            .cornerRadius(40)
            .foregroundColor(.white)
            .shadow(color: Color("ShadowColor"), radius: 4, x: 0, y: 4)
    }
}
