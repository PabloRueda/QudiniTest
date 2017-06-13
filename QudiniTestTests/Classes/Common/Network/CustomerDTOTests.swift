//
//  CustomerDTOTests.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest

class CustomerDTOTests: XCTestCase {
    
    func testCustomerDTOParse() {
        let jsonString = "{ \"customer\": { \"emailAddress\": \"pablo@gmail.com\", \"name\": \"Pablo\" },\"expectedTime\": \"2017-06-13T19:24:57.371+01:00\" }"
        let data = jsonString.data(using: .utf8)
        let jsonObject = try! JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions(rawValue: 0)) as! [String : Any]
        let sut = try! CustomerDTO(json:jsonObject)
        
        XCTAssertEqual(sut?.emailAddress, "pablo@gmail.com", "Wrong email!")
        XCTAssertEqual(sut?.name, "Pablo", "Wrong name!")
        XCTAssertNotNil(sut?.expectedTime, "expectedTime is null!")
    }
}
