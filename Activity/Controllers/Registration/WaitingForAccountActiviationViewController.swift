//
//  WaitingForAccountActiviationViewController.swift
//  Activity
//
//  Created by Ayman  on 11/5/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit
import SRCountdownTimer
import UserNotifications

class WaitingForAccountActiviationViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var countdownView: SRCountdownTimer!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
        checkNotificationAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Instantiation
    class func instantiateFromStoryboard() -> WaitingForAccountActiviationViewController {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "WaitingForAccountActiviationViewController") as! WaitingForAccountActiviationViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        countdownView.start(beginingValue: 10, interval: 1)
        countdownView.delegate = self
    }
    
    func showVerificationSuccessAlert () {
        let alert = AlertManager.getAlerWithOkButton(title: SCUESS, message: ACCOUNTVERIFIEDMESSAGE)
        alert.addAction(UIAlertAction(title: "LOGIN", style: .default, handler: { action in
            HelperManager.navigateToLoginController()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Notification
    func checkNotificationAuthorization () {
        
        NotificationsManager.checkForNotificationAuthorization(completionHandler: {authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                self.requestForNotificationAuthorization()
            case .authorized:
                // Schedule Local Notification
                NotificationsManager.scheduleActiviationAccountLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
                
            }
        })
    }
    
    func requestForNotificationAuthorization () {
        NotificationsManager.requestNotificationsAuthorization(completionHandler: {(granted, error) in
            
            if granted {
                NotificationsManager.scheduleActiviationAccountLocalNotification()
            }
        })
    }
}

//MARK: - SRCountdownTimerDelegate, UNUserNotificationCenterDelegate
extension WaitingForAccountActiviationViewController : SRCountdownTimerDelegate, UNUserNotificationCenterDelegate {
    
    func timerDidEnd() {
        guard let currentUser = DataBaseManager.sharedInstance.currentLoginUser else {
            return
        }
        
        if currentUser.isAccountVerified == false {
        DataBaseManager.sharedInstance.updateStateToUserAccountVerfication(user: currentUser, Verified: true)
            showVerificationSuccessAlert()
        }
    }
}
