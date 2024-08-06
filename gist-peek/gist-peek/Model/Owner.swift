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
        login: String = "MariMaria",
        avatarUrl: String? = "https://trello.com/b/KTaSOgYI/githubapi"
    ) -> Owner {
        Owner(login: login, avatarUrl: avatarUrl)
    }
}
#endif
