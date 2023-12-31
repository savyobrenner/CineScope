//
//  LoginView.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    
    // TODO: - Move this vars to viewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
            
            VStack(alignment: .trailing, spacing: 10) {
                CSTextField(
                    stateObservable: $email,
                    inputFieldPlaceholder: "Email"
                )
                
                CSTextField(
                    stateObservable: $password,
                    inputFieldPlaceholder: "Password",
                    contentType: .password
                )
                
                Button(action: {
                    // TODO: - Change to Recovery Password flow
                }, label: {
                    CSText(
                        text: "Forgot password ?",
                        size: 13,
                        type: .medium,
                        color: .Brand.white
                    )
                    .underline()
                })
                
                CSButton(
                    title: "Login",
                    style: .primary) {
                        //TODO: -  Delegate this logic to viewModel
                        router.navigate(to: .tabBar)
                    }
                    .padding(.top, 20)
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 5) {
                CSText(
                    text: "Don’t have an account ?",
                    size: 13,
                    type: .medium,
                    color: .Brand.white
                )
                
                Button(action: {
                    router.navigate(to: .registration)
                }, label: {
                    CSText(
                        text: "Create a new one",
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
    }
}

#Preview {
    LoginView()
}
