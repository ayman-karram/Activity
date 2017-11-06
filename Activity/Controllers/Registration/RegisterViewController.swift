//
//  RegisterViewController.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit
import DatePickerDialog

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var registrationTableView: UITableView!
    
    var fieldsTitlesList       = ["First Name", "Last Name", "Email", "Password", "Birthdate"]
    var fieldsPlaceHoldersList = ["First" , "Last" , "your@email.com" , "Password", "Birthdate"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Instantiation
    class func instantiateFromStoryboard() -> RegisterViewController {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "Sign up"
        registrationTableView.register(UINib(nibName: "RegistrationInputTableViewCell", bundle: nil), forCellReuseIdentifier: "inputInfoCell")
        addJoinNavigationBarItem()
    }
    
    func addJoinNavigationBarItem () {
        let JoinButton = UIBarButtonItem(title: "JOIN" ,style: .plain, target: self, action: #selector (self.doneBarButtonItemClicked(sender:)))
        self.navigationItem.setRightBarButton(JoinButton, animated: true)
    }
    
    func showDatePickerView () {
        
        DatePickerDialog().show("Birthdate", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate:Date() as Date, datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat =  APPDATEFORMATE
                
                var registrationCell : RegistrationInputTableViewCell?
                var indexPath : IndexPath?
                
                indexPath = IndexPath(row: 2, section: 1)
                registrationCell = self.registrationTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
                registrationCell?.inputValueTextField.text = formatter.string(from: dt)
            }
        }
    }
    
    func presentWaittingAccountActiviationVC() {
        let waittingVC = WaitingForAccountActiviationViewController.instantiateFromStoryboard()
        self.present(waittingVC, animated: true, completion: nil)
    }
    
    //MARK: - Actions Functions
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func doneBarButtonItemClicked (sender : Any) {
        
        let validation = VaildationManager.isUserRegistarionDataIsVaild(registrationTableView: registrationTableView)
        
        if validation.0 {
            let userModel = validation.2
            DataBaseManager.sharedInstance.saveUser(user : userModel!)
            DataBaseManager.sharedInstance.setCurrentLoginUserWithUser(user: userModel!)
            self.presentWaittingAccountActiviationVC()
        }
        else
        {
            let alert = AlertManager.getAlerWith(title: "Notes", message: validation.1)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RegisterViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2 // first, last name
        case 1:
            return 3 // email, password, birthday
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputInfoCell") as! RegistrationInputTableViewCell
        
        var inputTitle = ""
        var inputPlaceHolder = ""
        switch indexPath.section {
        case 0:
            inputTitle = self.fieldsTitlesList[indexPath.row]
            inputPlaceHolder = self.fieldsPlaceHoldersList[indexPath.row]
            break
        case 1:
            inputTitle = self.fieldsTitlesList[indexPath.row + 2]
            inputPlaceHolder = self.fieldsPlaceHoldersList[indexPath.row + 2]
            if indexPath.row == 2  { // Birthday
                cell.inputValueTextField.isEnabled = false
            }
            if indexPath.row == 1 { // Password
               cell.inputValueTextField.isSecureTextEntry = true
            }
            break
        default:
            break
        }
        
        cell.setUpCellWithInput(title: inputTitle, placeHolder: inputPlaceHolder)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 2 { // Birthday
            self.showDatePickerView()
        }
    }
}
