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
    private var items: [String] = []
    private weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addItem(_ item: String) {
        items.insert(item, at: 0)
        if items.count > maximumNumberOfCells {
            items.removeLast()
        }
    }
    
    func reloadData() {
        self.tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
