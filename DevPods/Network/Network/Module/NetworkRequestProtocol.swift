//
//  NetworkRequestProtocol.swift
//  Husqvarna
//
//  Created by Anshu Kumar Ray on 04/03/23.
//

import Combine
import Foundation

public protocol NetworkRequestProtocol {
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, Error>
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

