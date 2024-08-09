//
//  DetailModel.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import Foundation

class DetailModel {
    // MARK: - Property(ies).
    private var user: Repository

    var image: String {
        return user.ownerAvatarUrl
    }

    var name: String {
        return user.ownerLogin
    }

    // MARK: - Initialization.
    init(user: Repository) {
        self.user = user
    }
}
