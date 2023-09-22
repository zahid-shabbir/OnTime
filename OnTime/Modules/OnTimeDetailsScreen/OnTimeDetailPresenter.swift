//
//  OnTimeDetailPresenter.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
class OnTimeDetailPresenter: OnTimeDetailPresenterProtocol {
    @Published var onTime: OnTime

    init(onTime: OnTime) {
        self.onTime = onTime
    }

    func okayTapped() {
        print("ok button tapped")
    }
}
