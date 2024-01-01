//
//  HomeView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
            }.overlay {
                Image("home_background_gradient")
                    .aspectRatio(contentMode: .fill)
            }
            
            if viewModel.isLoading {
                CSLoadingView()
            }
        }
        .toast(
            message: $viewModel.toastMessage,
            type: viewModel.toastMessage?.type ?? .info
        )
        .onAppear(perform: {
            viewModel.fetchPopularMovies()
        })
    }
}

import Factory
#Preview {
    HomeView(
        viewModel: HomeViewModel(
            homeServices: Container.shared.homeServices.resolve(),
            router: Router()
        )
    )
}
