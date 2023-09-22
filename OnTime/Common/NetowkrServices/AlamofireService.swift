//
//  AlamofireService.swift
//  OnTime
//
//  Created by Zahid Shabbir on 22/09/2023.
//

import Foundation
import Combine
import Alamofire

class AlamofireService: NetworkServiceProtocol {
    typealias T = Decodable

    func performRequest<T: Decodable>(for service: WebServiceProtocol, params: [String: Any]? = nil) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = service.prepareRequest(params: params) else {
            return Fail(error: .badRequest)
                .eraseToAnyPublisher()
        }

        return Future { promise in
            AF.request(urlRequest)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            promise(.success(decodedData))
                        } catch let error as DecodingError {
                            promise(.failure(error.handle()))
                        } catch {
                            promise(.failure(NetworkError.unknownError(error)))
                        }
                    case .failure:
                        promise(.failure(NetworkError.serverUnavailable))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

}
