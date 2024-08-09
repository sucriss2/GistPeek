//
//  ListServiceMock.swift
//  gist-peekTests
//
//  Created by Suh on 09/08/24.
//

import Foundation
@testable import gist_peek

class ListServiceMockkk: ListService, ListViewModelDelegate {
    enum Message: Equatable {
        case didLoadSucess
        case didError
    }

    private(set) var messages: [Message] = []

    func didLoadSucess() {
        messages.append(.didLoadSucess)
    }

    func didError(message: String) {
        messages.append(.didError)
    }
}
