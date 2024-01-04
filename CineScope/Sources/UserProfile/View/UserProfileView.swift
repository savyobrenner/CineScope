//
//  UserProfileView.swift
//  CineScope
//
//  Created by Savyo Brenner on 02/01/24.
//

import SwiftUI

struct UserProfileView<ViewModel: UserProfileViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State private var isShowingImagePicker = false
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack(spacing: 15) {
                userProfile
                    .padding(.top, 150)
                    .onTapGesture {
                        self.isShowingImagePicker = true
                    }
                
                CSText(
                    text: viewModel.user?.name ?? "",
                    size: 20,
                    type: .semibold,
                    color: .Brand.white
                )
                
                
                CSText(
                    text: viewModel.user?.email ?? "",
                    size: 14,
                    type: .italic,
                    color: .Brand.white
                )
                
                Spacer()
                
                CSButton(
                    title: "Logout".localized,
                    style: .primary) {
                        viewModel.logout()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 80)
                
            }
            
            if viewModel.isLoading {
                CSLoadingView()
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            CSImagePicker(selectedImage: $viewModel.selectedImage)
                .ignoresSafeArea()
        }
        .toast(message: $viewModel.toastMessage, type: viewModel.toastMessage?.type ?? .info)
        .onReceive(viewModel.userUpdated) { }
    }
    
    private var backgroundImage: some View {
        Image("background_gradient")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var userProfile: some View {
        Group {
            if let photo = viewModel.user?.photoURL {
                CSImageView(url: photo)
                    .foregroundColor(.Brand.secondary)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 91, height: 91)
                    .cornerRadius(20)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.Brand.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 91, height: 91)
                    .background(Color.Brand.placeholder)
                    .cornerRadius(20)
            }
        }
    }
}

import Factory
#Preview {
    UserProfileView(
        viewModel: UserProfileViewModel(
            userServices: Container.shared.userServices.resolve(),
            router: Router(),
            serviceLocator: Container.shared.serviceLocator.resolve()
        )
    )
}
