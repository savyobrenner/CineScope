//
//  CSBaseButton.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

internal struct CSBaseButton: View {
    
    let action: (() -> Void)?
    let title: String
    let font: Font
    let textColor: Color
    let primaryColor: Color
    let padding: CGFloat
    let radius: CGFloat
    let isLoading: Bool
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                primaryColor
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(title)
                        .font(font)
                        .foregroundColor(textColor)
                        .padding(padding)
                }
            }
            .cornerRadius(radius, corners: .allCorners)
            .frame(maxHeight: 50)
        }
        .disabled(isLoading)
    }
}
