//
//  MeasurementUIModel.swift
//  EventSource
//
//  Created by Sergey Kim on 20.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import UIKit

struct MeasurementUIModel {
    let name: String
    let unit: String?
    let value: Any?
    
    init(data: MeasurementData) {
        self.name = data.name
        self.unit = data.unit
        if let lastMeasurement = data.measurements.last,
            let measurements = lastMeasurement.value as? [AnyJSON],
            let data = measurements.last?.value {
        
            if let arrayValue = data as? [AnyJSON] {
                value = arrayValue.flatMap { $0.value }
            }
            else {
                value = data
            }
        }
        else {
            value = nil
        }
    }
}
