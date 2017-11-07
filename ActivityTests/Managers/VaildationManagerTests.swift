//
//  VaildationManagerTests.swift
//  ActivityTests
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import XCTest

@testable import Activity

class VaildationManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testIsUserFirstNameIsVaild () {
        
        let name = "Ayman"
        let result = VaildationManager.isUserFirstNameIsVaild(name: name)
        XCTAssertTrue(result.0, "Expect that Ayman is vaild name")
        
        let anotherName = ""
        let resultToAnotherName = VaildationManager.isUserFirstNameIsVaild(name: anotherName)
        XCTAssertFalse(resultToAnotherName.0, "Expect that anotherName is  not vaild name")

    }
    
    func testIsEmailIsVaild() {
        
        let email = "Ayman.karram@gmail.com"
        let result = VaildationManager.isEmailIsVaild(email: email)
        XCTAssertTrue(result.0, "Expect that Ayman.karram@gmail.com is vaild Email")
        
        let anotherEmail = "ayman.kkarram.com"
        let resultToAnotherEmail = VaildationManager.isEmailIsVaild(email: anotherEmail)
        XCTAssertFalse(resultToAnotherEmail.0, "Expect that Ayman.karram@gmail.com is not vaild Email")
    }
    
}
