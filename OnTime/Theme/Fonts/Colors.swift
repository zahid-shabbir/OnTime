//
//  Colors.swift
//  VisualOnTimes
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let Primary = Color(Color.Key.primary.rawValue)
    static let Light = Color(Color.Key.light.rawValue)
    static let Card = Color(Color.Key.card.rawValue)
    static let CardShadow = Color(Color.Key.cardShadow.rawValue)
    static let Purple = Color(Color.Key.purple.rawValue)
    static let Stroke = Color(Color.Key.stroke.rawValue)
    static let Stroke2 = Color(Color.Key.stroke2.rawValue)
    static let Body2 = Color(Color.Key.body2.rawValue)
    static let LightPink = Color(Color.Key.lightPink.rawValue)
    static let Pink = Color(Color.Key.pink.rawValue)
    static let Yellow = Color(Color.Key.yellow.rawValue)

    enum Key: String {
        case primary = "Primary"
        case light = "Light"
        case card = "Card"
        case cardShadow = "CardShadow"
        case purple = "Purple"
        case stroke = "Stroke"
        case stroke2 = "Stroke2"
        case body2 = "Body2"
        case lightPink = "LightPink"
        case pink = "Pink"
        case yellow = "Yellow"

    }
}
