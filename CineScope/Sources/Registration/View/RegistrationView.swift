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
                        inputFieldPlaceholder: "Name"
                    )
                    
                    CSTextField(
                        stateObservable: $viewModel.email,
                        inputFieldPlaceholder: "Email"
                    )
                    
                    CSTextField(
                        stateObservable: $viewModel.password,
                        inputFieldPlaceholder: "Password",
                        contentType: .password
                    )
                    
                    CSButton(
                        title: "Register",
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

#Preview {
    RegistrationView(viewModel: RegistrationViewModel(authenticationService: FirebaseManager()))
}
