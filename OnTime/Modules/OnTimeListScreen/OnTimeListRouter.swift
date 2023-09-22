//
//  OnTimeListRouter.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import UIKit

class OnTimeListRouter: OnTimeListRouterProtocol {
    typealias Content = OnTimeDetailsView


       func makeDetailsView(for onTime: OnTime) -> OnTimeDetailsView {
           OnTimeDetailsView(onTime: onTime)
       }

}
