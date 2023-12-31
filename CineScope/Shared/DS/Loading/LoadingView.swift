//
//  LoadingView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .frame(width: 100, height: 100)
                .background(Color.secondary.colorInvert())
                .foregroundColor(.primary)
                .cornerRadius(10)
        }
    }
}
