//
//  NetworkRequestable.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//

import Combine
import Foundation

public class NetworkRequestable: NetworkRequestProtocol {
    let session: URLSession
    
    public init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    public var requestTimeOut: Float = 30
    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, Error>
    where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, Error>(error: NetworkError.badURL("someError"))
            )
        }
        
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return self.session
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}

