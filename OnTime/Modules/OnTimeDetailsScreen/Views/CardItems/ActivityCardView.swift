//
//  ActivityCardView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct ActivityCardView: View {
    // UI Constants
    var onTime: OnTime
    let cornerRadius: CGFloat = 15
    let shadowRadius: CGFloat = 30
    let shadowOffset: CGFloat = 8
    let containerHeight: CGFloat = 280
    let padding: CGFloat = 15
    var onClose: () -> Void

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.Card)
                    .shadow(color: Color.CardShadow, radius: shadowRadius, x: 0, y: shadowOffset)

                VStack(spacing: padding) {
                    TimerView(properties: TimerViewProperties(startTime: onTime.currentSchedule, currentTime: onTime.currentTime, startLabel: Constants.startLabel, currentLabel: Constants.nowLbl, viewWidth: .infinity))

                    ProgressView(properties: ProgressViewProperties(progressTime: Constants.progressTime, viewWidth: 312.8, viewHeight: 53.0))
                    CardActionButton(actionBtnMessage: Constants.actionBtnMessage, actionImage: Constants.Images.actionImg, viewWidth: .infinity, onClose: onClose)
                }
                .padding(padding)
            }
        }
        .frame(height: containerHeight)
        .padding(padding)

    }
}
