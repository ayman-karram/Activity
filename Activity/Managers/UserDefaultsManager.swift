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
    }
    
    class func setUserDidLogin (login : Bool) {
        UserDefaults.standard.set(login, forKey: Keys.userDidLogin)
    }
    
    class func getUserDidLogin () -> Bool? {
        return UserDefaults.standard.bool(forKey: Keys.userDidLogin)
    }
}
