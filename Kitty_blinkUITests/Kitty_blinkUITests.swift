//
//  Kitty_blinkUITests.swift
//  Kitty_blinkUITests
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import XCTest

class Kitty_blinkUITests: XCTestCase {

    // Test, Does app loaded table. It Should equal 1 and did have 5 cells structure to confirm to API
    func testDidTableExist() throws {
    
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertEqual(app.tables.cells.count, 5)

        
    }

    
}


