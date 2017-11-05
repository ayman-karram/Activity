//
//  DataBaseManager.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation

class DataBaseManager {
    
    //MARK: - Properties
    // Singlton
    class var sharedInstance : DataBaseManager {
        struct Singlton {
            static let instance = DataBaseManager()
        }
        return Singlton.instance
    }
    
    var currentLoginUser : User?

    //MARK: - User
    func saveUser (user : User) {
        RealmManager.sharedInstance.addUserToDB(user: user)
    }
    
    func setCurrentLoginUserWithUser(user : User) {
        self.currentLoginUser = user
    }
    
    func getUserWith(userEmail : String) -> User? {
        return RealmManager.sharedInstance.getUserWith(userEmail:userEmail)
    }
    
    func updateStateToUserAccountVerfication (user : User , Verified : Bool) {
       RealmManager.sharedInstance.updateStateToUserAccountVerfication(user: user, Verified: Verified)
    }

}
