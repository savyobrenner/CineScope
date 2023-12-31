//
//  View+Extensions.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
    
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    func toast(isPresented: Binding<Bool>, type: CSToastType, message: String) -> some View {
        self.overlay(
            VStack {
                if isPresented.wrappedValue {
                    CSToast(message: message, toastType: type)
                        .transition(.slide)
                        .onAppear(perform: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isPresented.wrappedValue = false
                            }
                        })
                }
                
                Spacer()
                
            }, alignment: .top
        )
    }
}
