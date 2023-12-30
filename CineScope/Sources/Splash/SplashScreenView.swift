//
//  SplashScreenView.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("background_gradient")
            
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreenView()
}
