//
//  Network.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

class Network {
    // MARK: - Property(ies).
    private let session: URLSession
    
    // MARK: - Initialization.
    init() {
        session = URLSession.shared
    }

    // MARK: - Method(s).
    func requestData(
        using request: RequestProtocol,
        onComplete: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: request.baseURL + request.path) else { return }
        print(url.absoluteString)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        let datatask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                onComplete(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "Response fail", code: 499, userInfo: nil)
                onComplete(.failure(error))
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                let error = NSError(domain: "Unexpected fail", code: response.statusCode, userInfo: nil)
                onComplete(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "No Data", code: 499, userInfo: nil)
                onComplete(.failure(error))
                return
            }

            onComplete(.success(data))

        }
        datatask.resume()
    }

    func request<T: Decodable>(
        request: RequestProtocol,
        returning type: T.Type,
        onComplete: @escaping (Result<T?, Error>) -> Void
    ) {
        requestData(using: request) { result in
            switch result {
            case .failure(let error):
                onComplete(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let object = try decoder.decode(type, from: data)
                    onComplete(.success(object))
                } catch {
                    onComplete(.failure(error))
                }
            }
        }
    }
}
