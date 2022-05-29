//
//  MenuView.swift
//  Horde
//
//  Created by Loic D on 17/05/2022.
//

import SwiftUI

struct MenuView: View {
    
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
            
            HStack(alignment: .top) {
                VStack(alignment: .trailing, spacing: 30) {
                    MenuButtonView(title: "Rules", id: 1)
                    MenuButtonView(title: "How to play", id: 2)
                    MenuButtonView(title: "Contact", id: 3)
                    // Don't show return to deck selection if already in deck selection
                    if hordeAppViewModel.readyToPlay {
                        Spacer()
                        Button(action: {
                            print("Return to menu button pressed")
                            hordeAppViewModel.shouldShowMenu = false
                            hordeAppViewModel.readyToPlay = false
                        }, label: {
                            Text("Return to deck selection")
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .frame(width: 200)
                        })
                        Spacer()
                    }
                }
                ScrollView(.vertical) {
                    if hordeAppViewModel.menuToShowId == 1 {
                        MenuRulesView()
                    } else if hordeAppViewModel.menuToShowId == 2 {
                        MenuHowToPlayView()
                    } else {
                        MenuContactView()
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.75).padding(30)
            }.padding([.leading, .trailing], 20).padding(.top, 50).padding(.bottom, 50)
        }.ignoresSafeArea()
    }
}

struct MenuButtonView: View {
    
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
                .font(.largeTitle)
        })
    }
}

struct MenuRulesView: View {
    var body: some View {
        
        LazyVStack(alignment: .leading, spacing: 30) {
            Group {
                MenuTextBoldParagraphView(text: "Rules by Peter Knudson")
                
                MenuTextParagraphView(text: "The goal of Horde Magic is to survive the onslaught of Zombies. The Horde deck has no life total, so the only way to win is to... uh... not die. Eventually the deck will run out of cards and you'll be able to breath sight of relief.\n\nZombies generally don't do a lot of thinking. They just want you dead. So in Horde Magic, the Horde has no decisions to make, and thus the Horde deck also doesn't require a pilot to run. This creates unique co-op gameplay, which many are likely to really enjoy. Additionally, you can battle the Horde deck solo.")
            }
            
            Group {
                MenuTextTitleView(text: "The Rules")
                MenuTextParagraphView(text: "I've had a lot fun playing Horde Magic with friends at school and at my local store and I've been encouraged to share my format with others. If you find this concept interesting, the Horde deck can be assembled quite inexpensively, especially if you have a bunch of Zombie tokens lying around.")
                
                MenuTextSubtitleView(text: "Starting the Game")
                MenuTextParagraphView(text: "To play Horde Magic, each player needs a Commander deck. Any other Magic deck will do, but Horde Magic was developed to play with the multitude of Commander decks that people own.")
                
                MenuTextSubtitleView(text: "The Survivors:")
                MenuTextParagraphView(text: "There can be anywhere between one and four Survivors, which are the players teaming up to defend against the Horde. The number of Survivors determine the number of cards in the Horde deck, as the difficulty needs to scale accordingly. The Survivors have a collective life total of 20 life per player, and everybody loses when that life total becomes 0.")
                
                MenuTextSubtitleView(text: "The Horde:")
                MenuTextParagraphView(text: "The number of Zombies you'll face over the course of the game is based on the number of Survivors. For three Survivors, take your 100 card Horde deck and remove a random 25 cards, bringing your Horde deck to a total of 75. The Horde starts with no cards in hand and no permanents on the battlefield.")
            }
            
            Group {
                MenuTextTitleView(text: "Game Play")
                MenuTextParagraphView(text: "The Survivors get 3 turns to set up their defenses before the Horde takes a turn. Just like in Archenemy and Two-Headed Giant, the Survivors take turns simultaneously. After the 3 turn set-up, the Survivors and the Horde alternate turns.\n\nOn each of the Zombie's turns, the top card of their library is flipped over. If the card is a Zombie token, then another is flipped over. Cards are flipped over until a non-token card is revealed. Sometimes the card is a Bad Moon, sometimes it's a Souless One, and sometimes it's even a Plague Wind. At that point, all of the tokens flipped this way are cast, and the non-token card is cast last.\n\nThen the Zombies enter combat. Since Zombies are generally brainless, they come charging in without thinking twice. All Zombies have haste and must attack each turn if able. That's just how they roll. Since the survivors are on a team together, when the Zombies attack, they attack every player at the same time, just like in Two-Headed Giant, and when any of the survivors choose to block, they block for the whole team.")
                
                MenuTextSubtitleView(text: "Defeating the Horde:")
                MenuTextParagraphView(text: "You, as the Survivors, win when the Zombie deck can't flip over anymore Zombies, and the Horde doesn't control any more Zombies. You can use anything at your disposal to stem the bleeding, from Walls, to Wrath of Gods, to blocking with huge fatties. However, if you and your teammates feel that you have adequate defenses for the next Zombie attack, you can also attack the Horde at it's source. Zombies can't block, and have no life total, so it's safe to go on the offensive if you think you can survive the next wave of Zombies.")
                MenuTextBoldParagraphView(text: "For each point of damage done to the Horde, the Horde mills one card off the top of their deck.")
                
                MenuTextSubtitleView(text: "Winning:")
                MenuTextParagraphView(text: "The Survivors are victorious when all the Zombies in play are dead, and the Horde deck has run out of cards. The Horde wins when the Survivors' life total becomes 0.")
                
                MenuTextTitleView(text: "Rules Notes")
                MenuTextParagraphView(text: "The Zombie deck is built so that, hopefully, the Horde deck is not presented with any decisions. In order for the deck to gather the co-op experience, many awesome Zombie cards were omitted. However, there are lots of cards that the Survivors might play that cause the Horde to make a choice (such as Fact or Fiction or Chainer's Edict). In this case, the Horde makes this choice as randomly as possible.\n\nThe Zombie tokens and cards from the Horde deck use the stack, so you can respond to them coming into to play, or counter them.\n\nThe Horde has infinite mana, so cards like Propaganda and Mana Leak don't work. Sorry!\n\nIf you return a permanent to the Horde's hand, it gets cast again on their next main phase.\n\nThere are a LOT of Magic cards in existence. If something doesn't work the way it's supposed to, just come up with the most fair way to execute the card. If you can't, cycle it. This is a casual format.")
            }

        }
    }
}

struct MenuTextTitleView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.largeTitle)
    }
}

struct MenuTextSubtitleView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.title)
    }
}

struct MenuTextParagraphView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
    }
}

struct MenuTextBoldParagraphView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
    }
}

struct MenuHowToPlayView: View {
    var body: some View {
        Text("How To play")
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.largeTitle)
    }
}

struct MenuContactView: View {
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            MenuTextTitleView(text: "Contact")
            
            MenuTextParagraphView(text: "If you have any problem or a suggestion about this app, feel free to contact me at")
            
            MenuTextBoldParagraphView(text: "aaaaa")
            
            MenuTextTitleView(text: "Info")
            
            MenuTextParagraphView(text: "App icon by Superarticons")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            MenuView()
                .environmentObject(HordeAppViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            MenuView()
                .environmentObject(HordeAppViewModel())
        }
    }
}
