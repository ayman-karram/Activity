//
//  UserDefaultManagerTestes.swift
//  ActivityTests
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import XCTest
@testable import Activity

class UserDefaultManagerTestes: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheSetAndGetToUserDidLogin () {
        UserDefaultsManager.setUserDidLogin(login: true)
        let userDidLogin = UserDefaultsManager.getUserDidLogin()
        XCTAssertTrue(userDidLogin!, "Expect that userDidLogin is true")
    }
    
    func testLoggedInUserEmail () {
        let userEmail = "ayman.karram@gmail.com"
        UserDefaultsManager.setLoggedInUserEmail(email: userEmail)
        
        let userLoggedInEmail = UserDefaultsManager.getLoggedInUserEmail()
        XCTAssertEqual(userLoggedInEmail , userEmail, "Expect userLoggedInEmail Equal userEmail")
    }
    
}
