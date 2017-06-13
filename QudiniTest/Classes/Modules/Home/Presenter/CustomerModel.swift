//
//  CustomerModel.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

struct CustomerModel {
    let name: String
    let emailAddress: String?
    
    init(name: String, emailAddress: String?) {
        self.name = name
        self.emailAddress = emailAddress
    }
}
