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
    
    //MARK: - HomePresenterProtocol
    
    func viewDidLoad() {
        self.view?.showLoading()
        self.interactor?.loadData()
    }
    
    //MARK: - HomeInteractorOutput
    
    func didReceiveCustomers(customers: [CustomerEntity]) {
        //TODO
    }
    
    func didFailToLoadData() {
        //TODO
    }
}
