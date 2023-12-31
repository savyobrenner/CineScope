//
//  CSLoadingView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct CSLoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .Brand.white))
                    .scaleEffect(2)

                Text("Loading...")
                    .font(.brand(.black, size: 16))
                    .foregroundColor(.white)
            }
            .padding(30)
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    CSLoadingView()
}
