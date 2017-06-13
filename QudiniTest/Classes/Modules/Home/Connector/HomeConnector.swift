//
//  HomeConnector.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import Foundation
import UIKit

class HomeConnector {
    
    static let storyboardName = "Main"
    
    var initialViewController: UIViewController?
    
    init() {
        let storyboard = UIStoryboard(name: HomeConnector.storyboardName, bundle: nil)
        let initialNavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let view = initialNavigationController.topViewController as! HomeVC
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        initialViewController = initialNavigationController
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        interactor.httpClient = HTTPClient()
    }
    
    // MARK: - Methods
    
    func configureInitialViewController(_ window: UIWindow) {
        window.rootViewController = initialViewController
    }
}
