//
//  RepositoryTests.swift
//  gist-peekTests
//
//  Created by Suh on 06/08/24.
//

import XCTest
@testable import gist_peek

final class RepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let decoder = JSONDecoder()
        let bundle = Bundle(for: RepositoryTests.self)
        let url = bundle.url(forResource: "gists.json", withExtension: nil)
        print(url)
        print("=========")
        let data = try Data(contentsOf: url!)
        let json = try decoder.decode([Repository].self, from: data)
        print(json)
        print()
    }
}
