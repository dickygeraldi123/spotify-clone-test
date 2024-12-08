//
//  ListUrls.swift
//  Spotify Clone
//
//  Created by Dicky Geraldi on 07/12/24.
//

import Foundation
import Foundation

enum NetworkURL {
    case getMusicSearch(query: String)
}

extension NetworkURL {
    var url: URL?{
        switch self{
        case .getMusicSearch(let query):
            let endPointPath = "\(URLEndpoints.SearchMusic)&term=\(query)"
            return URL(string: NetworkURL.baseURLSting + endPointPath)
        }
    }

    static var baseURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/"
        guard let url = components.url else { return nil }
        return url
    }

    static var baseURLSting: String {
        return  NetworkURL.baseURL?.absoluteString ?? ""
    }
}
