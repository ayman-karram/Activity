//
//  LandingPageViewController.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var navigateToLoginController = false
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
        if navigateToLoginController {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.pushLoginViewControllerWithAnimation(animation: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Instantiation
    class func instantiateFromStoryboard() -> LandingPageViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPageViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.singInButton.layer.cornerRadius  = BUTTONSCORNERRADIUS
        self.singInButton.layer.masksToBounds = true
        self.singInButton.layer.borderColor   = UIColor.white.cgColor
        self.singInButton.layer.borderWidth   = BUTTONSBORDERSWIDTH
        self.registerButton.layer.cornerRadius  = BUTTONSCORNERRADIUS
        self.registerButton.layer.masksToBounds = true
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.backBarButtonItem = backButton
        
    }
    
    func pushRegistrationViewController () {
        let registrationVC = RegisterViewController.instantiateFromStoryboard()
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func pushLoginViewControllerWithAnimation (animation : Bool) {
        let loginVC = LoginViewController.instantiateFromStoryboard()
        self.navigationController?.pushViewController(loginVC, animated: animation)
    }
    
    func checkNotificationAuthorization () {
        NotificationsManager.checkForNotificationAuthorization(completionHandler: {authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                self.requestForNotificationAuthorization()
            case .authorized:
                // Schedule Local Notification
                break
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        })
    }
    
    func requestForNotificationAuthorization () {
        NotificationsManager.requestNotificationsAuthorization(completionHandler: {(granted, error) in
            
        })
    }
    
    //MARK: - Actions
    @IBAction func signInButtonClicked(_ sender: Any) {
        self.pushLoginViewControllerWithAnimation(animation: true)
        //self.presentWaittingAccountActiviationVC()
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        self.pushRegistrationViewController()
    }
    
}
