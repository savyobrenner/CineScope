//
//  HomeView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
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
        .onAppear(perform: viewModel.fetchData)
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
            if let posterPath = viewModel.popularMovies.first?.posterPathURL {
                ZStack(alignment: .top) {
                    mainImage(url: posterPath)
                    VStack {
                        header
                        Spacer()
                    }
                    .padding(.top, 80)
                    contentInfoOverlay
                }
            }
        }
    }
    
    private var sectionsListView: some View {
        ForEach(viewModel.sections, id: \.title) { section in
            VStack(alignment: .leading, spacing: 0) {
                Text(section.title)
                    .foregroundColor(.Brand.white)
                    .font(.brand(.bold, size: 16))
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
        VStack(alignment: .center, spacing: 10) {
            if let pathURL = isHorizontal ? item.backdropPathURL : item.posterPathURL {
                CSImageView(url: pathURL)
                    .scaledToFill()
                    .frame(width: isHorizontal ? 180 : 125, height: isHorizontal ? 110 : 185)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Text((item.title ?? item.name) ?? "")
                .font(.brand(.semibold, size: 14))
                .foregroundColor(.Brand.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
                .frame(height: 40)
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
            text: viewModel.popularMovies.first?.title ?? "",
            size: 18,
            type: .semibold,
            color: .Brand.white
        )
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
    }
    
    private var contentOptions: some View {
        HStack(alignment: .center) {
            Spacer()
            buttonView(imageName: "info_icon", text: "Info")
            Spacer()
            buttonView(imageName: "play_icon", text: "Play", frameSize: 38)
            Spacer()
            buttonView(imageName: "plus_icon", text: "Add")
            Spacer()
        }
    }
    
    private func buttonView(imageName: String, text: String, frameSize: CGFloat = 25) -> some View {
        Button(action: {}) {
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
