//
//  NetworkError.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case authenticationError
    case notFound
    case parseError
}

// MARK: - Method(s).
func handleNetworkError(_ error: Error) {
    switch error {
    case NetworkError.invalidURL:
        print("Invalid URL error")
    case NetworkError.requestFailed:
        print("Request failed error")
    case NetworkError.authenticationError:
        print("Authentication error")
    case NetworkError.notFound:
        print("Not found error")
    case NetworkError.parseError:
        print("Decoder parse error")
    default:
        print("Other network error")
    }
}
