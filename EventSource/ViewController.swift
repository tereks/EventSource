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
    @IBOutlet var actionBarButton: UIBarButtonItem!
    
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
    }
    
    private func configureTablePresenter() {
        tablePresenter = TablePresenter(tableView: tableView)
    }
    
    func addItems(_ items: [MeasurementData]) {
        tablePresenter.addItems(items)
        tablePresenter.reloadData()
    }
    
    @IBAction func actionBarButtonSelected(_ sender: UIBarButtonItem) {
        if interactor.dataProvider.isListening {
            interactor.stopListenSSE()
            actionBarButton.title = "Start"
        }
        else {
            interactor.startListenSSE()
            actionBarButton.title = "Stop"
        }
    }
}


