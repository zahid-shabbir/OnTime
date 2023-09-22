//
//  OnTimeHeader.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimeHeader: View {
    var title: String
    var time: String
    var icon: String
    private let itemWidth: CGFloat = 20

    var body: some View {
        HStack {
            Text(title)
                .fontStyle(OnTimeFont.title)
            Spacer()
            Text(time)
                Spacer().frame(width: 20)
                .fontStyle(OnTimeFont.body)

            Image(icon)
        }
    }
}
