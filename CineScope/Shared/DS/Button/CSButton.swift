//
//  CSButton.swift
//  Lisa
//
//  Created by Savyo Brenner on 22/10/23.
//

import SwiftUI

struct CSButton: View {
    
    @State var isEnabled = true
    var isLoading = false
    let title: String
    let style: CSButtonStyle
    var font: Font = .brand(.medium, size: 18)
    var padding: CGFloat = 10
    var radius: CGFloat = 16
    let action: (() -> Void)?
    
    var body: some View {
        switch style {
        case .primary:
            CSBaseButton(action: action,
                           title: title,
                           font: font,
                           textColor: .Brand.white,
                           primaryColor: .Brand.primary,
                           padding: padding,
                           radius: radius,
                           isLoading: isLoading)
            .disabled(!isEnabled)
            .opacity(isEnabled ? 1 : 0.5)
        }
    }
    
    func enable() {
        self.isEnabled = true
    }
    
    func disable() {
        self.isEnabled = false
    }
}
