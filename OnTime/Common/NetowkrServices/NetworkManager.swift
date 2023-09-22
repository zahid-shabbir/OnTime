//
//  NetworkManager.swift
//  MovieMuse
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Combine

// Define a protocol for network services
protocol NetworkServiceProtocol {
    func performRequest<T: Decodable>(for service: WebServiceProtocol, params: [String: Any]?) -> AnyPublisher<T, NetworkError>
}
protocol WebServiceProtocol {
    var baseUrl: String { get }
    var token: String { get }
    var endPoint: String { get }
    var headers: [String: String] { get }
    var timeoutInterval: TimeInterval { get }
    var httpMethod: HTTPMethod { get }

    // func getRequest(params: ParamsType) -> URLRequest?
}

extension WebServiceProtocol {
    var baseUrl: String {
        "https://api.forunpoint.com:3000"
    }

    var token: String { "" }

    var headers: [String: String] { [:] }

    var timeoutInterval: TimeInterval { TimeInterval(30) }

    func prepareRequest(params: ParamsType) -> URLRequest? {
        // Create the URL using baseUrl and endPoint
        guard let url = URL(string: baseUrl + endPoint) else {
            return nil
        }
        // print("📡 request Url \(url.absoluteString) 📡")
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        // Set the headers
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Set the timeout interval
        request.timeoutInterval = timeoutInterval

        // Set the params in the request body, if provided
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("Failed to serialize params: \(error)")
            }
        }

        return request
    }
}
