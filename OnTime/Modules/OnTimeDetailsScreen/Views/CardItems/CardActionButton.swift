//
//  CardActionButton.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct CardActionButton: View {

    // UI constants
    var actionBtnMessage: String
    var actionImage: String

    let cornerRadius: CGFloat = 24
    let shadowOffset: CGFloat = 6
    let shadowRadius: CGFloat = 0
    let fontSize: CGFloat = 39
    let viewHeight: CGFloat = 70
    let viewWidth: CGFloat
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.Purple)

                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color.Stroke, lineWidth: 2)

                HStack {
                    Image(actionImage)
                        .padding(.trailing)

                    Text(actionBtnMessage)
                        .font(.custom(FontType.semi_bold.rawValue, size: fontSize))
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black, radius: shadowRadius, x: 0, y: 0)
                }
            }
            .compositingGroup()
            .shadow(color: Color.Stroke2, radius: shadowRadius, x: 0, y: shadowOffset)
        }
        .frame(width: viewWidth, height: viewHeight)
        .onTapGesture {

        onClose()
        }

    }
}
