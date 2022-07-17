//
//  DeckEditorInfoView.swift
//  Horde
//
//  Created by Loic D on 17/07/2022.
//

import SwiftUI

struct DeckEditorInfoView: View {
    
    @State var changingImage: Bool = false
    
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

            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark)).opacity(changingImage ? 0 : 0.5)
            
            VStack(alignment: .center, spacing: 20) {
                
                // Deck Name
                Button(action: {
                    self.changingImage.toggle()
                }, label: {
                    HStack {
                        Text("Deck Name")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: PickerSize.titleFontSize))
                        
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: PickerSize.titleFontSize))
                            .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                    }
                }).padding(.bottom, 100)
                
                // Intro
                Button(action: {
                    self.changingImage.toggle()
                }, label: {
                    HStack {
                        Text("Deck description")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Image(systemName: "pencil")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                    }
                })
                
                // Special Rules
                
                Text("Special Rules")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Button(action: {
                    self.changingImage.toggle()
                }, label: {
                    HStack {
                        Text("All creatures controlled by the Horde have haste")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        Image(systemName: "pencil")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .shadow(color: Color("ShadowColor"), radius: 8, x: 0, y: 4)
                    }
                })
            }.frame(width: UIScreen.main.bounds.width / 2).padding([.top], 80).opacity(changingImage ? 0 : 1)
            
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
