//
//  Kitty_blinkTests.swift
//  Kitty_blinkTests
//
//  Created by Ł.B Morapel on 12/11/2021.
//

import XCTest
@testable import Kitty_blink

class Kitty_blinkTests: XCTestCase {

    
    // Test should check the boolean status of JSON Error. If there is no errors test should pass.
    
    func testDoesJSONErrorExist(){
        
        let vc = ViewController()
        
        _ = vc.kittyArray
        XCTAssertFalse(vc.errorJSON, "Error doesnt Exist")
        
    }
}

