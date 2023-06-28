//
//  Misc.swift
//  Horde
//
//  Created by Loic D on 21/06/2023.
//

import SwiftUI

extension View {
    func scrollablePanel() -> some View {
        ScrollView(.vertical) {
            self.padding(15)
        }.padding(5).frame(maxWidth: .infinity)
    }
    
    func shadowed(radius: CGFloat = 4, y: CGFloat = 4) -> some View {
        self
            .shadow(color: Color("ShadowColor"), radius: radius, x: 0, y: y)
    }
    
    func blurredBackground() -> some View {
        self
            .background( VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .cornerRadius(15)
                .shadowed())
    }
}
