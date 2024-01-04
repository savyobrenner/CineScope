//
//  LoginView.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                VStack(alignment: .trailing, spacing: 10) {
                    CSTextField(
                        stateObservable: $viewModel.email,
                        inputFieldPlaceholder: "Email".localized
                    )
                    
                    CSTextField(
                        stateObservable: $viewModel.password,
                        inputFieldPlaceholder: "Password".localized,
                        contentType: .password
                    )
                    
                    Button(action: {
                        // TODO: - Change to Recovery Password flow
                    }, label: {
                        CSText(
                            text: "Forgot password ?".localized,
                            size: 13,
                            type: .medium,
                            color: .Brand.white
                        )
                        .underline()
                    })
                    
                    CSButton(
                        title: "Login".localized,
                        style: .primary) {
                            viewModel.login()
                        }
                        .padding(.top, 20)
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 5) {
                    CSText(
                        text: "Don’t have an account ?".localized,
                        size: 13,
                        type: .medium,
                        color: .Brand.white
                    )
                    
                    Button(action: {
                        viewModel.registrationButtonWasPressed()
                    }, label: {
                        CSText(
                            text: "Create a new one".localized,
                            size: 13,
                            type: .medium,
                            color: .Brand.secondary
                        )
                        .underline()
                    })
                }
                .padding(.bottom, 30)
            }
            .background(
                Image("background_gradient")
            )
            .padding(.horizontal, 25)
            
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
    LoginView(
        viewModel: LoginViewModel(
            authenticationService: Container.shared.authenticationServices(),
            router: Router(), 
            serviceLocator: Container.shared.serviceLocator()
        )
    )
}
