//
//  Repository.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

struct Repository: Codable {
    var files: [String: RepositoryFile]
    var owner: Owner
}

extension Repository {
    var ownerLogin: String {
        owner.login
    }
    var ownerAvatarUrl: String {
        owner.avatarUrl ?? ""
    }
    var filesCount: Int {
        files.count
    }
}

#if DEBUG
extension Repository {
    static func fixture(
        files: [String: RepositoryFile] = [
            "1": RepositoryFile.fixture(),
            "2": RepositoryFile.fixture(),
            "3": RepositoryFile.fixture(),
            "4": RepositoryFile.fixture()],
        owner: Owner = Owner.fixture()) -> Repository {
            Repository(files: files, owner: owner)
    }
}
#endif
