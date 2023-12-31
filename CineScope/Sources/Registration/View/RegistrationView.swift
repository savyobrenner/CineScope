//
//  RegistrationView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct RegistrationView<ViewModel: RegistrationViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                VStack(alignment: .trailing, spacing: 10) {
                    CSTextField(
                        stateObservable: $viewModel.name,
                        inputFieldPlaceholder: "Name".localized
                    )
                    
                    CSTextField(
                        stateObservable: $viewModel.email,
                        inputFieldPlaceholder: "Email".localized
                    )
                    
                    CSTextField(
                        stateObservable: $viewModel.password,
                        inputFieldPlaceholder: "Password".localized,
                        contentType: .password
                    )
                    
                    CSButton(
                        title: "Register".localized,
                        style: .primary) {
                            viewModel.register()
                        }
                        .padding(.top, 20)
                }
            }
            .background(
                Image("background_gradient")
            )
            .padding(.horizontal, 25)
            .padding(.bottom, 100)
            
            if viewModel.isLoading {
                CSLoadingView()
            }
        }
        .toast(
            message: $viewModel.toastMessage,
            type: viewModel.toastMessage?.type ?? .info
        )
    }
}

import Factory
#Preview {
    RegistrationView(
        viewModel: RegistrationViewModel(
            authenticationService: Container.shared.authenticationService(),
            router: Router()
        )
    )
}
