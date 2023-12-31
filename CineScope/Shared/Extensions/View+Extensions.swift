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
    
    func toast(message: Binding<CSToastMessage?>, type: CSToastType, duration: TimeInterval = 3) -> some View {
        self.overlay(
            Group {
                if let toastMessage = message.wrappedValue {
                    CSToast(message: toastMessage.message, toastType: type)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.5), value: message.wrappedValue)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    message.wrappedValue = nil
                                }
                            }
                        }
                }
            },
            alignment: .top
        )
    }
}
