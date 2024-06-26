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
            
            if hordeAppViewModel.readyToPlay {
                Button(action: {
                    print("Return to menu button pressed")
                    hordeAppViewModel.shouldShowMenu = false
                    hordeAppViewModel.readyToPlay = false
                }, label: {
                    PurpleButtonLabel(text: "Return to menu", isPrimary: true, noMaxWidth: true)
                        .frame(width: 200)
                }).position(x: 110, y: 40)
            }
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .trailing, spacing: 0) {
                    MenuButtonView(title: "Rules", id: 1)
                    MenuButtonView(title: "How to play", id: 2)
                    MenuButtonView(title: "Options", id: 4)
                    MenuButtonView(title: "Contact", id: 3)
                    Spacer()
                    Button(action: {
                        print("Return to menu button pressed")
                        hordeAppViewModel.shouldShowMenu = false
                    }, label: {
                        Text("Close")
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                    }).buttonStyle(StaticButtonStyle()).padding([.trailing, .bottom], 30)
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
                
                MenuTextParagraphView(text: "The goal of Horde Magic is to survive the onslaught of creatures. The Horde deck has no life total (see Additional rules if you want the Horde to use lifepoints), so the only way to win is to... uh... not die. Eventually the deck will run out of cards and you'll be able to breath sight of relief.")
                
                MenuTextParagraphView(text: "In Horde Magic, the Horde has no decisions to make, and thus the Horde deck also doesn't require a pilot to run. This creates unique co-op gameplay, which many are likely to really enjoy. Additionally, you can battle the Horde deck solo.")
            }
            
            Group {
                MenuTextSubtitleView(text: "Starting the Game")
                MenuTextParagraphView(text: "To play Horde Magic, each player needs a Commander deck. Any other Magic deck will do, but Horde Magic was developed to play with the multitude of Commander decks that people own.")
                
                MenuTextSubtitleView(text: "The Survivors")
                MenuTextParagraphView(text: "There can be anywhere between one and four Survivors, which are the players teaming up to defend against the Horde. The number of Survivors determine the number of cards in the Horde deck, as the difficulty needs to scale accordingly. The Survivors have a collective life total of 20 life per player, and everybody loses when that life total becomes 0.")
                
                MenuTextSubtitleView(text: "The Horde")
                MenuTextParagraphView(text: "The number of creatures you'll face over the course of the game is based on the number of Survivors. For less than 3 Survivors, take your 100 card Horde deck and remove between 25-75 cards (Using the deck size options).")
            }
            
            Group {
                MenuTextTitleView(text: "Game Play")
                
                MenuTextParagraphView(text: "The Survivors get 3 turns to set up their defenses before the Horde takes a turn. Just like in Archenemy and Two-Headed Giant, the Survivors take turns simultaneously. After the 3 turn set-up, the Survivors and the Horde alternate turns.")
                
                MenuTextParagraphView(text: "On each of the Horde's turns, the top card of their library is flipped over. If the card is a creature token, then another is flipped over. Cards are flipped over until a non-token card is revealed. Sometimes the card is a Bad Moon, sometimes it's a Souless One, and sometimes it's even a Plague Wind. At that point, all of the tokens flipped this way are cast, and the non-token card is cast last.")
                
                MenuTextParagraphView(text: "Then the Horde enter combat. All its creatures come charging in without thinking twice. All creatures have haste and must attack each turn if able. That's just how they roll. Since the survivors are on a team together, when the Horde attack, they attack every player at the same time, just like in Two-Headed Giant, and when any of the survivors choose to block, they block for the whole team.")
            }
            
            Group {
                
                MenuTextSubtitleView(text: "Defeating the Horde")
                
                MenuTextParagraphView(text: "You, as the Survivors, win when the Horde deck can't flip over anymore cards, and the Horde doesn't control any more creatures. You can use anything at your disposal to stem the bleeding, from Walls, to Wrath of Gods, to blocking with huge fatties. However, if you and your teammates feel that you have adequate defenses for the next attack, you can also attack the Horde at it's source. Creatures can't block, so it's safe to go on the offensive if you think you can survive the next wave.")
                
                MenuTextBoldParagraphView(text: "For each point of damage done to the Horde, the Horde mills one card off the top of their deck.")
                
                MenuTextSubtitleView(text: "Winning")
                MenuTextParagraphView(text: "The Survivors are victorious when all the creatures in play are dead, and the Horde deck has run out of cards. The Horde wins when the Survivors' life total becomes 0.")
            }
            Group {
                MenuTextTitleView(text: "Rules Notes")
                MenuTextParagraphView(text: "The Horde deck is built so that, hopefully, the Horde is not presented with any decisions. However, there are lots of cards that the Survivors might play that cause the Horde to make a choice (such as Fact or Fiction or Chainer's Edict). In this case, the Horde makes this choice as randomly as possible.")
                MenuTextParagraphView(text: "The creature tokens and cards from the Horde deck use the stack, so you can respond to them coming into to play, or counter them.")
                MenuTextParagraphView(text: "The Horde never use any activated abilities of permanents it controls unless stated by the deck special rules.")
                MenuTextParagraphView(text: "The Horde has infinite mana, so cards like Propaganda and Mana Leak don't work. Sorry! The Horde always pays kicker or any other additional cost.")
                MenuTextParagraphView(text: "If you return a permanent to the Horde's hand, it gets cast again on their next turn.")
                MenuTextParagraphView(text: "There are a LOT of Magic cards in existence. If something doesn't work the way it's supposed to, just come up with the most fair way to execute the card. If you can't, cycle it. This is a casual format.")
                MenuTextParagraphView(text: "If the horde has to choose a target, it choose the BEST target. BEST is higher strength, then higher Mana Value. If still multiple possible targets, targets randomly")
                MenuTextParagraphView(text: "If survivors have planeswalkers, each time a creature controlled by the horde isn't blocked, it deals damage to the planeswalker. Target the planeswalker with highest Mana Value first if survivors have multiple planeswalkers.")
            }

            Group {
                MenuTextTitleView(text: "Additional rules")
                
                MenuTextParagraphView(text: "Optional : the Horde starts with 20 lifepoints and only mills its library when his lifepoints are equal to 0.")
                
                MenuTextParagraphView(text: "Optional : each time a permanent or an ability controlled by the Horde deals damage to the survivors, the Horde gains that much life.")
                
                MenuTextBoldParagraphView(text: "Remember that this is a casual format, you can change as many rules as you want. What matters is that you have fun.")
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
            .font(UIDevice.isIPhone ? .title2 : .title)
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
                        
                        MenuTextParagraphView(text: "Yes, to download card images (dark color is shown while the image is downloading)")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "When I open a deck for the first time, it takes way too long to download images")
                        
                        MenuTextParagraphView(text: "Images are downloaded from Scryfall, they ask to download only two images per second.")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "Difference between Classic and Marathon ?")
                        
                        MenuTextParagraphView(text: "Classic : One deck to beat")
                        
                        MenuTextParagraphView(text: "Marathon : Three deck to beat. Token mulitplicator increase and strong permanents enters the battlefield between each new deck")
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to use the life counter ?")
                        
                        MenuTextParagraphView(text: "Swipe up/down to increase/decrease. If you want to make a small change, press the upper part to increase, or the bottom part to decrease")
                        
                        MenuTextParagraphView(text: "By default, the Horde heal when survivors lose life. If you don't want to play with this rules you can disable it in the 'Options' menu")
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
                
                Group {
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to handle the Horde's hand ?")
                        
                        MenuTextParagraphView(text: "Press the button with a hand icon to enable/disable the 'return to hand' mode. While the mode is enable, press a card on the battlefield to return it to the horde's hand")
                        
                        MenuTextParagraphView(text: "Press the Draw One button to make the horde draw a card")
                        
                        MenuTextParagraphView(text: "Press a card in the horde's hand to make the horde discard it")
                    }
                }
                
                Group {
                    VStack(alignment: .leading, spacing: 20) {
                        MenuTextBoldParagraphView(text: "How to add/remove counters on cards ?")
                        
                        MenuTextParagraphView(text: "Press the button with a +/- to enable/disable the 'add/remove' mode. While the 'add' mode is enable, press a card on the battlefield to add a counter to it. While the 'remove' mode is enable, press a card on the battlefield to remove a counter to it.")
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
                        MenuTextBoldParagraphView(text: "Can I import a horde decklist I found on another website ?")
                        
                        MenuTextParagraphView(text: "No, you can only import decklist made using this app.")
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
            CodePanel()
            
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
            
            Link(destination: URL(string: "https://discord.com/invite/wzm7bu6KDJ")!) {
                VStack {
                    MenuTextParagraphView(text: "Join us on Discord !")
                    Image("DiscordIcon")
                        .resizable()
                        .frame(width: 280, height: 75)
                }
            }
            
            MenuTextTitleView(text: "Info")
            
            MenuTextParagraphView(text: "App icon by Superarticons")
            
            MenuTextParagraphView(text: "Sleeves art by Pazuah")
            
            MenuTextBoldParagraphView(text: "This app is unofficial Fan Content permitted under the Fan Content Policy. Not approved/endorsed by Wizards. Portions of the materials used are property of Wizards of the Coast. ©Wizards of the Coast LLC.")
        }.padding(.trailing, 30)
    }
}

struct MenuCustomView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 30) {
            Group {
                MenuTextSubtitleView(text: "Background")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ZStack(alignment: .topTrailing) {
                            MenuUploadCustomBackgroundImage()
                                .opacity(hordeAppViewModel.isPremium ? 1 : 0.5).allowsHitTesting(hordeAppViewModel.isPremium)
                            if !hordeAppViewModel.isPremium {
                                Image(systemName: "crown.fill").foregroundColor(.white).font(.title)
                                    .offset(x: 5, y: -5)
                            }
                        }
                        
                        MenuCustomBackgroundColorChoiceView(gradientId: 1)
                        MenuCustomBackgroundColorChoiceView(gradientId: 2)
                        MenuCustomBackgroundColorChoiceView(gradientId: 3)
                        MenuCustomBackgroundColorChoiceView(gradientId: 4)
                        MenuCustomBackgroundColorChoiceView(gradientId: 5)
                        MenuCustomBackgroundColorChoiceView(gradientId: 6)
                        MenuCustomBackgroundColorChoiceView(gradientId: 7)
                        MenuCustomBackgroundColorChoiceView(gradientId: 8)
                    }.padding(.vertical, 3)
                }
                
                Toggle("Use less colorful background", isOn: $hordeAppViewModel.useLessColorFullBackground)
                    .foregroundColor(.white)
                    .onChange(of: hordeAppViewModel.useLessColorFullBackground) { _ in
                        hordeAppViewModel.saveStylePreferences()
                    }
                
                HStack {
                    MenuTextSubtitleView(text: "Custom Sleeves")
                    Image(systemName: "crown.fill").foregroundColor(.white).font(.title)
                }
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            MenuCustomSleeveArtChoiceView(artId: -1)
                            MenuUploadCustomArtView(artId: 0)
                            MenuCustomSleeveArtChoiceView(artId: 1)
                            MenuCustomSleeveArtChoiceView(artId: 2)
                            MenuCustomSleeveArtChoiceView(artId: 3)
                            MenuCustomSleeveArtChoiceView(artId: 4)
                            MenuCustomSleeveArtChoiceView(artId: 5)
                            MenuCustomSleeveArtChoiceView(artId: 6)
                            MenuCustomSleeveArtChoiceView(artId: 7)
                            MenuCustomSleeveArtChoiceView(artId: 8)
                        }
                    }
                    
                    HStack(spacing: 10) {
                        MenuTextParagraphView(text: "Border Color")
                        Spacer()
                        MenuCustomSleeveBorderColorChoiceView(colorId: 0)
                        MenuCustomSleeveBorderColorChoiceView(colorId: 1)
                    }
                }.opacity(hordeAppViewModel.isPremium ? 1 : 0.5).allowsHitTesting(hordeAppViewModel.isPremium)
            }
            
            Group {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    MenuTextSubtitleView(text: "Battlefield")
                    
                    Toggle("One big row of cards instead of two small rows", isOn: $hordeAppViewModel.oneRowBoardInsteadOfTwo)
                        .foregroundColor(.white)
                        .onChange(of: hordeAppViewModel.oneRowBoardInsteadOfTwo) { _ in
                            hordeAppViewModel.saveBattlefieldRowStylePreference()
                        }
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

struct MenuCustomSleeveBorderColorChoiceView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let colorId: Int
    
    var body: some View {
        Button(action: {
            print("Changing sleeve border color to \(colorId == 0 ? "Black" : "White")")
            hordeAppViewModel.setCustomSleeveBorderColorIdTo(borderId: colorId)
        }, label: {
            Rectangle()
                .foregroundColor(colorId == 0 ? .black : .white).opacity(0.8)
                .cornerRadius(15)
                .frame(width: 50, height: 50)
                .overlay(RoundedRectangle(cornerRadius: 19).stroke(hordeAppViewModel.customSleeveBorderColorId == colorId ? .white : .clear, lineWidth: 4)).padding(10)
        })
    }
}

struct MenuCustomSleeveArtChoiceView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    let artId: Int  // -1 for no art, 0 for uploaded image, > 0 for other
    
    var body: some View {
        Button(action: {
            print("Changing sleeve art color to \(artId)")
            hordeAppViewModel.setCustomSleeveArtIdTo(artId: artId)
        }, label: {
            ZStack {
                if artId == -1 {
                    ZStack {
                        Text("Disable")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                } else {
                    SleeveArtImageView(artId: artId)
                }
            }.frame(width: 150, height: 150).clipped().cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 19).stroke(hordeAppViewModel.customSleeveArtId == artId ? .white : .clear, lineWidth: 4)).padding(10)
        })
    }
}

struct MenuUploadCustomArtView: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State var showingImagePicker: Bool = false
    let artId: Int
    var customArtIsSelected: Bool {
        return hordeAppViewModel.customSleeveArtId == artId
    }
    
    var body: some View {
        Button(action: {
            if customArtIsSelected || UserDefaults.standard.data(forKey: "CustomSleeveArtImage") == nil {
                self.showingImagePicker.toggle()
            } else {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hordeAppViewModel.setCustomSleeveArtIdTo(artId: artId)
                }
            }
        }, label: {
            ZStack {
                SleeveArtImageView(artId: artId).opacity(0.5)
                    .frame(width: 150, height: 150)
                VStack {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    if customArtIsSelected {
                        Spacer()
                        
                        Text("Tap again to upload another picture")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(width: 120)
                    }
                }.padding(15)
            }
        })
        .frame(width: 150, height: 150).clipped().cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 19).stroke(customArtIsSelected ? .white : .clear, lineWidth: 4)).padding(10)
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            image = Image("BlackBackground")
            return
        }
        hordeAppViewModel.saveCustomSleeveArt(image: inputImage)
        withAnimation(.easeInOut(duration: 0.3)) {
            hordeAppViewModel.setCustomSleeveArtIdTo(artId: artId)
        }
        image = Image(uiImage: inputImage)
    }
}

struct MenuUploadCustomBackgroundImage: View {
    
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State var showingImagePicker: Bool = false
    var customArtIsSelected: Bool {
        return hordeAppViewModel.gradientId == -1
    }
    
    var body: some View {
        Button(action: {
            if customArtIsSelected || UserDefaults.standard.data(forKey: "CustomBackgroundArtImage") == nil {
                self.showingImagePicker.toggle()
            } else {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hordeAppViewModel.setBackgroundColorGradientTo(gradientId: -1)
                }
            }
        }, label: {
            ZStack {
                GradientView(gradientId: -1)
                    .frame(width: 150, height: 150)
                VStack {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    if customArtIsSelected {
                        Spacer()
                        
                        Text("Tap again to upload another picture")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(width: 120)
                    }
                }.padding(15)
            }
        })
        .frame(width: 150, height: 150).clipped().cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 19).stroke(customArtIsSelected ? .white : .clear, lineWidth: 4)).padding(10)
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            image = Image("BlackBackground")
            return
        }
        hordeAppViewModel.saveCustomBackgroundArt(image: inputImage)
        withAnimation(.easeInOut(duration: 0.3)) {
            hordeAppViewModel.setBackgroundColorGradientTo(gradientId: -1)
        }
        image = Image(uiImage: inputImage)
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
