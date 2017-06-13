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
    
    //MARK: - Mocks
    
    class HomePresenterMock: HomePresenterProtocol {
        var viewDidLoadWasCalled = false
        
        func viewDidLoad() {
            self.viewDidLoadWasCalled = true
        }
    }
}
