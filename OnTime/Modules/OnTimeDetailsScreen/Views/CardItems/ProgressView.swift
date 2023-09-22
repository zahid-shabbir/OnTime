//
//  ProgressView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct ProgressView: View {
    var properties: ProgressViewPropertiesProtocol

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: properties.cornerRadius)
                    .fill(Color.yellow)
                    .frame(width: (properties.viewWidth-properties.trailingPadding), height: properties.viewHeight)
                    .padding(.trailing, properties.trailingPadding)

                Image("visual_timer_bg")
                    .resizable()
                    .frame(width: properties.viewWidth, height: properties.viewHeight)

                TimeLabelView(text: properties.progressTime, fontSize: properties.fontSize)
                    .frame(height: properties.labelHeight)
            }
        }
    }
}

struct TimeLabelView: View {
    var text: String
    var fontSize: CGFloat

    var body: some View {
        ZStack {
            ForEach(-2...2, id: \.self) { i in
                ForEach(-2...2, id: \.self) { j in
                    Text(text)
                        .foregroundColor(Color.black) // black is overlapping on white
                        .font(.system(size: fontSize, weight: .bold, design: .rounded))
                        .offset(x: CGFloat(i), y: CGFloat(j))
                }
            }
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: fontSize, weight: .bold, design: .rounded))
        }
    }
}

struct ProgressViewProperties: ProgressViewPropertiesProtocol {
    let progressTime: String
    let viewWidth: CGFloat
    let viewHeight: CGFloat

    let cornerRadius: CGFloat = 51.5
    let trailingPadding: CGFloat = 20
    let fontSize: CGFloat = 37
    let labelHeight: CGFloat = 30
}
