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
    private let noMaxWidth: Bool
    private let minWidth: CGFloat
    
    init(text: String, isPrimary: Bool = false, noMaxWidth: Bool = false, minWidth: CGFloat = 100) {
        self.text = text
        self.isPrimary = isPrimary
        self.noMaxWidth = noMaxWidth
        self.minWidth = minWidth
    }
    
    var body: some View {
        if isPrimary {
            Text(text)
                .headline()
                .padding()
                .frame(maxWidth: noMaxWidth ? .infinity : 150).frame(height: 50).frame(minWidth: minWidth)
                .background(Color.black)
                    .cornerRadius(15)
                    .shadowed()
                .padding(UIDevice.isIPhone ? 0 : 10)
        } else {
            Text(text)
                .headline()
                .padding()
                .frame(maxWidth: noMaxWidth ? .infinity : 170).frame(height: 50).frame(minWidth: minWidth)
                .blurredBackground()
                .padding(UIDevice.isIPhone ? 0 : 10)
        }
    }
}

struct PurpleButtonLabel_iPhone: View {
    private let text: String
    private let isPrimary: Bool
    private let minWidth: CGFloat
    private let noMaxWidth: Bool
    
    init(text: String, isPrimary: Bool = false, noMaxWidth: Bool = false, minWidth: CGFloat = 100) {
        self.text = text
        self.isPrimary = isPrimary
        self.minWidth = minWidth
        self.noMaxWidth = noMaxWidth
    }
    
    var body: some View {
        ZStack {
            PurpleButtonLabel(text: text, isPrimary: isPrimary, noMaxWidth: noMaxWidth, minWidth: minWidth + 40).frame(minWidth: minWidth).scaleEffect(0.7)
        }.frame(width: minWidth).clipped()
    }
}
