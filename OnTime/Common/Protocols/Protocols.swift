//
//  Protocols.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation

import Combine
import SwiftUI

protocol OnTimeListViewProtocol: AnyObject {
    func updateOnTimes(_ onTime: [OnTime])
}

protocol OnTimeListRouterProtocol {
    associatedtype Content: View
    func makeDetailsView(for onTime: OnTime) -> Content
}

//riz

protocol OnTimeDetailsRouterProtocol {
    associatedtype Content: View
    func makeDescriptionView() -> Content
}


protocol OnTimeListInteractorProtocol {
    func fetchOnTimes() -> AnyPublisher<[OnTime], Error>
}

protocol OnTimeListPresenterProtocol: ObservableObject {
    var onTime: [OnTime] { get }
    func loadOnTimes()
}

protocol OnTimeDetailPresenterProtocol: ObservableObject {
    var onTime: OnTime { get }
}

protocol ProgressViewPropertiesProtocol {
    var progressTime: String { get }
    var viewWidth: CGFloat { get }
    var viewHeight: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var trailingPadding: CGFloat { get }
    var fontSize: CGFloat { get }
    var labelHeight: CGFloat { get }
}

protocol TimerViewPropertiesProtocol {
    var startTime: String { get }
    var currentTime: String { get }
    var startLabel: String { get }
    var currentLabel: String { get }
    var viewWidth: CGFloat { get }
}

struct TimerViewProperties: TimerViewPropertiesProtocol {
    let startTime: String
    let currentTime: String
    let startLabel: String
    let currentLabel: String
    let viewWidth: CGFloat
}
