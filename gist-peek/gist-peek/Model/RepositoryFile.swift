//
//  RepositoryFile.swift
//  gist-peek
//
//  Created by Suh on 06/08/24.
//

import Foundation

struct RepositoryFile: Codable {
    let filename: String
}

#if DEBUG
extension RepositoryFile {
    static func fixture(
        filename: String = ""
    ) -> RepositoryFile {
        RepositoryFile(filename: filename)
    }
}
#endif
