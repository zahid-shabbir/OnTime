//
//  OnTimeFont.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import SwiftUI

struct OnTimeFont {

    static let title = FontStyle(font: Font.custom(FontType.bold.rawValue, size: 30.0),
                                    weight: .bold,
                                    foregroundColor: Color.Primary)

    static let largeTitle = FontStyle(font: Font.custom(FontType.semi_bold.rawValue, size: 39.0),
                                    weight: .semibold,
                                    foregroundColor: Color.white)

    static let title2 = FontStyle(font: Font.custom(FontType.semi_bold.rawValue, size: 28.0),
                                    weight: .semibold,
                                    foregroundColor: Color.Primary)

    static let body2 = FontStyle(font: Font.custom(FontType.medium.rawValue, size: 27),
                                   weight: .medium,
                                   foregroundColor: .Body2)

    static let bodyPinkBold = FontStyle(font: Font.custom(FontType.bold.rawValue, size: 27),
                                   weight: .bold,
                                   foregroundColor: .Pink)

    static let body = FontStyle(font: Font.custom(FontType.medium.rawValue, size: 22.0),
                                   weight: .medium,
                                   foregroundColor: .Light)

}
