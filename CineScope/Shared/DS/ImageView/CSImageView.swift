//
//  CSImageView.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import SwiftUI
import Combine

struct CSImageView: View {
    @StateObject private var imageLoader = CSImageLoader()

    let url: URL

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.load(url: url)
        }
    }
}

class CSImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var cancellable: AnyCancellable?

    func load(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    deinit {
        cancellable?.cancel()
    }
}
