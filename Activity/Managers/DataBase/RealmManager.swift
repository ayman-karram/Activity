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
    
    func getUserWith(userEmail : String) -> User? {
        let user = realm.objects(User.self).filter("email = \(userEmail)")
        return user.first
    }
    
    func updateStateToUserAccountVerfication (user : User, Verified : Bool ) {
        try! realm.write {
            user.isAccountVerified = Verified
        }
    }
    
    func checkUserLoginAuthorizationWith (userEmail : String , password: String) -> (Bool , User?) {
        
        let result = realm.objects(User.self).filter("email = '\(userEmail)' AND password = '\(password)'")
        
        if result.count > 0 {
            return (true ,result.first!)
        }
        else
        {
            return (false ,nil)
        }
    }
    
    //MARK: Activity
    func addActivityTo(userEmail : String , activity : Activity) -> Bool {
        
        let userResult = realm.objects(User.self).filter("email = '\(userEmail)'")
        if userResult.count > 0 {
            let selectedUser = userResult.first!
            
            try! realm.write {
                selectedUser.activities.append(activity)
            }
            return true
        }
        else
        {
            return false
        }
    }
    
    func getActivitesForUser(email : String) ->  [String : [Activity]]{
        
        var activites : [String : [Activity]] = [:]

        let userResult = realm.objects(User.self).filter("email = '\(email)'")
        if userResult.count > 0 {
        let selectedUser = userResult.first!
      
            for activityString in ACTIVITESTAYPELIST {
            
                let arrayOfActivities = self.filterUserActivitiesAccordingToTypeWith( user: selectedUser, activityType: activityString)
                activites [activityString] = arrayOfActivities
            }
        }
        
        return activites
    }
    
    func filterUserActivitiesAccordingToTypeWith (user : User , activityType : String) -> [Activity] {
        
        let activites = user.activities.filter({$0.type == activityType})
        return Array(activites)
    }
}
