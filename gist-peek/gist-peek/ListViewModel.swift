//
//  ListViewModel.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didLoadSucess()
    func didError(message: String)
}

class ListViewModel {
    // MARK: - Property(ies).
    private(set) var repositories: [Repository]
    weak var delegate: ListViewModelDelegate?
    var service: ListService?
    private var page: Int = -1
    var isLoading: Bool = true

    // MARK: - Initialization.
    init() {
        repositories = []
    }

    // MARK: - Method(s).
    func load() {
        isLoading = true
        page += 1
        service?.fetchRepositories(page: page, onComplete: { [weak self] repositories in
            guard let self = self else { return }
            self.repositories.append(contentsOf: repositories)
            self.delegate?.didLoadSucess()
            self.isLoading = false
            debugPrint(repositories.count)
        }, onError: { error in
            self.delegate?.didError(message: error.localizedDescription)
            self.isLoading = false
        })
    }
}
