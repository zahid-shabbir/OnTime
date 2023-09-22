//
//  TimerView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI
struct TimerView: View {
    var properties: TimerViewPropertiesProtocol

    var body: some View {
        HStack {
            TimerCard(time: properties.startTime, label: properties.startLabel)
            Spacer()
            TimerCard(time: properties.currentTime, label: properties.currentLabel)
        }
    }

    struct TimerCard: View {
        // UI constants
        let labelHeight: CGFloat = 30
        let cardHeight: CGFloat = 38.9
        let cardWidth: CGFloat = 156.3
        let cornerRadius: CGFloat = 15
        var time: String
        var label: String
        var body: some View {
            VStack {
                Text(label)
                    .fontStyle(RortyFont.body2)
                    .frame(height: labelHeight)
                RoundedRectangleView(text: time)
                    .frame(width: cardWidth, height: cardHeight)
            }
        }
        private func RoundedRectangleView(text: String) -> some View {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.pink.opacity(0.2))
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(Color.pink, lineWidth: 2)
                Text(time)
                    .fontStyle(RortyFont.bodyPinkBold)
                    .font(.body)

            }
        }
    }
}
