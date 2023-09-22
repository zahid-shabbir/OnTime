//
//  OnTimeListInteractor.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Combine

class OnTimeListInteractor: OnTimeListInteractorProtocol {
    private let apiService: APIOnTimeService

    init(apiService: APIOnTimeService) {
        self.apiService = apiService
    }

    func fetchOnTimes() -> AnyPublisher<[OnTime], Error> {
        apiService.fetchOnTimes()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

}
