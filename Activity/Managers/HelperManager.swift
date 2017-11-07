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
    
    //MARK: App Window Navigation
    class func navigateToLoginController() {
        
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
         let landingPageNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "LandingPageNV") as! UINavigationController
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
    
    class func makeLandingPageAsRootViewControllerToWindow() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let landingPageNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "LandingPageNV") as! UINavigationController
        
        appDelegate.window?.rootViewController = landingPageNavigationController
    }
    
    class func setMainInitialViewController () {
        
        guard let userLoggedIn = UserDefaultsManager.getUserDidLogin() else {
            
            return
        }
        
        if userLoggedIn {
            
            guard let userEmail = UserDefaultsManager.getLoggedInUserEmail() else {
                return
            }
            
            let user = DataBaseManager.sharedInstance.getUserWith(userEmail: userEmail)!
            DataBaseManager.sharedInstance.setCurrentLoginUserWithUser(user: user)
            HelperManager.makeMainTabbarAsRootViewControllerToWindow()
        }
    }
    
    //MARK: General
    class func checkForCurrentUserAccountActivation() {
        guard let currentUser = DataBaseManager.sharedInstance.currentLoginUser else {
            return
        }
        
        if currentUser.isAccountVerified == false {
            DataBaseManager.sharedInstance.updateStateToUserAccountVerfication(user: currentUser, Verified: true)
            HelperManager.navigateToLoginController()
        }
    }
    
    class func userDidChoiceToLogOut () {
        UserDefaultsManager.removeAllUserDefault()
        makeLandingPageAsRootViewControllerToWindow()
    }
    
}
