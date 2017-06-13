//
//  HomeInteractorTests.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest

class BarInteractorTests: XCTestCase {
    
    var sut: HomeInteractor!
    var output: OutputMock!
    var httpClient: HTTPClientMock!
    
    override func setUp() {
        super.setUp()
        
        output = OutputMock()
        httpClient = HTTPClientMock()
        sut = HomeInteractor()
        sut.output = output
        sut.httpClient = httpClient
    }
    
    func testLoadData() {
        let predicate = NSPredicate(format: "didReceiveCustomersWasCalled == true")
        self.expectation(for: predicate, evaluatedWith: output) { () -> Bool in
            let customerResult: CustomerEntity = (self.output.customers?.first!)!
            let customerEntity = CustomerEntity(name: "Pablo", emailAddress: "pablo@gmail.com", expectedTime: Date())
            
            XCTAssertEqual(customerResult.name, customerEntity.name)
            XCTAssertEqual(customerResult.emailAddress, customerEntity.emailAddress)
            
            return true
        }
        
        self.sut.loadData()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: - Mocks
    
    class OutputMock: NSObject, HomeInteractorOutput {
        var didReceiveCustomersWasCalled = false
        var customers: [CustomerEntity]?
        var didFailToLoadDataWasCalled = false
        
        func didReceiveCustomers(customers: [CustomerEntity]) {
            self.didReceiveCustomersWasCalled = true
            self.customers = customers
        }
        
        func didFailToLoadData() {
            self.didFailToLoadDataWasCalled = true
        }
    }
    
    class HTTPClientMock: HTTPClientProtocol {
        var requestCustomersWasCalled = false
        
        func requestCustomers(completed: @escaping ([CustomerDTO]?, Error?) -> Void){
            self.requestCustomersWasCalled = true
        
            let customerDTO = CustomerDTO(expectedTime: Date(), name: "Pablo", emailAddress: "pablo@gmail.com")
            completed([customerDTO], nil)
        }
    }
}
