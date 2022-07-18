//
//  DeckEditorInfoView.swift
//  Horde
//
//  Created by Loic D on 17/07/2022.
//

import SwiftUI

struct DeckEditorInfoView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @State var changingImage: Bool = false
    @State var deckName: String = "Deck Name"
    @State var deckIntro: String = ""
    @State var deckRules: String = "All creatures controlled by the Horde have haste and abe  ze hz gze hag ag zg gazhr g aghrg ah hage ra gh aeg ahegrh aeghg aher haeg aehr ae rgae hrgae ae rhae g ahgr aegrhagr ef eufg hs hgdsf h"
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Image("Dinosaur")
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height)

            Button(action: {

            }, label: {
                Text("Select picture from your library")
                    .font(.title)
                    .foregroundColor(.white)
            }).opacity(changingImage ? 1 : 0)

            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).opacity(changingImage ? 0 : 1)
            
            VStack(alignment: .center, spacing: 10) {
                
                // Deck Name
                HStack {
                    TextField("", text: $deckName, onCommit: {

                    })
                    .foregroundColor(.white)
                    .font(.system(size: PickerSize.titleFontSize).bold())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                        
                    
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                }.padding(.bottom, 50).frame(width: UIScreen.main.bounds.width / 2)
                
                HStack(spacing: 50) {
                    // Intro
                    VStack {
                        Text("Intro")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        HStack {
                            TextEditor(text: $deckIntro)
                                .frame(height: 120)
                                .padding(.vertical)
                                .foregroundColor(.white)
                                .font(.title3)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.horizontal, 10)
                            
                            Image(systemName: "pencil")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                        }
                    }
                    
                    // Special Rules
                    
                    VStack {
                        Text("Special Rules")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        HStack {
                            TextEditor(text: $deckRules)
                                .frame(height: 120)
                                .padding(.vertical)
                                .foregroundColor(.white)
                                .font(.title3)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.horizontal, 10)
                            
                            Image(systemName: "pencil")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        deckEditorViewModel.showDeckEditorInfoView.toggle()
                    }
                }, label: {
                    MenuTextTitleView(text: "To deck editor")
                })
                Spacer()
            }.padding([.top], 80).padding(.horizontal, 30).opacity(changingImage ? 0 : 1)
            
            // Switch between text/image edit mode
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.changingImage.toggle()
                }
            }, label: {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
            }).position(x: UIScreen.main.bounds.width - 60, y: 50)
        }.ignoresSafeArea()
    }
}

struct DeckEditorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            DeckEditorInfoView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                //.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        } else {
            DeckEditorInfoView()
                .environmentObject(HordeAppViewModel())
                .environmentObject(DeckEditorViewModel())
        }
    }
}
