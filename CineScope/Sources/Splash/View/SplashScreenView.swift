//
//  SplashScreenView.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Image("background_gradient")
            
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
        }
        .ignoresSafeArea()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                router.navigate(to: .login)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
