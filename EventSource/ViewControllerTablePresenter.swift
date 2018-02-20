//
//  ViewControllerTablePresenter.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

final class TablePresenter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var maximumNumberOfCells: Int = 500
    private var measurements: [MeasurementData] = []
    private weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
    }
    
    func addItems(_ items: [MeasurementData]) {
        measurements.insert(items.first!, at: 0)
        if measurements.count > maximumNumberOfCells {
            measurements.removeLast()
        }
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            assertionFailure("Invalid cell type")
            return UITableViewCell()
        }
        cell.configure(with: measurements[indexPath.row])
        return cell
    }
}
