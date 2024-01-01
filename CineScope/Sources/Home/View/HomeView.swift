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
            Image("home_background_gradient")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                if let posterPath = viewModel.movies.first?.posterPathURL {
                    CSImageView(url: posterPath)
                        .scaledToFill()
                        .frame(height: 390)
                        .overlay(
                            LinearGradient(gradient: Gradient(
                                colors: [
                                    Color.Brand.firstGradient.opacity(1),
                                    Color.Brand.secondGradient.opacity(0.5),
                                    Color.Brand.thirdGradient.opacity(1)
                                ]), startPoint: .bottomLeading, endPoint: .bottomTrailing
                            )
                            .frame(height: 390)
                        )
                        .clipped()
                        .ignoresSafeArea()
                    
                    Spacer()
                } else {
                    //TODO: - remove
                    Image("preview_home_main_image")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 390)
                        .overlay(
                            LinearGradient(gradient: Gradient(
                                colors: [
                                    Color.Brand.firstGradient.opacity(1),
                                    Color.Brand.secondGradient.opacity(0.5),
                                    Color.Brand.thirdGradient.opacity(1)
                                ]), startPoint: .bottomLeading, endPoint: .bottomTrailing
                            )
                            .frame(height: 390)
                        )
                        .clipped()
                        .ignoresSafeArea()
                    
                    Spacer()
                }
            }
            .overlay(
                VStack(alignment: .center, spacing: 40) {
                    CSText(
                        text: "Zack Snyder’s Justice League",
                        size: 18,
                        type: .semibold,
                        color: .Brand.white
                    )
                    
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            VStack(alignment: .center, spacing: 10) {
                                Image("info_icon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                CSText(
                                    text: "Info",
                                    size: 10,
                                    type: .medium,
                                    color: .Brand.white
                                )
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            VStack(alignment: .center, spacing: 10) {
                                Image("play_icon")
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                
                                CSText(
                                    text: "Play",
                                    size: 10,
                                    type: .medium,
                                    color: .Brand.white
                                )
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            VStack(alignment: .center, spacing: 10) {
                                Image("plus_icon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                
                                CSText(
                                    text: "Add",
                                    size: 10,
                                    type: .medium,
                                    color: .Brand.white
                                )
                            }
                        })
                        
                        Spacer()
                    }
                }
                    .padding(.top, -250)
            )
            
            VStack {
                header
                    .padding(.top, 80)
                
                Spacer()
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
                
                if let photo = viewModel.user?.photoURL {
                    CSImageView(url: photo)
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
