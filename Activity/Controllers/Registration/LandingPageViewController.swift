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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.singInButton.layer.cornerRadius  = BUTTONSCORNERRADIUS
        self.singInButton.layer.masksToBounds = true
        self.singInButton.layer.borderColor   = UIColor.white.cgColor
        self.singInButton.layer.borderWidth   = BUTTONSBORDERSWIDTH
        self.registerButton.layer.cornerRadius  = BUTTONSCORNERRADIUS
        self.registerButton.layer.masksToBounds = true
        
    }
    
    //MARK: - Actions
    @IBAction func signInButtonClicked(_ sender: Any) {
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
    }
    
}
