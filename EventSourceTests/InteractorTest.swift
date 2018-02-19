//
//  InteractorTest.swift
//  EventSourceTests
//
//  Created by Sergey Kim on 19.02.2018.
//  Copyright © 2018 KS. All rights reserved.
//

import XCTest
@testable import EventSource

class InteractorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInteractorListener() {
        let interactor = Interactor()
        XCTAssertTrue( !interactor.dataProvider.isListening )
        
        interactor.startListenSSE()
        XCTAssertTrue( interactor.dataProvider.isListening )
        
        interactor.stopListenSSE()
        XCTAssertTrue( !interactor.dataProvider.isListening )
    }
    
}
