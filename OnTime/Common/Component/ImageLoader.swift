//
//  ImageLoader.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI
import Combine

struct AsyncImage: View {
    private let placeholder: Image
    @StateObject private var loader: ImageLoader

    init(url: URL, placeholder: Image = Image("comingsoon")) {
        self.placeholder = placeholder
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    init(urlString: String, placeholder: Image = Image("comingsoon")) {
        self.placeholder = placeholder
        let url = URL(string: urlString)!
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image).resizable()
        } else {
            placeholder.resizable()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    init(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
