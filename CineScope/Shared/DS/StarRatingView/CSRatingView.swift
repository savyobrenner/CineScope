//
//  CSRatingView.swift
//  CineScope
//
//  Created by Savyo Brenner on 04/01/24.
//

import SwiftUI

struct CSStarRatingView: View {
    var rating: Int 
    
    private func starType(index: Int) -> String {
        return index < rating ? "star.fill" : "star"
    }
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: starType(index: index))
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
            }
        }
    }
}
