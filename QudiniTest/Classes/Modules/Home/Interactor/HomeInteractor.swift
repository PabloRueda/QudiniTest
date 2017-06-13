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
    internal var httpClient: HTTPClientProtocol?
    
    func loadData() {
        self.requestCustomers()
    }
    
    fileprivate func requestCustomers() {
        httpClient?.requestCustomers(completed: { (customersDTO, error) in
            if let customersDTO = customersDTO {
                var customerEntities = [CustomerEntity]()
                for customerDTO in customersDTO {
                    let customerEntity = CustomerEntity(name:customerDTO.name, emailAddress: customerDTO.emailAddress, expectedTime: customerDTO.expectedTime)
                    customerEntities.append(customerEntity)
                }
                self.output?.didReceiveCustomers(customers: customerEntities)
            }else {
                self.output?.didFailToLoadData()
            }
        })
    }
}
