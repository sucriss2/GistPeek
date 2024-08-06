//
//  ListService.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

final class ListService {
    // MARK: - Property(ies).
    private let network: Network
    
    // MARK: - Initialization.
    init(network: Network = Network()) {
        self.network = network
    }
    
    // MARK: - Method(s).
    func fetchRepositories(
        onComplete: @escaping ([Repository]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let request = Request(baseURL: Server.baseUrl, path: "?page=0", method: .get)
        network.request(request: request, returning: [Repository].self) { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let repositories):
                onComplete(repositories ?? [])
            }
        }
    }
}
