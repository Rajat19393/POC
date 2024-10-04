//
//  NetworkManager.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import Foundation

enum NetworkError: Error {
    case timedOut
    case connectionFailure
    case noData
    case invalidURL
}

class NetworkManager {
    /// A shared instance of the 'Network Manager that is initialized with a shared URLSession* .
    static let shared = NetworkManager ()
    private let session: URLSession
    init(session: URLSession = . shared) {
        self.session = session
    }
}
