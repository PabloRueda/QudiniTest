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
    func releaseTimer()
}

protocol HomeInteractorOutput:class {
    func didReceiveCustomers(customers: [CustomerEntity])
    func didFailToLoadData()
}

class HomeInteractor: HomeInteractorInput {
    weak internal var output: HomeInteractorOutput!
    internal var timer: Timer?
    internal var httpClient: HTTPClientProtocol?
    
    func loadData() {
        if (self.timer == nil) {
            self.timer = Timer.scheduledTimer(withTimeInterval: Constants.autorefreshTime, repeats: true) { timer in
                self.requestCustomers()
            }
        }
        
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
    
    //In this demo we don't use this method because it is just one screen, but in a real example we should invalidate it or we will suffer memory leaks
    func releaseTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
