//
//  HomeView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            backgroundImage
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    mainImageSection
                    sectionsListView
                }
                .padding(.bottom, 80)
            }
            
            loadingView
        }
        .runOnceOnAppear {
            viewModel.fetchData()
        }
        .toast(message: $viewModel.toastMessage, type: viewModel.toastMessage?.type ?? .info)
    }
    
    private var backgroundImage: some View {
        Image("home_background_gradient")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var contentStack: some View {
        VStack(spacing: 0) {
            mainImageSection
            sectionsListView
            Spacer()
        }
    }
    
    private var mainImageSection: some View {
        Group {
            if let posterPath = viewModel.selectedContent?.posterPathURL {
                ZStack(alignment: .top) {
                    mainImage(url: posterPath)
                        .id(posterPath)
                    VStack {
                        header
                        Spacer()
                    }
                    .padding(.top, 80)
                    contentInfoOverlay
                }
                .animation(.easeInOut(duration: 0.5), value: viewModel.selectedContent)
            }
        }
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
                            itemCard(for: item, isHorizontal: section.isHorizontal, isMovie: section.isMovie)
                        }
                    }
                }
                .frame(height: section.isHorizontal ? 170 : 240)
            }
        }
    }
    
    private func itemCard(for item: MediaModel, isHorizontal: Bool, isMovie: Bool) -> some View {
        Button(action: {
            if isHorizontal {
                viewModel.selectContentPreview(for: item)
                return
            }
            
            viewModel.goToContentDetails(id: "\(item.id ?? 0)", isMovie: isMovie)
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
    
    private var overlayContent: some View {
        ZStack {
            contentInfoOverlay
            
            VStack {
                header
                    .padding(.top, 80)
                Spacer()
            }
        }
    }
    
    private var loadingView: some View {
        Group {
            if viewModel.isLoading {
                CSLoadingView()
            }
        }
    }
    
    private func mainImage(url: URL) -> some View {
        CSImageView(url: url)
            .scaledToFill()
            .frame(height: 390)
            .overlay(mainImageGradient)
            .clipped()
            .ignoresSafeArea()
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: url)
    }
    
    private var mainImageGradient: some View {
        LinearGradient(gradient: Gradient(
            colors: [
                Color.Brand.firstGradient.opacity(1),
                Color.Brand.secondGradient.opacity(0.5),
                Color.Brand.thirdGradient.opacity(1)
            ]),
                       startPoint: .bottomLeading, endPoint: .bottomTrailing
        )
        .frame(height: 390)
    }
    
    private var contentInfoOverlay: some View {
        VStack(alignment: .center, spacing: 40) {
            contentTitle
            contentOptions
        }
        .padding(.top, 235)
    }
    
    private var contentTitle: some View {
        CSText(
            text: viewModel.selectedContent?.title ?? "",
            size: 18,
            type: .semibold,
            color: .Brand.white
        )
        .multilineTextAlignment(.center)
    }
    
    private var header: some View {
        HStack {
            homeTitle
            Spacer()
            headerControls
        }
        .padding(.horizontal, 30)
    }
    
    private var homeTitle: some View {
        CSText(
            text: "Home".localized,
            size: 19,
            type: .semibold,
            color: .Brand.white
        )
    }
    
    private var headerControls: some View {
        HStack(spacing: 30) {
            searchButton
            userProfile
        }
    }
    
    private var searchButton: some View {
        Button(action: {}) {
            Image("search_icon")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    private var userProfile: some View {
        Group {
            if let photo = viewModel.user?.photoURL {
                CSImageView(url: photo)
                    .foregroundColor(.Brand.secondary)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
            } else {
                Image(systemName: "person")
                    .foregroundColor(.Brand.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .background(Color.Brand.placeholder)
                    .cornerRadius(20)
            }
        }
        .onTapGesture {
            viewModel.profilePictureWasPressed()
        }
    }
    
    private var contentOptions: some View {
        HStack(alignment: .center) {
            Spacer()
            buttonView(imageName: "info_icon", text: "Info".localized)
            Spacer(minLength: 20)
            buttonView(imageName: "play_icon", text: "Play".localized, frameSize: 40)
            Spacer(minLength: 20)
            buttonView(imageName: "plus_icon", text: "Add".localized)
            Spacer()
        }
    }
    
    private func buttonView(imageName: String, text: String, frameSize: CGFloat = 25) -> some View {
        Button(action: {
            viewModel.goToContentDetails(id: "\(viewModel.selectedContent?.id ?? 0)", isMovie: true)
        }) {
            VStack(alignment: .center, spacing: 10) {
                Image(imageName)
                    .resizable()
                    .frame(width: frameSize, height: frameSize)
                
                CSText(
                    text: text,
                    size: 10,
                    type: .medium,
                    color: .Brand.white
                )
                .multilineTextAlignment(.center)
            }
        }
    }
}

import Factory
#Preview {
    HomeView(
        viewModel: HomeViewModel(
            homeServices: Container.shared.homeServices.resolve(),
            router: Router(),
            serviceLocator: Container.shared.serviceLocator.resolve()
        )
    )
}
