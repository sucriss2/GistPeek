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

    // MARK: - Initialization.
    init() {
        repositories = [
            Repository.fixture(),
            Repository.fixture(),
            Repository(files: ["1" : RepositoryFile.init(filename: "")], owner: Owner(login: "joao234sdf", avatarUrl: ""))
        ]
    }
    
    // MARK: - Method(s).
    func load() {}

}
