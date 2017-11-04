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
    
    //MARK: - User
    func saveUser (user : User) {
        RealmManager.sharedInstance.addUserToDB(user: user)
    }
    
    func getUser() -> User {
        return RealmManager.sharedInstance.getUserFromDB()
    }
    
    

}
