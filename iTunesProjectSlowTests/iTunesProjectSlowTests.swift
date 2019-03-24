//
//  iTunesProjectSlowTests.swift
//  iTunesProjectSlowTests
//
//  Created by Артем on 24/03/2019.
//  Copyright © 2019 Gukov.space. All rights reserved.
//

import XCTest
@testable import iTunesProject

class iTunesProjectSlowTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    func testValidCallToiTunesGetsHTTPStatusCode200() {
        let url = URL(string: "https://itunes.apple.com/search?term=avici")
        
        let promise = expectation(description: "Status code: 200")
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
       dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() {
        self.measure {
        }
    }
}
