//
//  ViewModifiers.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI
import Foundation
extension View {
    func backgroundPattern() -> some View {
        self
            .background(
                Image("bg_pattern")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            )
            .padding()
    }
}
