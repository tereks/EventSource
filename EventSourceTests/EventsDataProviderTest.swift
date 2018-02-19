//
//  EventsDataProviderTest.swift
//  EventSourceTests
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import XCTest
@testable import EventSource

class EventsDataProviderTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsListening() {
        let provider = EventsDataProvider()
        XCTAssertTrue( !provider.isListening )
        
        provider.startListening()
        XCTAssertTrue( provider.isListening )
        
        provider.stopListening()
        XCTAssertTrue( !provider.isListening )
    }    
}
