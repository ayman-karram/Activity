//
//  SettingsViewController.swift
//  Activity
//
//  Created by Ayman  on 11/7/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - Properties
    let settingsFieldsLabels = ["Change Language" , "Notifications tunes" , "About Activity" , "Contact Us" , "Log out"]
    
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
        self.title = "Settings"
    }
    
    func showLogoutAlert () {
        
        let alert = AlertManager.getAlerWithOkButton(title: LOGOUT, message: LOGOUTCONFIRMATIONMESSAGE)
        alert.addAction(UIAlertAction(title: "LOG OUT", style: .default, handler: { action in
            HelperManager.userDidChoiceToLogOut()
            //self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "settingsCell")
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = self.settingsFieldsLabels[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = self.settingsFieldsLabels[indexPath.row + 2]
            break
        case 2:
            let LogOutCell = UITableViewCell(style: .default, reuseIdentifier: "LogoutCell")
            LogOutCell.textLabel?.text = self.settingsFieldsLabels.last
            
            return LogOutCell
        default:
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            self.showLogoutAlert()
        }
    }
    
}
