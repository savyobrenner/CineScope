//
//  ContentDetailsView.swift
//  CineScope
//
//  Created by Savyo Brenner on 02/01/24.
//

import SwiftUI

struct ContentDetailsView: View {
    var body: some View {
        ZStack {
            backgroundImage
            
            
            loadingView
        }
    }
    
    private var backgroundImage: some View {
        Image("home_background_gradient")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var loadingView: some View {
        Group {
            //            if viewModel.isLoading {
//            CSLoadingView()
            //            }
        }
    }
}

#Preview {
    ContentDetailsView()
}

