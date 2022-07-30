//
//  MenuView.swift
//  Horde
//
//  Created by Loic D on 17/05/2022.
//

import SwiftUI
import UniformTypeIdentifiers

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
            
            if hordeAppViewModel.readyToPlay {
                Button(action: {
                    print("Return to menu button pressed")
                    hordeAppViewModel.shouldShowMenu = false
                    hordeAppViewModel.readyToPlay = false
                }, label: {
                    Text("Exit")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .frame(width: 100, height: 80)
                }).position(x: 60, y: 40)
            }
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .trailing, spacing: 0) {
                    MenuButtonView(title: "Rules", id: 1)
                    MenuButtonView(title: "How to play", id: 2)
                    MenuButtonView(title: "Custom", id: 4)
                    MenuButtonView(title: "Contact", id: 3)
                    Spacer()
                }
                if hordeAppViewModel.menuToShowId == 1 {
                    ScrollView(.vertical) {
                        MenuRulesView()
                    }.frame(width: UIScreen.main.bounds.width * 0.75)
                } else if hordeAppViewModel.menuToShowId == 2 {
                    ScrollView(.vertical) {
                        MenuHowToPlayView()
                    }.frame(width: UIScreen.main.bounds.width * 0.75)
                } else if hordeAppViewModel.menuToShowId == 3 {
                    ScrollView(.vertical) {
                        MenuContactView()
                    }.frame(width: UIScreen.main.bounds.width * 0.75)
                } else {
                    ScrollView(.vertical) {
                        MenuCustomView()
                    }.frame(width: UIScreen.main.bounds.width * 0.75)
                }
            }.padding(.trailing, 20).padding(.top, hordeAppViewModel.readyToPlay ? 100 : 50).padding(.bottom, 50)
        }.ignoresSafeArea().frame(width: UIScreen.main.bounds.width)
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
                .frame(maxWidth: .infinity, alignment: .trailing).frame(height: 80).padding(.trailing, 30)
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

            Group {
                MenuTextTitleView(text: "Additional rules")
                
                MenuTextParagraphView(text: "If the horde has to choose a target, it choose the BEST target. BEST is higher strength, then higher Mana Value. If still multiple possible targets, targets randomly")
                
                MenuTextParagraphView(text: "If survivors have planeswalkers, each time a creature controlled by the horde isn't blocked : heads or tails for each of those creature to know if it deals damage to the planeswalker or the survivors. Target the planeswalker with higher Mana Value first if survivors have multiple planeswalkers")
                
                MenuTextBoldParagraphView(text: "Remember that this is a casual format, you can change as many rules as you want. What matters is that you have fun :)")
            }
        }.padding(.trailing, 30)
    }
}

struct MenuTextTitleView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
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

struct MenuTextWithImageParagraphView: View {
    
    let text1: String
    let image: Image
    let text2: String
    
    var body: some View {
        Text("\(text1)\(image)\(text2)")
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
        
        LazyVStack(alignment: .leading, spacing: 40) {
                
            Text("How to use the app")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
            
            Group {
                MenuTextSubtitleView(text: "FAQ")
                
                Group {
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "Is an internet connection required to use this app ?")
                        
                        MenuTextParagraphView(text: "Card images are downloaded the first time you draw them then saved wich means you will need an internet connection (dark color is shown while the image is downloading)")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "Difference between Classic and Marathon ?")
                        
                        MenuTextParagraphView(text: "Classic : One deck to beat")
                        
                        MenuTextParagraphView(text: "Marathon : Three deck to beat. Token mulitplicator increase and strong permanents enters the battlefield between each new deck")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to use the life counter ?")
                        
                        MenuTextParagraphView(text: "Swipe up/down to increase/decrease. If you want to make a small change, press the upper part to increase, or the bottom part to decrease")
                        
                        MenuTextParagraphView(text: "By default, the Horde heal when survivors lose life. If you don't want to play with this rules you can disable it in the 'Custom' menu")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to mill the horde ?")
                        
                        MenuTextParagraphView(text: "Press the horde's library to mill his deck")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to destroy a permenent ?")
                        
                        MenuTextParagraphView(text: "Touch a card on the board to destroy it")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to play a horde turn ?")
                        
                        MenuTextParagraphView(text: "Press the draw button until the horde have drawn enough cards and create tokens if a card told you to. All the creatures controlled by the horde are now attacking, : block them, lose life and remove the creatures you destroyed during the combat. The turn is now over")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to zoom on a card ?")
                        
                        MenuTextParagraphView(text: "Long press a card on the board or in the token creation row to zoom")
                    }
                }
                
                LazyHStack(spacing: 30) {
                    Image("TutoLibraryReveal")
                    
                    LazyVStack(alignment: .leading, spacing: 30) {
                        
                        MenuTextSubtitleView(text: "Reveal library top card")
                        
                        MenuTextParagraphView(text: "You can reveal the horde's library top card any time by pressing the Reveal Top button. You'll have access to 3 buttons to interact with this card. the button actions are described below in order from left to right")
                        
                        MenuTextBoldParagraphView(text: "Put it at the bottom of the horde's library")
                        
                        MenuTextBoldParagraphView(text: "Shuffle it in the horde's library")
                        
                        MenuTextBoldParagraphView(text: "Cast it")
                    }
                }
                
                Group {
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "In the 7 starting decks, I can change the decklist but not the deck info and speical rules")
                        
                        MenuTextParagraphView(text: "Everyone can change the deck list of those decks but only premium users can change their name, image, rules or delete them")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "I have deleted one of the 7 starting decks but I want it back")
                        
                        MenuTextParagraphView(text: "Everytime you launch the app, if one of the 7 first deck slot is empty, the corresponding starting deck will be recreated")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "If I stop being a premium user, is the app deleting the deck I created on the extra deck slots ?")
                        
                        MenuTextParagraphView(text: "No they won't be deleted, you won't be able to access them but going premium again will show them back in the deck selection")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "If I export my deck to share it, what will be included ?")
                        
                        MenuTextParagraphView(text: "Only the cards in the 5 groups (main deck, lategame cards, tokens, weak permanents and strong permanents). Deck name, image, intro and rules are not shared when exporting")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "I want a deck with 96.45% of tokens and 99.97814% of lategame cards, is it possible ?")
                        
                        MenuTextParagraphView(text: "You can make crazy decks but if your deck is far from a classic horde deck the option 'Remove the strongest cards from the beginning of the deck' might fail to generate the deck and get stuck. Just disable it and enjoy your crazy deck !")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "Why can I change the type of a creature card to token ?")
                        
                        MenuTextParagraphView(text: "Use this if you want some creatures to be treated as tokens (see the sliver deck list)")
                    }
                }
            }
        }.padding(.trailing, 30)
    }
}

struct MenuContactView: View {
    
    @State var mailCopied = false
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            MenuTextTitleView(text: "Contact")
            
            MenuTextParagraphView(text: "If you have any problem or a suggestion about this app, feel free to contact me at")
            
            Text(verbatim: mailCopied ? "Copied to clipboard !" : "loic.danjean@burning-beard.com (Touch to copy)")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .onTapGesture(count: 1) {
                    UIPasteboard.general.setValue("loic.danjean@burning-beard.com",
                        forPasteboardType: UTType.plainText.identifier)
                    mailCopied = true
                }
            
            MenuTextTitleView(text: "Info")
            
            MenuTextParagraphView(text: "App icon by Superarticons")
            
            MenuTextBoldParagraphView(text: "This app is unofficial Fan Content permitted under the Fan Content Policy. Not approved/endorsed by Wizards. Portions of the materials used are property of Wizards of the Coast. ©Wizards of the Coast LLC.")
        }.padding(.trailing, 30)
    }
}

struct MenuCustomView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 30) {            
            MenuTextSubtitleView(text: "Background Color")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    MenuCustomBackgroundColorChoiceView(gradientId: 1)
                    MenuCustomBackgroundColorChoiceView(gradientId: 2)
                    MenuCustomBackgroundColorChoiceView(gradientId: 3)
                    MenuCustomBackgroundColorChoiceView(gradientId: 4)
                    MenuCustomBackgroundColorChoiceView(gradientId: 5)
                    MenuCustomBackgroundColorChoiceView(gradientId: 6)
                    MenuCustomBackgroundColorChoiceView(gradientId: 7)
                }
            }
            
            Toggle("Use less colorful background", isOn: $hordeAppViewModel.useLessColorFullBackground)
                .foregroundColor(.white)
                .onChange(of: hordeAppViewModel.useLifepointsCounter) { _ in
                    hordeAppViewModel.saveBattlefieldRowStylePreference()
                }
            
            MenuTextSubtitleView(text: "Life counter")
            
            Toggle("Show life counter", isOn: $hordeAppViewModel.useLifepointsCounter)
                .foregroundColor(.white)
                .onChange(of: hordeAppViewModel.useLifepointsCounter) { _ in
                    hordeAppViewModel.saveBattlefieldRowStylePreference()
                }
            
            Toggle("The Horde heals when survivors loose life", isOn: $hordeAppViewModel.hordeGainLifeLostBySurvivor)
                .foregroundColor(.white)
                .onChange(of: hordeAppViewModel.useLifepointsCounter) { _ in
                    hordeAppViewModel.saveBattlefieldRowStylePreference()
                }
            
            HStack(spacing: 20) {
                Text("Survivors starting life")
                    .foregroundColor(.white)
                Spacer()
                // Start with 20
                Button(action: {
                    hordeAppViewModel.survivorStartingLife = 20
                    hordeAppViewModel.saveUseLifepointsCounterPreference()
                }, label: {
                    Text("20")
                        .foregroundColor(hordeAppViewModel.survivorStartingLife == 20 ? .white : .gray)
                        .fontWeight(.bold)
                        .font(.title2)
                })
                
                // Start with 40
                Button(action: {
                    hordeAppViewModel.survivorStartingLife = 40
                    hordeAppViewModel.saveUseLifepointsCounterPreference()
                }, label: {
                    Text("40")
                        .foregroundColor(hordeAppViewModel.survivorStartingLife == 40 ? .white : .gray)
                        .fontWeight(.bold)
                        .font(.title2)
                })
                
                // Start with 60
                Button(action: {
                    hordeAppViewModel.survivorStartingLife = 60
                    hordeAppViewModel.saveUseLifepointsCounterPreference()
                }, label: {
                    Text("60")
                        .foregroundColor(hordeAppViewModel.survivorStartingLife == 60 ? .white : .gray)
                        .fontWeight(.bold)
                        .font(.title2)
                })
                
                // Start with 80
                Button(action: {
                    hordeAppViewModel.survivorStartingLife = 80
                    hordeAppViewModel.saveUseLifepointsCounterPreference()
                }, label: {
                    Text("80")
                        .foregroundColor(hordeAppViewModel.survivorStartingLife == 80 ? .white : .gray)
                        .fontWeight(.bold)
                        .font(.title2)
                })
            }
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                MenuTextSubtitleView(text: "Battlefield")
                
                Toggle("One big row of cards instead of two small rows", isOn: $hordeAppViewModel.oneRowBoardInsteadOfTwo)
                    .foregroundColor(.white)
                    .onChange(of: hordeAppViewModel.oneRowBoardInsteadOfTwo) { _ in
                        hordeAppViewModel.saveBattlefieldRowStylePreference()
                    }
            }
            
            MenuTextSubtitleView(text: "Delete images")
            
            HStack {
                MenuTextParagraphView(text: "If the app takes too much storage space, use this button to delete all saved card images")
                
                Spacer()
                
                Button(action: {
                    DownloadManager.removeAllSavedImages()
                }, label: {
                    PurpleButtonLabel(text: "Delete")
                })
            }
        }.padding(.trailing, 30)
    }
}

struct MenuCustomBackgroundColorChoiceView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let gradientId: Int
    
    var body: some View {
        Button(action: {
            print("Changing background color to \(gradientId)")
            hordeAppViewModel.setBackgroundColorGradientTo(gradientId: gradientId)
        }, label: {
            GradientView(gradientId: gradientId).cornerRadius(15).frame(width: 150, height: 150).overlay(
                RoundedRectangle(cornerRadius: 19).stroke(hordeAppViewModel.gradientId == gradientId ? .white : .clear, lineWidth: 4)).padding(10)
        })
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
