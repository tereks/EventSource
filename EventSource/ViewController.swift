//
//  ViewController.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var interactor: Interactor!
    private var tablePresenter: TablePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTablePresenter()
        configureInteractor()
    }
    
    deinit {
        interactor.stopListenSSE()
    }
    
    private func configureInteractor() {
        interactor = Interactor()
        interactor.view = self
        interactor.startListenSSE()
    }
    
    private func configureTablePresenter() {
        tablePresenter = TablePresenter(tableView: tableView)
    }
    
    func addItem(with data: String) {
        tablePresenter.addItem(data)
        tablePresenter.reloadData()
    }
}


