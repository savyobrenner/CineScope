//
//  LisaButton.swift
//  Lisa
//
//  Created by Savyo Brenner on 22/10/23.
//

import SwiftUI

struct LisaButton: View {
    
    @State var isEnabled = true
    var isLoading = false
    let title: String
    let style: LisaButtonStyle
    let action: (() -> Void)?
    let font = Font.brand(.bold, size: 14)
    let padding: CGFloat = 10
    let radius: CGFloat = 16
    
    var body: some View {
        switch style {
        case .primary:
            LisaBaseButton(action: action,
                           title: title,
                           font: font,
                           textColor: .Brand.background,
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
