//
//  DataBaseManagerTestes.swift
//  ActivityTests
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import XCTest
import RealmSwift

@testable import Activity

class DataBaseManagerTestes: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        super.tearDown()
    }
    
    func testTheInitiationOfSingltonObject () {
        let firstDataBaseSingltonManager = DataBaseManager.sharedInstance
        let user = User()
        user.firstName = "Ayman"
        firstDataBaseSingltonManager.currentLoginUser = user

        let secondDataBaseManager = DataBaseManager.sharedInstance
        XCTAssertEqual(secondDataBaseManager.currentLoginUser?.firstName, "Ayman", "Expect that econdDataBaseManager.currentLoginUser?.firstName become Ayman")
    }
    
    func testSaveAndRetrieveUserFromDB() {
        
        //Save
        let user = User()
        user.firstName = "Joi"
        user.email = "Joi@gmail.com"
        
        DataBaseManager.sharedInstance.saveUser(user: user)
        
        //Retrieve
        let userFromBD = DataBaseManager.sharedInstance.getUserWith(userEmail: "Joi@gmail.com")
        XCTAssertEqual(userFromBD?.firstName , "Joi", "Expect that userFromBD?.firstName become Ayman")
    }
    
    func testUpdateStateToUserAccountVerfication() {
        
        let user = User()
        user.firstName = "Hassan"
        user.email = "Hassan@gmail.com"
        
        XCTAssertFalse(user.isAccountVerified, "Expect that user.isAccountVerified default value is false")
        
        DataBaseManager.sharedInstance.updateStateToUserAccountVerfication(user: user, Verified: true)
        
        XCTAssertTrue(user.isAccountVerified, "Expect that user.isAccountVerified become true")
    }
    
    
    func testCheckUserLoginAuthorizationWithUserInDB() {
        
        let user = User()
        user.firstName = "Mo"
        user.email = "Mo@gmail.com"
        user.password = "123456"
        
        DataBaseManager.sharedInstance.saveUser(user: user)
        
        let result = DataBaseManager.sharedInstance.checkUserLoginAuthorizationWith(userEmail: user.email, password: user.password)
        
        XCTAssertTrue(result.0, "Expect that result is true")
        XCTAssertEqual(result.1!.firstName , "Mo", "Expect that userFromBD?.firstName become Mo")
        
    }
    
    func testAddActivityToCurrentLoggedUser() {
        
        let user = User()
        user.firstName = "Ayman"
        user.email = "Ayman@gmail.com"
        
        let activity = Activity()
        activity.name = "Play Football"
        activity.type = "Weekly"
        
        DataBaseManager.sharedInstance.saveUser(user: user)
        DataBaseManager.sharedInstance.currentLoginUser = user
        
        let result = DataBaseManager.sharedInstance.addActivityToCurrentLoggedUserWith(activity: activity)
        
        XCTAssertTrue(result, "Expect that result is true")
        
    }
    
    func testGetLoggedInUserActivites () {
        
       self.testAddActivityToCurrentLoggedUser()
        
        // Add Another activity to the user with diffrent type
        
        let activity = Activity()
        activity.name = "Go for a walk"
        activity.type = "Daily"
        
        let addResult = DataBaseManager.sharedInstance.addActivityToCurrentLoggedUserWith(activity: activity)
        
        if addResult {
            
            let result = DataBaseManager.sharedInstance.getLoggedInUserActivites()
            
            let numberOfWeeklyActivites = result!["Weekly"]?.count
            let numberOfDailyActivites  = result!["Daily"]?.count
            let numberOfYearlyActivites  = result!["Yearly"]?.count

            XCTAssertEqual(numberOfWeeklyActivites , 1, "Expect numberOfWeeklyActivites Equal 1")
            XCTAssertEqual(numberOfDailyActivites , 1, "Expect numberOfDailyActivites Equal 1")
            XCTAssertEqual(numberOfYearlyActivites , 0, "Expect numberOfYearlyActivites Equal 0")

        }
        
    }
    
}
