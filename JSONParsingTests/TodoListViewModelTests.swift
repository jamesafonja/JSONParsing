//
//  TodoListViewModelTests.swift
//  JSONParsingTests
//
//  Created by Revive on 9/20/22.
//

import XCTest
@testable import JSONParsing

class TodoListViewModelTests: XCTestCase {
    var vm: TodoListViewModel?
    
    override func setUpWithError() throws {
        vm = TodoListViewModel(service: APIHandler())
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_todoListViewModel_isNotNil() {
        XCTAssertNotNil(vm)
    }
    
    func test_todoUrlString_NotNil() {
        XCTAssertNotNil(vm?.todoUrlString)
    }
    
    func test_service_isNotNil() {
        XCTAssertNotNil(vm?.service)
    }
    
    func test_statusMessage_isEmptyString_onInit() {
        guard let vm = vm else { return }
        XCTAssertTrue(vm.statusMessage.count == 0)
    }
    
    func test_hasError_isFalse_onInit() {
        guard let vm = vm else { return }
        XCTAssertFalse(vm.hasError)
    }
    
    func test_todosArray_isEmpty_onInit() {
        guard let vm = vm else { return }
        XCTAssertTrue(vm.todos.isEmpty)
    }
    
    func test_todoUrlString_isValidURL() {
        guard let vm = vm else { return }
        XCTAssertNotNil(URL(string: vm.todoUrlString))
    }
    
    func test_getTodos_works() {
        guard let vm = vm else { return }
        let exp = expectation(description: "Todos fetched")
        let todosUrlString = "https://jsonplaceholder.typicode.com/todos"
        
        vm.getTodos(from: todosUrlString) { success in
            XCTAssertTrue(success)
            XCTAssertNotNil(vm.todos)
            XCTAssertTrue(vm.statusMessage == "Successfully fetched todos")
            XCTAssertFalse(vm.hasError)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3.0)
    }
    
    func test_getTodos_givesError_onFail() {
        guard let vm = vm else { return }
        let exp = expectation(description: "Get todos should fail with bad endpoint")
        let badUrlString = "https://jsonplaceholder.typicode.com/abcdefgh"

        vm.getTodos(from: badUrlString) { success in
            XCTAssertFalse(success)
            XCTAssertTrue(vm.hasError)
            print("STATUS MESSAGE: \(vm.statusMessage)")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3.0)
    }
}
