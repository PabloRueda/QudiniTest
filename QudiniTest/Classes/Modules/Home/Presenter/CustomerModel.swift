//
//  CustomerModel.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

struct CustomerModel: Hashable {
    let name: String
    let emailAddress: String?
    var hashValue: Int {
        return self.name.hash
    }
    
    init(name: String, emailAddress: String?) {
        self.name = name
        self.emailAddress = emailAddress
    }
    
    public func photoURLString(size: Double) -> String {
        return String.gravatarURL(emailAddress: emailAddress, size: size)
    }
    
    static func ==(lhs: CustomerModel, rhs: CustomerModel) -> Bool {
        return lhs.name == rhs.name && lhs.emailAddress == rhs.emailAddress
    }
}
