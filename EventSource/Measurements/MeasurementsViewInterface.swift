//
//  MeasurementsViewInterface.swift
//  EventSource
//
//  Created by Sergey Kim on 21.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

protocol MeasurementsViewInterface: class {
    
    func setActionBarTitle(_ title: String)
    
    func addItems(_ items: [MeasurementUIModel])
    
    func reloadData()
}
