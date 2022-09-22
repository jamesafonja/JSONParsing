//
//  APIHandlerTests.swift
//  JSONParsingTests
//
//  Created by Revive on 9/20/22.
//

import XCTest
@testable import JSONParsing

class APIHandlerTests: XCTestCase {
    var apiHandler: APIHandler?
    
    override func setUpWithError() throws {
        apiHandler = APIHandler()
    }

    override func tearDownWithError() throws {
        apiHandler = nil
    }

    func test_apiHAndler_getData_Works() {
        let exp = expectation(description: "Get data")
        let todoUrlString = "https://jsonplaceholder.typicode.com/todos"
        
        apiHandler?.getData(from: todoUrlString) { data, error in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3.0)
    }
    
}
