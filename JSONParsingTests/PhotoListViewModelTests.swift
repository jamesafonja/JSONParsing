//
//  PhotoListViewModelTests.swift
//  JSONParsingTests
//
//  Created by Revive on 9/20/22.
//

import XCTest
@testable import JSONParsing

class PhotoListViewModelTests: XCTestCase {
    var vm: PhotoListViewModel?
    
    override func setUpWithError() throws {
        vm = PhotoListViewModel(service: APIHandler())
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_photoListViewModel_isNotNil() {
        XCTAssertNotNil(vm)
    }
    
    func test_photoUrlString_NotNil() {
        XCTAssertNotNil(vm?.photosUrlString)
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

    func test_photosArray_isEmpty_onInit() {
        guard let vm = vm else { return }
        XCTAssertTrue(vm.photos.isEmpty)
    }
    
    func test_photosUrl_isValidURL() {
        guard let vm = vm else { return }
        XCTAssertNotNil(URL(string: vm.photosUrlString))
    }
    

    func test_getPhotos_works() {
        guard let vm = vm else { return }
        let exp = expectation(description: "Photos were fetched")
        let photosUrlString = "https://jsonplaceholder.typicode.com/photos"
        
        vm.getPhotos(from: photosUrlString) { success in
            XCTAssertTrue(success)
            XCTAssertNotNil(vm.photos)
            XCTAssertTrue(vm.statusMessage == "Fetched photos successfully")
            XCTAssertFalse(vm.hasError)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 3.0)
    }
    
    func test_getPhotos_givesError_onFail() {
        guard let vm = vm else { return }
        let exp = expectation(description: "Get photos should fail with bad url")
        let badUrlString = "https://jsonplaceholder.typicode.com/bad_endpoint"

        vm.getPhotos(from: badUrlString) { success in
            XCTAssertFalse(success)
            XCTAssertTrue(vm.hasError)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)

    }
}
