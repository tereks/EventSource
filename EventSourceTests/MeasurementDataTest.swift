//
//  MeasurementDataTest.swift
//  EventSourceTests
//
//  Created by Sergey Kim on 20.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import XCTest
@testable import EventSource

class MeasurementDataTest: XCTestCase {
    
    let measurement1 = """
[
  {
    "name": "Location",
    "measurements": [
      1489066746,
      [
        40.55404852193788,
        -73.27629907400552
      ]
    ],
    "_id": "58c15afe518ca70001b80343"
  }
]
"""
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMeasurement1() {
        let data = measurement1.data(using: .utf8)!
        var decodeError: Error? = nil
        do {
            let results = try JSONDecoder().decode([MeasurementData].self, from: data)
            XCTAssertEqual(results.count, 1)
            
            let measurement = results[0]
            XCTAssertEqual(measurement.name, "Location")
            XCTAssertEqual(measurement.id, "58c15afe518ca70001b80343")
            XCTAssertEqual(measurement.measurements.count, 2)
            XCTAssertTrue(measurement.measurements[0].value is Int)
            XCTAssertTrue(measurement.measurements[1].value is Array<AnyJSON>)
        }
        catch {
            decodeError = error
        }
        
        XCTAssertNil(decodeError)
    }
}
