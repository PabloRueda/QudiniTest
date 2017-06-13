//
//  CustomerEntity.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

struct CustomerEntity {
    let name: String
    let emailAddress: String?
    let expectedTime: Date
    
    init(name: String, emailAddress: String?, expectedTime: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.expectedTime = expectedTime
    }
}
