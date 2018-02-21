//
//  MeasurementsViewController.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

final class MeasurementsViewController: UIViewController, MeasurementsViewInterface {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var actionBarButton: UIBarButtonItem!
    
    private var tablePresenter: MeasurementsTablePresenter!
    var presenter: MeasurementsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTablePresenter()
        presenter.setup()
    }
    
    deinit {
        presenter.listeningStateChange(isListening: false)
    }
        
    private func configureTablePresenter() {
        tablePresenter = MeasurementsTablePresenter(tableView: tableView)
    }
    
    func addItems(_ items: [MeasurementUIModel]) {
        tablePresenter.addItems(items)
    }
    
    func reloadData() {
        tablePresenter.reloadData()
    }
    
    func setActionBarTitle(_ title: String) {
         actionBarButton.title = title
    }
    
    @IBAction func actionBarButtonSelected(_ sender: UIBarButtonItem) {
        presenter.listeningStateChange(isListening: !presenter.isListeningToSSE())
    }
}


