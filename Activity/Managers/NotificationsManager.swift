//
//  NotificationsManager.swift
//  Activity
//
//  Created by Ayman  on 11/5/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UserNotifications

class NotificationsManager {
    
    //MARK: - Local Notifications
    class func checkForNotificationAuthorization(completionHandler: @escaping (UNAuthorizationStatus) -> Swift.Void) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            
            completionHandler(notificationSettings.authorizationStatus)
        }
    }
    
    class func requestNotificationsAuthorization (completionHandler: @escaping (Bool, Error?) -> Swift.Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            completionHandler(granted, error)
        }
    }
    
    class func scheduleActiviationAccountLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Good News", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: ACCOUNTVERIFIEDMESSAGE, arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "com.activity.localNotification"
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 300.0, repeats: false)
        let request = UNNotificationRequest.init(identifier: "AccountActiviation", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    //MARK: -  Notifications Center
    class func postNotificationWithNotification (name : String) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil)
        
    }
    
    
}
