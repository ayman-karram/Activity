//
//  UserModelTests.swift
//  ActivityTests
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import XCTest
import RealmSwift
@testable import Activity

class UserModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTheInitiationOfUserModel () {
        let testUser = User()
        XCTAssertNotNil(testUser, "Expect testUser not nil")
    }
    
    func testTheInitiationOfUserModelWithGivenValues () {
        let testUser = User()
        testUser.initUserWithInfo(firstName: "Ayman", lastName: "karram", email: "ayman.karram@gmail.com", birthday: "2, Jan 2017", password: "123456")
        XCTAssertEqual(testUser.firstName, "Ayman", "Expect that testUser.firstName become Ayman")
    }
    
    func testTheRelationWithActivityModel () {
        let testUser = User()
        let testActivity = Activity()
        testActivity.initActivityWithInfo(name: "Play Football", type: "Weekly", startDate: "2, Jan 2017", startTime: "3:30 PM")
        testUser.activities.append(testActivity)
        XCTAssertEqual(testUser.activities.first?.name, "Play Football", "Expect that testUser.activities.first?.name become Play Football")
        
    }
    
}
