//
//  OnTimeApp.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import SwiftUI

@main
struct OnTimeApp: App {
    // Create the services and presenter only once here
    private let apiService = APIOnTimeService(networkService: URLSessionService())
    private let interactor: OnTimeListInteractor
    private let presenter: OnTimeListPresenter

    init() {
        // Initialising the interactor and presenter
        interactor = OnTimeListInteractor(apiService: apiService)
        presenter = OnTimeListPresenter(interactor: interactor, router: OnTimeListRouter())
    }

    var body: some Scene {
        WindowGroup {

            OnTimeListView(onTimeListPresenter: presenter,
                                                selectedOnTime: dummyOnTime
                                                )

        }
    }
}
