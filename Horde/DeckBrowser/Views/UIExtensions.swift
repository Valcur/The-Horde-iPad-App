//
//  File.swift
//  Horde
//
//  Created by Loic D on 28/06/2023.
//

import SwiftUI

extension Text {
    func title() -> some View {
        ZStack {
            if UIDevice.isIPhone {
                self
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            } else {
                self
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
    
    func headline() -> some View {
        ZStack {
            if UIDevice.isIPhone {
                self
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            } else {
                self
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }
    
    func text() -> Text {
        self
            .font(.body)
            .foregroundColor(.white)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
            
        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.gray).text() }
    }
    
    func iPhoneScaler(maxHeight: CGFloat, scaleEffect: CGFloat = 0.8, anchor: UnitPoint = .center) -> some View {
        ZStack {
            if UIDevice.isIPhone {
                self
                    .scaleEffect(scaleEffect, anchor: anchor)
                    .frame(maxHeight: maxHeight)
            } else {
                self
            }
        }
    }
}
