//
//  AppDelegate.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.initiateUIComponentsView()
        self.initiateVariables()
        self.checkNotificationAuthorization()
    
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: NAVIAGTIONBARTITLENAME, size: NAVIAGTIONBARTITLEFONTSIZE)!,
            NSAttributedStringKey.strokeColor : NAVIAGTIONBARTITLECOLOR
        ]
    }
    
    func checkForCurrentUserAccountActivation() {
        guard let currentUser = DataBaseManager.sharedInstance.currentLoginUser else {
            return
        }
        
        if currentUser.isAccountVerified == false {
            DataBaseManager.sharedInstance.updateStateToUserAccountVerfication(user: currentUser, Verified: true)
            HelperManager.navigateToLoginController()
        }
        
    }
    
    func initiateVariables () {
        IQKeyboardManager.sharedManager().enable = true
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
    
    //MARK:- Notification
    func checkNotificationAuthorization () {
        NotificationsManager.checkForNotificationAuthorization(completionHandler: {authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                NotificationsManager.requestNotificationsAuthorization(completionHandler: {(granted, error) in

                })
                break
            case .authorized:
                // Schedule Local Notification
                break
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        })
    }
    
    //MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        self.checkForCurrentUserAccountActivation()
        
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.checkForCurrentUserAccountActivation()
    }
}

