//
//  TableViewCell.swift
//  EventSource
//
//  Created by Sergey Kim on 20.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!
    @IBOutlet private var measuremetsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        unitLabel.text = ""
    }
    
    func configure(with data: MeasurementUIModel) {
        nameLabel.text = data.name
        unitLabel.text = data.unit
        if let value = data.value {
            measuremetsLabel.text = String(describing: value)
        }
    }
}
