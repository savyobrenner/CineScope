//
//  LisaText.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct LisaText: View {
    
    let text: String
    let size: CGFloat
    let type: BrandFontName
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.brand(type, size: size))
            .foregroundColor(color)
    }
}
