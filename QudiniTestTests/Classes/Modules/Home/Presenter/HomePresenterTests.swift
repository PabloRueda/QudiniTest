//
//  HomePresenterTests.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest
class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    var view: HomeViewMock!
    var interactor: HomeInteractorMock!
    
    override func setUp() {
        super.setUp()
        
        interactor = HomeInteractorMock()
        view = HomeViewMock()
        sut = HomePresenter()
        sut.view = view
        sut.interactor = interactor
    }
    
    //MARK: - HomePresenterProtocol
    
    func testViewDidLoadLoadData() {
        sut.viewDidLoad()
        XCTAssertTrue(self.interactor.loadDataWasCalled, "LoadData was not called!")
    }
    
    func testViewDidLoadShowLoading() {
        sut.viewDidLoad()
        XCTAssertTrue(self.view.showLoadingWasCalled, "showLoading was not called!")
    }
    
    //MARK: - Mocks
    
    class HomeInteractorMock: HomeInteractorInput {
        var loadDataWasCalled = false
        
        func loadData() {
            self.loadDataWasCalled = true
        }
    }
    
    class HomeViewMock: HomeView {
        var setModelsWasCalled = false
        var models: [CustomerModel]?
        var showLoadingWasCalled = false
        var hideLoadingWasCalled = false
        var showErrorWasCalled = false
        var hideErrorWasCalled = false
        
        func setModels(_ models: [CustomerModel]) {
            self.setModelsWasCalled = true
            self.models = models
        }
        
        func showLoading() {
            self.showLoadingWasCalled = true
        }
        
        func hideLoading() {
            self.hideLoadingWasCalled = true
        }
        
        func showError() {
            self.showErrorWasCalled = true
        }
        
        func hideError() {
            self.hideErrorWasCalled = true
        }
    }
}
