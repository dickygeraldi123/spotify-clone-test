//
//  NetworkManager.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import Foundation
import Combine

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
}

class NetworkManager {
    // MARK: - NetworkModel
    struct NetworkModel {
        let url: URL?
        let method: HTTPMethod
        let body: JSON? = nil
    }

    func callAPI(with model: NetworkModel) -> AnyPublisher<JSON, Error> {
        guard let url = model.url else {
            return Fail(error: NSError(domain: "URL Invalid", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        let requestHeaders: HTTPHeaders = ["Content-Type": "application/json"]
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = model.method.rawValue
        urlRequest.allHTTPHeaderFields = requestHeaders

        if let body = model.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                // Parse the data into a JSON dictionary
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data),
                      let json = jsonObject as? JSON else {
                    throw NSError(domain: "Invalid JSON", code: -2, userInfo: nil)
                }
                return json
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

