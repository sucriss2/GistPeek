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
    static func fixture(files: [String: RepositoryFile] , owner: Owner = Owner.fixture()) -> Repository {
        Repository(files: [:], owner: owner)
    }
}
#endif
