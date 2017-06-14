//
//  HTTPClientTests.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 14/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest

class HTTPClientTests: XCTestCase {
    
    var sut: HTTPClient!
    
    override func setUp() {
        super.setUp()
        
        sut = HTTPClient(sessionCreator: { URLSessionMock() } )
    }
    
    func testRequestCustomersResponseOK() {
        let requestExpectation = expectation(description: "Request block")
        
        self.sut.requestCustomers { (customers, error) in
            let customer = customers!.first!
            XCTAssertEqual(customer.emailAddress, "pablo@gmail.com", "Wrong email!")
            XCTAssertEqual(customer.name, "Pablo", "Wrong name!")
            XCTAssertNotNil(customer.expectedTime, "expectedTime is null!")
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: - Mocks
    
    class URLSessionMock: URLSessionProtocol {
        var dataTask = URLSessionDataTaskMock()
        var data: Data?
        var error: Error?
        
        func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
            let jsonString = "{\"queueData\": {\"queue\": { \"customersToday\": [ { \"customer\": { \"emailAddress\": \"pablo@gmail.com\", \"name\": \"Pablo\" },\"expectedTime\": \"2017-06-13T19:24:57.371+01:00\" } ] } } }"
            self.data = jsonString.data(using: .utf8)
            
            completionHandler(self.data, nil, self.error)
            
            return dataTask
        }
    }
    
    class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
        var resumeWasCalled = false
        
        func resume() {
            resumeWasCalled = true
        }
    }
}
