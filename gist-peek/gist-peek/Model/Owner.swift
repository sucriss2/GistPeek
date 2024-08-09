//
//  Owner.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

struct Owner: Codable {
    var login: String
    var avatarUrl: String?
}

#if DEBUG
extension Owner {
    static func fixture(
        login: String = "MariMaria123",
        avatarUrl: String? = "https://lthub.ubc.ca/files/2021/06/GitHub-Logo.png"
    ) -> Owner {
        Owner(login: login, avatarUrl: avatarUrl)
    }
}
#endif
