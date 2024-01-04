//
//  ContentDetailsView.swift
//  CineScope
//
//  Created by Savyo Brenner on 02/01/24.
//

import SwiftUI

struct ContentDetailsView: View {
    var body: some View {
        ZStack(alignment: .top) {
            backgroundImage
                .ignoresSafeArea()
            
            Image("preview_content_details_backdrop")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.clear, .Brand.firstGradient]), startPoint: .top, endPoint: .bottom)
                )
                .padding(.top, 0)
            
            VStack(alignment: .leading, spacing: 15) {
                headerView
                
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color.Brand.white.opacity(0.1))
                    .padding(.horizontal, 22)
                    .frame(height: 2)
                    .cornerRadius(10, corners: .allCorners)
                
                CSExpandableText(
                    text: "Thousands of years ago, Darkseid and his legions of Parademons attempt to conquer Earth using the combined energia eada aod lorem ipsum",
                    lineLimit: 3
                )
                .padding(.horizontal, 22)
            }
            
        }
        .edgesIgnoringSafeArea(.all)
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
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 20) {
                Image("preview_home_main_image")
                    .resizable()
                    .cornerRadius(10, corners: .allCorners)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110)
                    .padding(.top, 100)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .Brand.firstGradient]),
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                        .cornerRadius(10, corners: .allCorners)
                        .frame(width: 110)
                        .padding(.top, 100)
                    )
                
                VStack(alignment: .leading, spacing: 10) {
                    CSText(
                        text: "Zack Snyder’s Justice League",
                        size: 24,
                        type: .semibold,
                        color: .Brand.white
                    )
                    .multilineTextAlignment(.leading)
                    
                    CSText(
                        text: "2023  | 4h 02m",
                        size: 12,
                        type: .regular,
                        color: .Brand.white
                    )
                    .multilineTextAlignment(.leading)
                    
                    CSStarRatingView(rating: 2)
                    
                    CSText(
                        text: "Drama - Adventure - Romance",
                        size: 12,
                        type: .regular,
                        color: .Brand.white
                    )
                    .multilineTextAlignment(.leading)
                }
                .padding(.top, 90)
                
                Spacer()
            }
            .padding(.leading, 26)
        }
    }
}

#Preview {
    ContentDetailsView()
}

