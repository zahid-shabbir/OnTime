//
//   OnTimeService.swift
//  OnTimeMuse
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Combine
import Foundation
import UIKit

import Network
private var monitor: NWPathMonitor?

protocol OnTimeService {
    func fetchOnTimes() -> AnyPublisher<[OnTime], NetworkError>
}

enum OnTimeAPI {
    case onTimeItems
}

extension OnTimeAPI: WebServiceProtocol {

    var endPoint: String {
        switch self {
        case .onTimeItems:
            return "/v1/api/rest-test"
        }
    }
    var httpMethod: HTTPMethod {
        switch self {
        case .onTimeItems: return .get
        }
    }
}

open class APIOnTimeService: OnTimeService {
    private let networkService: any NetworkServiceProtocol

    init(networkService: any NetworkServiceProtocol) {
        self.networkService = networkService
    }
    private var cancellables = Set<AnyCancellable>()

    func fetchOnTimes() -> AnyPublisher<[OnTime], NetworkError> {
        return NetworkMonitorService.shared.isConnectedToInternet
            .flatMap { isConnected -> AnyPublisher<[OnTime], NetworkError> in
                if isConnected {
                    print("Connected to the internet!")
                    let publisher: AnyPublisher<[OnTime], NetworkError> = self.networkService.performRequest(for: OnTimeAPI.onTimeItems, params: nil)
                    publisher
                        .sink(receiveCompletion: { _ in },
                              receiveValue: { onTime in
                                OnTimeCD.saveOnTime(onTime: onTime)
                        })
                        .store(in: &self.cancellables)
                    return publisher
                } else {
                    print("Not connected to the internet.")
                    return OnTimeCD.getOnTimes()
                }
            }
            .eraseToAnyPublisher()
    }

    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
}
