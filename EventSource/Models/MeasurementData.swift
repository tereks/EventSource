//
//  MeasurementData.swift
//  EventSource
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import Foundation

struct MeasurementData: Decodable {
    let id: String
    let name: String
    let unit: String?
    let measurements: [AnyJSON]
    
    enum Keys: String, CodingKey {
        case id = "_id"
        case name
        case unit
        case measurements
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        unit = try? container.decode(String.self, forKey: .unit)
        measurements = try container.decode([AnyJSON].self, forKey: .measurements)
    }
}

