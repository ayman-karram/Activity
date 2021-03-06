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
    
    /**
     Check User Login Authorization.
     
     - Parameter userEmail:   The user email.
     - Parameter password: The user password.
     
     
     - Returns: Tuple - Bool true if your is exist with this user model And false if your is not exist not.
     */
    func checkUserLoginAuthorizationWith (userEmail : String , password: String) -> (Bool , User?) {
        
        return RealmManager.sharedInstance.checkUserLoginAuthorizationWith(userEmail:userEmail, password:password)
    }
    
    func checkIfUserExistedWith(email : String) -> Bool {
        return RealmManager.sharedInstance.checkIfUserExistedWith(email:email)
    }

    //MARK: - Activity
    func addActivityToCurrentLoggedUserWith (activity : Activity) -> Bool {
        
        guard let currentUser = self.currentLoginUser else {
            return false
        }
        
        return RealmManager.sharedInstance.addActivityTo(userEmail: currentUser.email, activity: activity)
    }
    
    /**
     Get LoggedIn User's Activites.
     
     - Returns: NSDictionary : KEY is activity Type and VALUE is Activities Array of this type. example ["Daily" : [Activities] , "Weekly" : [Activities]]
     */
    
    func getLoggedInUserActivites() ->  [String : [Activity]]? {
        
        guard let currentUser = self.currentLoginUser else {
            return nil
        }
        return RealmManager.sharedInstance.getActivitesForUser(email: currentUser.email)
    }

}
