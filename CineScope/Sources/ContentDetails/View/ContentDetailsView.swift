//
//  ContentDetailsView.swift
//  CineScope
//
//  Created by Savyo Brenner on 02/01/24.
//

import SwiftUI

struct ContentDetailsView<ViewModel: ContentDetailsViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                backgroundImage
                    .ignoresSafeArea()
                
                if let backdropPathURL = viewModel.contentDetails?.backdropPathURL {
                    CSImageView(url: backdropPathURL)
                        .scaledToFit()
                        .overlay(
                            LinearGradient(gradient: Gradient(
                                colors: [.clear, .Brand.firstGradient]), startPoint: .top, endPoint: .bottom
                            )
                        )
                        .padding(.top, 0)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    headerView
                    
                    customDivider
                    
                    CSExpandableText(
                        text: viewModel.contentDetails?.overview ?? "",
                        lineLimit: 3
                    )
                    .padding(.horizontal, 22)
                    
                    CSButton(title: "Watch Trailer".localized, icon: .init("play_trailer_icon"), style: .secondary) {
                        viewModel.watchTrailer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 10)
                    
                    CSButton(title: "Add to Favorites".localized, icon: .init(systemName: "heart"), style: .secondary) {
                        viewModel.saveToFavorites()
                    }
                    .padding(.horizontal, 22)
                    
                    customDivider
                    
                    sectionsListView
                }
                
                loadingView
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: viewModel.fetchData)
            .toast(message: $viewModel.toastMessage, type: viewModel.toastMessage?.type ?? .info)
        }
        .ignoresSafeArea()
        .background(
            Color.black
        )
    }
    
    private var backgroundImage: some View {
        Image("home_background_gradient")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var loadingView: some View {
        Group {
            if viewModel.isLoading {
                CSLoadingView()
            }
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 20) {
                if let posterImageURL = viewModel.contentDetails?.posterPathURL {
                    CSImageView(url: posterImageURL)
                        .scaledToFit()
                        .cornerRadius(10, corners: .allCorners)
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
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    CSText(
                        text: (viewModel.contentDetails?.title ?? viewModel.contentDetails?.name) ?? "",
                        size: 24,
                        type: .semibold,
                        color: .Brand.white
                    )
                    .multilineTextAlignment(.leading)
                    
                    CSText(
                        text: "\(viewModel.releaseDate) | \(viewModel.runtime)",
                        size: 12,
                        type: .regular,
                        color: .Brand.white
                    )
                    .multilineTextAlignment(.leading)
                    
                    CSStarRatingView(rating: viewModel.startRating)
                    
                    CSText(
                        text: viewModel.genresString,
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
    
    private var customDivider: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(Color.Brand.white.opacity(0.1))
            .padding(.horizontal, 22)
            .frame(height: 2)
            .cornerRadius(10, corners: .allCorners)
    }
    
    private var sectionsListView: some View {
        ForEach(viewModel.sections, id: \.title) { section in
            VStack(alignment: .leading, spacing: 0) {
                CSText(
                    text: section.title,
                    size: 16,
                    type: .bold,
                    color: .Brand.white
                )
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(section.items, id: \.uuid) { item in
                            itemCard(for: item, isHorizontal: section.isHorizontal)
                        }
                    }
                }
                .frame(height: section.isHorizontal ? 170 : 240)
            }
        }
    }
    
    private func itemCard(for item: MediaModel, isHorizontal: Bool) -> some View {
        Button(action: {
            viewModel.goToContentDetails(id: "\(item.id ?? 0)")
        }) {
            VStack(alignment: .center, spacing: 10) {
                if let pathURL = isHorizontal ? item.backdropPathURL : item.posterPathURL {
                    CSImageView(url: pathURL)
                        .scaledToFill()
                        .frame(width: isHorizontal ? 180 : 125, height: isHorizontal ? 110 : 185)
                        .clipped()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                CSText(
                    text: (item.title ?? item.name) ?? "",
                    size: 14,
                    type: .semibold,
                    color: .Brand.white
                )
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .frame(height: 40)
            }
        }
        .frame(width: isHorizontal ? 180 : 125)
        .padding(.horizontal, 16)
    }
}

import Factory
#Preview {
    ContentDetailsView(
        viewModel: ContentDetailsViewModel(
            router: Router(),
            contentDetailsServices: Container.shared.contentDetailsServices.resolve(), 
            contentId: "242972",
            isMovie: true
        )
    )
}
