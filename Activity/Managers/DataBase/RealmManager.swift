//
//  RealmManager.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {

    //MARK: - Properties
    var realm : Realm!
    
    init(){
        do {
           try realm = Realm()
        }
         catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    // Singlton
    class var sharedInstance : RealmManager {
        struct Singlton {
            static let instance = RealmManager()
        }
        
        return Singlton.instance
    }
    
    //MARK: - User
    func addUserToDB (user : User) {
        try! realm.write {
            realm.add(user)
        }
    }
    
    func getUserFromDB () -> User {
        let users = realm.objects(User.self)
        return users.first!
    }
    
}
