//
//  HelperManager.swift
//  Activity
//
//  Created by Ayman  on 11/5/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit

class HelperManager {
    
    class func navigateToLoginController() {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let registartionStoryBoard = UIStoryboard(name: "Main", bundle: nil)
         let landingPageNavigationController = registartionStoryBoard.instantiateViewController(withIdentifier: "LandingPageNV") as! UINavigationController
        let landingPageVC = landingPageNavigationController.viewControllers.first as! LandingPageViewController
        landingPageVC.navigateToLoginController = true
        appDelegate.window?.rootViewController = landingPageNavigationController
    }
    
    class func makeMainTabbarAsRootViewControllerToWindow() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let tabbarStoryBoard = UIStoryboard(name: "MainTabBar", bundle: nil)
        let tabbarController = tabbarStoryBoard.instantiateViewController(withIdentifier: "MainTabbarVC") as! UITabBarController
        
        appDelegate.window?.rootViewController = tabbarController
    }
    
    
    class func setMainInitialViewController () {
        
        guard let userLoggedIn = UserDefaultsManager.getUserDidLogin() else {
            
            return
        }
        
        if userLoggedIn {
            let userEmail = UserDefaultsManager.getLoggedInUserEmail()!
            let user = DataBaseManager.sharedInstance.getUserWith(userEmail: userEmail)!
            DataBaseManager.sharedInstance.setCurrentLoginUserWithUser(user: user)
            HelperManager.makeMainTabbarAsRootViewControllerToWindow()

        }
    }
    
    
    class func checkForCurrentUserAccountActivation() {
        guard let currentUser = DataBaseManager.sharedInstance.currentLoginUser else {
            return
        }
        
        if currentUser.isAccountVerified == false {
            DataBaseManager.sharedInstance.updateStateToUserAccountVerfication(user: currentUser, Verified: true)
            HelperManager.navigateToLoginController()
        }
        
    }
    
}
