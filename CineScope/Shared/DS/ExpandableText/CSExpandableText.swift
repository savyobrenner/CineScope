//
//  CSExpandableText.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import SwiftUI

struct CSExpandableText: View {
    let text: String
    let lineLimit: Int
    
    @State private var isExpanded = false
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            CSText(
                text: isExpanded ? text : "\(text.prefix(150))...",
                size: 13,
                type: .regular,
                color: .Brand.white
            )
            .animation(.easeInOut, value: isExpanded)
            .lineLimit(isExpanded ? nil : lineLimit)
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if text.count > 100 {
                CSText(
                    text:isExpanded ? "Less".localized : "More".localized,
                    size: 13,
                    type: .regular,
                    color: .Brand.white
                )
                .underline()
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}
