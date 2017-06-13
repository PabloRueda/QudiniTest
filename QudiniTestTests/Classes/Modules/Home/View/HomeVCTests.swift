//
//  QudiniTestTests.swift
//  QudiniTestTests
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest

class HomeVCTests: XCTestCase {
    
    var sut: HomeVC!
    var presenter: HomePresenterMock!
    
    override func setUp() {
        super.setUp()
        
        presenter = HomePresenterMock()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "HomeVCID") as! HomeVC
        sut.presenter = presenter
        let _ = sut.view
    }
    
    func testViewDidLoadCallPresenter() {
        self.sut.viewDidLoad()
        
        XCTAssertTrue(self.presenter.viewDidLoadWasCalled, "View did load was not called!")
    }
    
    //MARK: - HomeView
    
    func testShowLoadingShowLoadView() {
        self.sut.showLoading()
        
        XCTAssertFalse(self.sut.loadingView.isHidden, "Load view is hidden!")
    }
    
    func testHideLoadingHideLoadView() {
        self.sut.hideLoading()
        
        XCTAssertTrue(self.sut.loadingView.isHidden, "Load view is not hidden!")
    }
    
    func testShowErrorShowErrorView() {
        self.sut.showError()
        
        XCTAssertFalse(self.sut.errorView.isHidden, "Error view is hidden!")
    }
    
    func testHideErrorHideErrorView() {
        self.sut.hideError()
        
        XCTAssertTrue(self.sut.errorView.isHidden, "Error view is not hidden!")
    }
    
    //MARK: - UICollectionViewDataSource
    
    func testCorrectNumberOfItems() {
        let customerModel = CustomerModel(name: "Name", emailAddress: "pablo@gmail.com")
        self.sut.setModels([customerModel])
        let items = self.sut.collectionView(self.sut.collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(items, 1, "Wrong number of items!")
    }
    
    func testCorrectCell() {
        let customerModel = CustomerModel(name: "Name", emailAddress: "pablo@gmail.com")
        self.sut.setModels([customerModel])
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.sut.collectionView(self.sut.collectionView, cellForItemAt: indexPath) as! HomeCollectionViewCell
        
        XCTAssertEqual(cell.nameLabel.text, customerModel.name, "Wrong name!")
    }
    
    //MARK: - Mocks
    
    class HomePresenterMock: HomePresenterProtocol {
        var viewDidLoadWasCalled = false
        
        func viewDidLoad() {
            self.viewDidLoadWasCalled = true
        }
    }
}
