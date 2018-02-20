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
        measuremetsLabel.text = ""
    }
    
    func configure(with data: MeasurementData) {
        nameLabel.text = data.name
        unitLabel.text = data.unit
        let measurements = data.measurements.reduce(String(), { result, anyObject in
            if let array = anyObject.value as? Array<AnyJSON> {
                return result + description(of: array)
            }
            else {
                return result + String(describing: anyObject.value) + ", "
            }
        })
        measuremetsLabel.text = measurements
    }
    
    private func description(of array: Array<AnyJSON>) -> String {
        return array.reduce(String(), { result, anyObject in
            if let array = anyObject.value as? Array<AnyJSON> {
                return result + description(of: array)
            }
            else {
                return result + String(describing: anyObject.value) + ", "
            }
        })
    }
}
