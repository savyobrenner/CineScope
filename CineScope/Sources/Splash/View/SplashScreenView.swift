//
//  SplashScreenView.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct SplashScreenView<ViewModel: SplashScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
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
                viewModel.proceedNavigation()
            }
        }
    }
}

import Factory

#Preview {
    SplashScreenView(
        viewModel: SplashScreenViewModel(
            router: Router(),
            serviceLocator: Container.shared.serviceLocator.resolve()
        ))
}
