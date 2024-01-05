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
    let icon: Image?
    let font: Font
    let textColor: Color
    let primaryColor: Color
    let padding: CGFloat
    let radius: CGFloat
    let isLoading: Bool
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                primaryColor
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                        .scaleEffect(0.8)
                } else {
                    HStack(spacing: 10) {
                        Text(title)
                            .font(font)
                            .foregroundColor(textColor)
                        
                        icon?
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(textColor)
                    }
                    .padding(padding)
                }
            }
            .cornerRadius(radius)
            .frame(maxHeight: 50)
        }
        .disabled(isLoading)
    }
}
