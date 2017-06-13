//
//  HomePresenter.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

protocol HomePresenterProtocol: class {
    func viewDidLoad()
}

class HomePresenter: HomePresenterProtocol, HomeInteractorOutput {
    
    weak internal var view : HomeView!
    internal var interactor : HomeInteractorInput!
    fileprivate var customerModels: [CustomerModel]?
    
    //MARK: - HomePresenterProtocol
    
    func viewDidLoad() {
        self.view?.showLoading()
        self.interactor?.loadData()
    }
    
    //MARK: - HomeInteractorOutput
    
    func didReceiveCustomers(customers: [CustomerEntity]) {
        self.view?.hideError()
        self.view?.hideLoading()
        
        //We order the customers by the closest time
        let orderedCustomers = customers.sorted(by: {$0.expectedTime.compare($1.expectedTime) == .orderedAscending})
        
        //We convert from the entity models to the model for the view
        self.customerModels = [CustomerModel]()
        for customerEntity in orderedCustomers {
            let customerModel = CustomerModel(name:customerEntity.name, emailAddress:customerEntity.emailAddress)
            customerModels!.append(customerModel)
        }
        self.view?.setModels(customerModels!)
    }
    
    func didFailToLoadData() {
        if (self.customerModels == nil) {
            self.view?.hideLoading()
            self.view?.showError()
        }
    }
}
