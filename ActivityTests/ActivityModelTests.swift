//
//  ActivityModelTests.swift
//  ActivityTests
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import XCTest
import RealmSwift
@testable import Activity

class ActivityModelTests: XCTestCase {
    
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
        let testActivity = Activity()
        XCTAssertNotNil(testActivity, "Expect testActivity not nil")
    }
    
    func testTheInitiationOfUserModelWithGivenValues () {
        let testActivity = Activity()
        testActivity.initActivityWithInfo(name: "Play Football", type: "Weekly", startDate: "2, Jan 2017", startTime: "3:30 PM")
        XCTAssertEqual(testActivity.name, "Play Football", "Expect that testUser.firstName become Ayman")
        XCTAssertEqual(testActivity.type, "Weekly", "Expect that testActivity.type become Weekly")
        XCTAssertEqual(testActivity.startDate, "2, Jan 2017", "Expect that testActivity.startDate become 2, Jan 2017")
        XCTAssertEqual(testActivity.startTime, "3:30 PM", "Expect that testActivity.startTime become 3:30 PM")
    }
    
}
