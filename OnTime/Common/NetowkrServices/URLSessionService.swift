//
//  URLSessionService.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Combine

class URLSessionService: NetworkServiceProtocol {

    func performRequest<T: Decodable>(for service: WebServiceProtocol, params: [String: Any]? = nil) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = service.prepareRequest(params: params) else {
            return Fail(error: .badRequest)
                .eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.serverUnavailable
                }
                // data.printPretty()
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return decodingError.handle()
                } else if error is URLError {
                    return NetworkError.noData
                } else {
                    return NetworkError.unknownError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
