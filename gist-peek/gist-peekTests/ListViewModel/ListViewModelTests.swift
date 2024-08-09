//
//  ListViewModelTests.swift
//  gist-peekTests
//
//  Created by Suh on 09/08/24.
//

import XCTest
@testable import gist_peek

private class ListCVSpy: ListViewModelDelegate {
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

private class ListServiceMock: ListService {
    var loginExpectedResult: Result<[Repository], Error> = .success([])

    override func fetchRepositories(
        page: Int,
        onComplete: @escaping ([Repository]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        switch loginExpectedResult {
        case .success(let repositories):
            onComplete(repositories)
        case .failure(let failure):
            onError(NetworkError.requestFailed)
        }
    }
}

// MARK: - Setup SUT
private extension ListViewModelTests {
    typealias DependencySUT = (
        sut: ListViewModel,
        displaySpy: ListCVSpy,
        serviceMock: ListServiceMock)

    func makeSUT() -> DependencySUT {
        let displaySpy = ListCVSpy()
        let serviceMock = ListServiceMock()

        var sut = ListViewModel()
        sut.service = serviceMock
        sut.delegate = displaySpy

        return (sut, displaySpy, serviceMock)
    }
}

class ListViewModelTests: XCTestCase {
    // MARK: - Tests
    func testLoad_WhenSuccess_ShouldCalldidErrorEmptyList() {
        let args = makeSUT()

        args.serviceMock.fetchRepositories(page: 1) { _ in
            args.displaySpy.didLoadSucess()
        } onError: { _ in
            args.displaySpy.didError(message: "")
        }

        XCTAssertEqual(args.displaySpy.messages, [.didLoadSucess])
    }

    func testLoad_WhenSuccess_ShouldCallDidLoadSuccess() {
        let args = makeSUT()

        args.serviceMock.fetchRepositories(page: 1) { _ in
            args.displaySpy.didLoadSucess()
        } onError: { _ in
            args.displaySpy.didError(message: "")
        }

        XCTAssertEqual(args.displaySpy.messages, [.didLoadSucess])
    }

    func testError_WhenNoInternet_ShouldCallShowConnectionError() {
        let args = makeSUT()

        args.serviceMock.fetchRepositories(page: 1) { _ in
            args.displaySpy.didLoadSucess()
        } onError: { _ in
            args.displaySpy.didError(message: "")
        }

        XCTAssertEqual(args.displaySpy.messages, [.didError])
    }

}
