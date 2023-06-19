//
//  DeckEditorInfoView.swift
//  Horde
//
//  Created by Loic D on 17/07/2022.
//

import SwiftUI

struct DeckEditorInfoView: View {
    
    @EnvironmentObject var deckEditorViewModel: DeckEditorViewModel
    @EnvironmentObject var hordeAppViewModel: HordeAppViewModel
    @State var changingImage: Bool = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image = Image("Dinosaur")
    @StateObject var deckNametextBindingManager = TextBindingManager(limit: 14)
    @State var deckIntro: String = ""
    @State var deckRules: String = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            
            image
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

            VStack {
                Spacer()
                Button(action: {
                    showingImagePicker = true
                }, label: {
                    ZStack {
                        VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        Text("Select picture from your library")
                            .font(.title3)
                            .foregroundColor(.white)
                    }.frame(width: 320, height: 60).cornerRadius(30).shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                    
                }).opacity(changingImage ? 1 : 0)
                    .onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
            }.padding(50)

            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).opacity(changingImage ? 0 : 1)
            
            VStack(alignment: .center, spacing: 10) {
                
                // Deck Name
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                        .padding()
                    
                    TextField("", text: $deckNametextBindingManager.text, onCommit: {

                    })
                    .foregroundColor(.white)
                    .font(.system(size: PickerSize.titleFontSize).bold())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                }.padding(.bottom, 30).frame(width: UIScreen.main.bounds.width / 2)
                
                HStack(spacing: 50) {
                    // Intro
                    VStack {
                        Text("Intro")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title3)
                        
                        HStack {
                            Image(systemName: "pencil")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                                .padding()
                            
                            if #available(iOS 16, *) {
                                TextEditor(text: $deckIntro)
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 120)
                                    .padding(.vertical)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal, 10)
                                    .border(.white, width: 2)
                            } else {
                                TextEditor(text: $deckIntro)
                                    .frame(height: 120)
                                    .padding(.vertical)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal, 10)
                                    .border(.white, width: 2)
                            }
                        }
                    }
                    
                    // Special Rules
                    
                    VStack {
                        Text("Special Rules")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.title3)
                        
                        HStack {
                            Image(systemName: "pencil")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                                .padding()
                            
                            if #available(iOS 16, *) {
                                TextEditor(text: $deckRules)
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 120)
                                    .padding(.vertical)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal, 10)
                                    .border(.white, width: 2)
                            } else {
                                TextEditor(text: $deckRules)
                                    .frame(height: 120)
                                    .padding(.vertical)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding(.horizontal, 10)
                                    .border(.white, width: 2)
                            }
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        deckEditorViewModel.showDeckEditorInfoView.toggle()
                        deckEditorViewModel.saveDeckName(text: deckNametextBindingManager.text)
                        deckEditorViewModel.saveIntroText(text: deckIntro)
                        deckEditorViewModel.saveRulesText(text: deckRules)
                    }
                }, label: {
                    MenuTextTitleView(text: "Back to deck editor")
                })
                Spacer()
            }.padding([.top], 50).padding(.horizontal, 30).opacity(changingImage ? 0 : 1)
            
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
            .onChange(of: deckEditorViewModel.deckId) { deckId in
                if deckId >= 0 {
                    deckNametextBindingManager.text = deckEditorViewModel.loadDeckName()
                    deckIntro = deckEditorViewModel.loadIntroText()
                    deckRules = deckEditorViewModel.loadRulesText()
                    inputImage = deckEditorViewModel.loadImage()
                    loadImage()
                }
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            image = Image("BlackBackground")
            return
        }
        deckEditorViewModel.saveImage(image: inputImage)
        image = Image(uiImage: inputImage)
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
