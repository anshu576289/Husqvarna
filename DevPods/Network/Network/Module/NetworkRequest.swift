//
//  NetworkRequest.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//
import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
}

public struct NetworkRequest {
    let key: String?
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod
    
    public init(key: String?,
                url: String,
                headers: [String: String]? = nil,
                reqBody: Encodable? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.key = key
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    public init(key: String?,
                url: String,
                headers: [String: String]? = nil,
                reqBody: Data? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.key = key
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}

