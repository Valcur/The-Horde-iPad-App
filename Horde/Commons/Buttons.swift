//
//  Buttons.swift
//  Horde
//
//  Created by Loic D on 21/06/2023.
//

import SwiftUI

// Change name, not purple anymore
struct PurpleButtonLabel: View {
    private let text: String
    private let isPrimary: Bool
    
    init(text: String, isPrimary: Bool = false) {
        self.text = text
        self.isPrimary = isPrimary
    }
    
    var body: some View {
        if isPrimary {
            Text(text)
                .headline()
                .padding()
                .frame(maxWidth: 150).frame(height: 50).frame(minWidth: 100)
                .background(Color.black)
                    .cornerRadius(15)
                    .shadowed()
                .padding(UIDevice.isIPhone ? 0 : 10)
        } else {
            Text(text)
                .headline()
                .padding()
                .frame(maxWidth: 170).frame(height: 50).frame(minWidth: 100)
                .blurredBackground()
                .padding(UIDevice.isIPhone ? 0 : 10)
        }
    }
}

struct PurpleButtonLabel_iPhone: View {
    private let text: String
    private let isPrimary: Bool
    
    init(text: String, isPrimary: Bool = false) {
        self.text = text
        self.isPrimary = isPrimary
    }
    
    var body: some View {
        ZStack {
            PurpleButtonLabel(text: text, isPrimary: isPrimary).frame(minWidth: 140).scaleEffect(0.7)
        }.frame(width: 100).clipped()
    }
}
