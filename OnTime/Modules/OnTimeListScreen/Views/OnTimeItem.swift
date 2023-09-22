//
//  OnTimeItem.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimeItem: View {
    let geometry: GeometryProxy

    // Constants
    private let itemWidthHeight: CGFloat = 120
    private let largeOffsetThreshold: CGFloat = 50
    private let colorLargeOffset = Color.red
    private let colorSmallOffset = Color.blue

    var body: some View {
        GeometryReader { itemGeometry in
            Image("pic2")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .background(colorForItem(itemGeometry))
                .cornerRadius(10)
        }
        .frame(width: itemWidthHeight, height: itemWidthHeight)
        .background(.blue)
    }

    private var screenMidX: CGFloat {
        geometry.frame(in: .global).midX
    }

    private func colorForItem(_ itemGeometry: GeometryProxy) -> Color {
        absOffsetX(itemGeometry) < largeOffsetThreshold ? colorLargeOffset : colorSmallOffset
    }

    private func absOffsetX(_ itemGeometry: GeometryProxy) -> CGFloat {
        abs(itemGeometry.frame(in: .global).midX - screenMidX)
    }
}
