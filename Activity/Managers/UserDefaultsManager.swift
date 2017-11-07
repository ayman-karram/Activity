//
//  UserDefaultsManager.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    struct Keys {
        static let userDidLogin = "userDidLogin"
        static let loggedInUserEmail = "loggedInUserEmail"

    }
    
    class func setUserDidLogin (login : Bool) {
        UserDefaults.standard.set(login, forKey: Keys.userDidLogin)
    }
    
    class func getUserDidLogin () -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.userDidLogin)
    }
    
    class func setLoggedInUserEmail (email : String) {
        UserDefaults.standard.set(email, forKey: Keys.loggedInUserEmail)
    }
    
    class func getLoggedInUserEmail () -> String? {
        return UserDefaults.standard.string(forKey: Keys.loggedInUserEmail)
    }
    
    class func removeAllUserDefault () {
        UserDefaults.standard.removeObject(forKey: Keys.userDidLogin)
        UserDefaults.standard.removeObject(forKey: Keys.loggedInUserEmail)

    }
    
}
