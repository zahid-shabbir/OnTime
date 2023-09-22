//
//  NetworkMonitorService.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Network
import Combine

class NetworkMonitorService {
    static let shared = NetworkMonitorService()

    private(set) var isConnectedToInternet: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")

        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnectedToInternet.send(true)
            } else {
                self?.isConnectedToInternet.send(false)
            }
        }
    }
}
