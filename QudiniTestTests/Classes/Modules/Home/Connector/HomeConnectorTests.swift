//
//  HomeConnectorTests.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import XCTest
@testable import QudiniTest

class HomeConnectorTests: XCTestCase {
    
    var sut: HomeConnector!
    
    override func setUp() {
        super.setUp()
        
        sut = HomeConnector()
    }
    
    func testAllDependenciesCreated() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.sut.configureInitialViewController(window)
        
        let navigationVC = window.rootViewController as! UINavigationController
        let homeVC = navigationVC.topViewController as! HomeVC
        let presenter = homeVC.presenter as! HomePresenter
        let interactor = presenter.interactor as! HomeInteractor
        
        XCTAssertNotNil(homeVC, "VC is nil!")
        XCTAssertNotNil(homeVC.presenter, "Presenter is nil!")
        XCTAssertNotNil(presenter.view, "View is nil!")
        XCTAssertNotNil(presenter.interactor, "Interactor is nil!")
        XCTAssertNotNil(interactor.output, "Output interactor is nil!")
    }
}
