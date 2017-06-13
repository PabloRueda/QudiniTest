//
//  HomeInteractor.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation

protocol HomeInteractorInput: class {
    func loadData()
}

protocol HomeInteractorOutput:class {
    func didReceiveCustomers(customers: [CustomerEntity])
    func didFailToLoadData()
}

class HomeInteractor: HomeInteractorInput {
    weak internal var output: HomeInteractorOutput!
    
    func loadData() {
        //TODO
    }
}
