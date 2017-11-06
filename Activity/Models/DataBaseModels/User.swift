//
//  User.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var firstName = ""
    @objc dynamic var lastName  = ""
    @objc dynamic var email  = ""
    @objc dynamic var birthday  = ""
    @objc dynamic var password  = ""
    @objc dynamic var isAccountVerified  = false
    let activities = List<Activity>()
    
    override static func primaryKey() -> String? {
        return "email"
    }
    
    func initUserWithInfo(firstName : String , lastName: String , email : String, birthday : String , password : String) {
        
        self.firstName = firstName
        self.lastName  = lastName
        self.email     = email
        self.birthday  = birthday
        self.password  = password
    }
}

