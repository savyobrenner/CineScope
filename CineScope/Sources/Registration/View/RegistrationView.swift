//
//  RegistrationView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct RegistrationView<ViewModel: RegistrationViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showingToast = false
    
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
                        stateObservable: $viewModel.password,
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
            isPresented: $showingToast,
            type: viewModel.toastMessage?.type ?? .info,
            message: viewModel.toastMessage?.message ?? ""
        )
        .onChange(of: viewModel.toastMessage) { _ in
            showingToast = viewModel != nil
        }
    }
}

#Preview {
    RegistrationView(viewModel: RegistrationViewModel(authenticationService: FirebaseManager()))
}
