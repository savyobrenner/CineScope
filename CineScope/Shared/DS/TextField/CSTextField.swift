//
//  CSTextField.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

struct CSTextField: View {
    @Binding var stateObservable: String
    var inputFieldPlaceholder: String = ""
    var contentType: UITextContentType = .name
    
    @State private var isSecureTextEntry = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if contentType == .password || contentType == .newPassword {
                    ZStack(alignment: .leading) {
                        if stateObservable.isEmpty {
                            Text(inputFieldPlaceholder)
                                .foregroundColor(.Brand.placeholder)
                                .padding(.leading)
                                .font(.brand(.medium, size: 14))
                        }
                        
                        if isSecureTextEntry {
                            SecureField("", text: $stateObservable)
                                .textContentType(contentType)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(.Brand.white)
                                .font(.brand(.medium, size: 14))
                                .keyboardType(.emailAddress)
                                .autocapitalization(contentType == .name ? .words : .none)
                        } else {
                            TextField("", text: $stateObservable)
                                .textContentType(contentType)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(10)
                                .foregroundColor(.Brand.white)
                                .font(.brand(.medium, size: 14))
                                .keyboardType(.emailAddress)
                                .autocapitalization(contentType == .name ? .words : .none)
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                isSecureTextEntry.toggle()
                            }) {
                                Image(systemName: isSecureTextEntry ? "eye" : "eye.slash")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.Brand.white)
                                    .padding(.trailing, 8)
                            }
                            .padding(.trailing, 4)
                        }
                    }
                    
                } else {
                    ZStack(alignment: .leading) {
                        if stateObservable.isEmpty {
                            Text(inputFieldPlaceholder)
                                .foregroundColor(.Brand.placeholder)
                                .font(.brand(.medium, size: 14))
                                .padding(.leading)
                        }
                        
                        TextField("", text: $stateObservable)
                            .textContentType(contentType)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.Brand.white)
                            .font(.brand(.medium, size: 14))
                            .keyboardType(.emailAddress)
                            .autocapitalization(contentType == .name ? .words : .none)
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    ZStack {
        Color.red
        CSTextField(
            stateObservable: .constant(""),
            inputFieldPlaceholder: "email",
            contentType: .emailAddress
        )
    }
}
