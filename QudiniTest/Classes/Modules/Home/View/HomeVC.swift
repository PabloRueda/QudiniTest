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

class HomeVC: UIViewController, HomeView, UICollectionViewDelegate, UICollectionViewDataSource {
    internal var presenter: HomePresenterProtocol!
    
    fileprivate var models: [CustomerModel] = []
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
    }
    
    //MARK: - HomeView
    
    func setModels(_ models: [CustomerModel]) {
        self.models = models
        self.collectionView?.reloadData()
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
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "HomeCellID"
        let customerModel = self.models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeCollectionViewCell
        cell.nameLabel.text = customerModel.name
        
        //TODO set the image view
        
        return cell
    }
}

