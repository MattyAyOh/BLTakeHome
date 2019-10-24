//
//  APIManager.swift
//  BLTakeHome
//
//  Created by Matt Ao on 10/16/19.
//  Copyright © 2019 Betty Labs. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPParameters = [String: Any]

struct APIDefaults {
    static let defaultHeaders: HTTPHeaders =  [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    static let serviceURL = URL(string: "http://localhost:3000")
    private init() {}
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case responseError(code: Int, message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .responseError(let code, let message): return "Response Error \(code): \(message)"
        }
    }
}

enum APIResource {
    case exampleSendPushNotification(channelId: String?, userId: String?, title: String, body: String)
    case sendPushToChannel(channelId: String, title: String, body: String)

    var request: (method: HTTPMethod, path: String, headers: HTTPHeaders, parameters: HTTPParameters) {
        switch self {
            
        case .exampleSendPushNotification(let channelId, let userId, let title, let body):
            let parameters: HTTPParameters = ["title": title, "body": body]
            return (.post, String("api/notImplemented/"), [:], parameters)
            
        case .sendPushToChannel(let channelId, let title, let body):
            let parameters: HTTPParameters = ["title": title, "body": body]
            return (.post, String("api/push/\(channelId)"), [:], parameters)
            
        }
    }
}

extension APIResource: CustomStringConvertible {
    var description: String {
        let (method, path, _, params) = request
        return "Method = \(method), Path = \(path), Params = \(params)"
    }
}

class APIClient {
    static let shared = APIClient()
    private let baseURL: URL?
    private let session = URLSession(configuration: .default)

    init(baseURL: URL? = APIDefaults.serviceURL) {
        self.baseURL = baseURL
    }


    func data(_ resource: APIResource) {
        do {
            let request = try buildRequest(resource)
            let task = session.dataTask(with: request) { data, response, error in
                if let err = error {
                    print("Request Failed: \(resource), Error: \(err)")
                }
                if let res = response {
                    print("Request Success: \(resource), Response: \(res)")
                }
            }
            task.resume()
        } catch {
            print("Request Failed: \(resource), Error: \(error)")
        }
    }

    private func buildRequest(_ resource: APIResource) throws -> URLRequest {
        let (method, path, headers, parameters) = resource.request

        guard let url = baseURL?.appendingPathComponent(path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = APIDefaults.defaultHeaders.merging(headers) { (key, _) -> String in key }

        if method == .get, parameters.count > 0, let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var components = components

            components.queryItems = parameters.map { (arg) -> URLQueryItem in
                let (key, value) = arg

                var strValue: String?

                if let value = value as? String {
                    strValue = value
                }

                if let number = value as? NSNumber {
                    strValue = number.stringValue
                }

                return URLQueryItem(name: key, value: strValue)
            }

            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

            request.url = components.url
        } else if method == .post || method == .put || method == .patch, JSONSerialization.isValidJSONObject(parameters) {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }

        return request
    }

}
