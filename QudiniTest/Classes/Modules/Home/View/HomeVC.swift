//
//  ViewController.swift
//  QudiniTest
//
//  Created by Pablo Rueda on 13/06/2017.
//  Copyright © 2017 Pablo Rueda. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func setModels(_ models: [CustomerModel])
    func showLoading()
    func hideLoading()
    func showError()
    func hideError()
}

class HomeVC: UIViewController, HomeView {
    internal var presenter: HomePresenterProtocol!
    
    fileprivate var models: [CustomerModel] = []
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
    //MARK: - HomeView
    
    func setModels(_ models: [CustomerModel]) {
        self.models = models
    }
    
    func showLoading() {
        self.loadingView.isHidden = false
    }
    
    func hideLoading() {
        self.loadingView.isHidden = true
    }
    
    func showError() {
        self.errorView.isHidden = false
    }
    
    func hideError() {
        self.errorView.isHidden = true
    }
}

