//
//  CustomerEntity.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

struct CustomerEntity:Equatable {
    let name: String
    let emailAddress: String?
    let expectedTime: Date
    
    init(name: String, emailAddress: String?, expectedTime: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.expectedTime = expectedTime
    }
    
    static func ==(lhs: CustomerEntity, rhs: CustomerEntity) -> Bool {
        return lhs.name == rhs.name && lhs.emailAddress == rhs.emailAddress && lhs.expectedTime == rhs.expectedTime
    }
}
