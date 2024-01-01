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
                header
                
                Spacer()
            }
            .background(
                Image("home_background_gradient")
                    .aspectRatio(contentMode: .fill)
            )
            
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
    
    var header: some View {
        HStack {
            CSText(
                text: "Home",
                size: 19,
                type: .semibold,
                color: .Brand.white
            )
            
            Spacer()
            
            HStack(spacing: 30) {
                
                Button(action: {
                    
                }, label: {
                    Image("search_icon")
                        .resizable()
                        .frame(width: 20, height: 20)
                })
                
                if let photo = viewModel.user?.photoURL?.absoluteString {
                    Image(photo)
                        .resizable()
                        .foregroundColor(.Brand.secondary)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20, corners: .allCorners)
                } else {
                    Image(systemName: "person")
                        .foregroundColor(.Brand.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .background(
                            Color.Brand.placeholder
                                .cornerRadius(20, corners: .allCorners)
                                .frame(width: 40, height: 40)
                        )
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

import Factory
#Preview {
    HomeView(
        viewModel: HomeViewModel(
            homeServices: Container.shared.homeServices.resolve(),
            router: Router(),
            serviceLocator: Container.shared.serviceLocator.resolve()
        )
    )
}
