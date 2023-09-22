//
//  OnTimeFontTemplate.swift
//  OnTime.iOS
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import SwiftUI

public class FontStyle {
    private var id: UUID
    public var font: Font
    public var weight: Font.Weight
    public var foregroundColor: Color
    public var italic: Bool
    public var lineSpacing: CGFloat

    public init(font: Font,
                weight: Font.Weight,
                foregroundColor: Color,
                italic: Bool = false,
                lineSpacing: CGFloat = 10.0) {

        self.id = UUID()
        self.font = font
        self.weight = weight
        self.foregroundColor = foregroundColor
        self.italic = italic
        self.lineSpacing = lineSpacing
    }
}
