//
//  Utilities.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
struct Utility {
    static var currentTime: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        return timeFormatter.string(from: Date())
    }
}
