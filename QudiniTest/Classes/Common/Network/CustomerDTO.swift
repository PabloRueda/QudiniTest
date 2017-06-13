//
//  CustomerDTO.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

struct CustomerDTO {
    let expectedTime: Date //2017-06-13T11:36:29.598+01:00
    let name: String
    let emailAddress: String?
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

extension CustomerDTO {
    
    init?(json: [String: Any]) throws {
        //ExpectedTime
        guard let expectedTime = json["expectedTime"] as? String else {
            throw SerializationError.missing("expectedTime")
        }
        
        //Name
        guard let customerJSON = json["customer"] as? [String: Any],
            let name = customerJSON["name"] as? String
            else {
                throw SerializationError.missing("name")
        }
        
        //emailAddress
        let emailAddress = customerJSON["emailAddress"] as? String
        
        //Initialize properties
        self.expectedTime = expectedTime.toDateTime()
        self.name = name
        self.emailAddress = emailAddress
    }
}
