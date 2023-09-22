//
//  OnTimeDetailRouter.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation


class OnTimeDetailRouter: OnTimeDetailsRouterProtocol {
    typealias Content = OnTimeDescrptionView
    
    
    func makeDescriptionView() -> Content {
        Content()
    }
    
}
