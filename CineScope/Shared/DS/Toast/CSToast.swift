//
//  CSToast.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct CSToast: View {
    let message: String
    let toastType: CSToastType
    
    var body: some View {
        Text(message)
            .font(.brand(.medium, size: 12))
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                toastType.backgroundColor
            )
            .foregroundColor(toastType.textColor)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

#Preview {
    CSToast(message: "Hello World", toastType: .success)
}
