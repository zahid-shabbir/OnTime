//
//  OnTimeDetailsHeaderView.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

struct OnTimeDetailsHeaderView: View {
    var onTimeName: String
    var onClose: () -> Void
    var body: some View {
        VStack {
            HStack {

                Text(onTimeName)
                    .fontStyle(OnTimeFont.title)
                Image(Constants.Images.voiceImg)
                Spacer()
                Image(Constants.Images.closeImg)
                    .onTapGesture {
                    onClose()
                            }
            }

        }
    }
}
