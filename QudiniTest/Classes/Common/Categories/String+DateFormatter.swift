//
//  String+DateFormatter.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

extension String {
    func toDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //Format for: 2017-06-13T11:36:29.598+01:00
        let dateFromString : Date = dateFormatter.date(from:self)!
        return dateFromString
    }
}
