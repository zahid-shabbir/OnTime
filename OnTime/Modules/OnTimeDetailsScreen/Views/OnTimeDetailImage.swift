//
//  OnTimeDetailImageView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimeDetailImageView: View {
    var width: CGFloat
    var height: CGFloat
    var image: String
    let cornerRadius: CGFloat = 10.0  // Choose the value that fits your design

    var body: some View {
        ZStack {
            AsyncImage(urlString: image)
                .frame(width: width, height: height)
                .frame(maxWidth: width, maxHeight: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}
