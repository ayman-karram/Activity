//
//  VaildationManager.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit

class VaildationManager {
    
    //MARK: Registarion
    
    /**
     Check if User Registarion Data Is Vaild.
     
     - Parameter registrationTableView: The registration Table View.
     
     - Returns: Tuple With - Bool true Data is vaild with empty error message And false if data is not vaild with error message.
     */
    class func isUserRegistarionDataIsVaild(registrationTableView : UITableView) -> (Bool , String , User?) {
        
        var vaildationMessage = ""
        var vaild = true
        var registrationCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        var userEmail = ""
        
        // FistName
        indexPath = IndexPath(row: 0, section: 0)
        registrationCell = registrationTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        guard let inputCell = registrationCell  else {
            return (false, "" , nil)
        }
        
        let vaildateFirstName = self.isUserFirstNameIsVaild(name: inputCell.inputValueTextField.text!)
        
        if vaildateFirstName.0 == false {
            vaild = false
            vaildationMessage += vaildateFirstName.1
        }
        
        // Email
        indexPath = IndexPath(row: 0, section: 1)
        registrationCell = registrationTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        userEmail = registrationCell!.inputValueTextField.text!
        let vaildateEmail = self.isEmailIsVaild(email : userEmail)
        
        if vaildateEmail.0 == false {
            vaild = false
            vaildationMessage += "\n" + vaildateEmail.1
        }
        
        // password
        indexPath = IndexPath(row: 1, section: 1)
        registrationCell = registrationTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        let vaildatePassword = self.isPasswordIsVaild(password: registrationCell!.inputValueTextField.text!)
        
        
        if vaildatePassword.0 == false {
            vaild = false
            vaildationMessage += "\n" + vaildatePassword.1
        }
        
        
        //Email not Existed
        let emailExiste = DataBaseManager.sharedInstance.checkIfUserExistedWith(email: userEmail)
        if emailExiste {
            vaild = false
            vaildationMessage +=  "\n" + USERWITHSAMEEMAILEXSISTE
        }
        
        if vaild {
            let user = self.initUserModelFromInputesData(registrationTableView: registrationTableView)
            return (true , "" , user)
        }
        
        return (false , vaildationMessage , nil)
    }
    
    /**
     Initiate User Model From Inputes Data.
     
     - Parameter registrationTableView: The registration Table View.
     
     - Returns: User Model of the registered user used by after check isUserRegistarionDataIsVaild.
     */
    
    class func initUserModelFromInputesData (registrationTableView : UITableView) -> User {
        
        let fistName = self.getTextInputStringFromTextFieldAt(tableView: registrationTableView, section: 0, row: 0)
        let lastName = self.getTextInputStringFromTextFieldAt(tableView: registrationTableView, section: 0, row: 1)
        let email = self.getTextInputStringFromTextFieldAt(tableView: registrationTableView, section: 1, row: 0)
        let password = self.getTextInputStringFromTextFieldAt(tableView: registrationTableView, section: 1, row: 1)
        let birthday = self.getTextInputStringFromTextFieldAt(tableView: registrationTableView, section: 1, row: 2)
        
        let user = User()
        user.initUserWithInfo(firstName: fistName, lastName: lastName, email: email, birthday: birthday, password: password)
        
        return user
    }
    
    //MARK: Login
    
    /**
     Check if User Registarion Data Is Vaild.
     
     - Parameter loginTableView: The login Table View.
     
     - Returns: Tuple With - Bool true Data is vaild and user exist with empty error message And false if data is not vaild or user not exist  with error message.
     */
    class func isUserLoginDataIsVaild(loginTableView : UITableView) -> (Bool , String , User?) {
        
        var vaildationMessage = ""
        var vaild = true
        var loginCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        var email = ""
        var password = ""
        
        // Email
        indexPath = IndexPath(row: 0, section: 0)
        loginCell = loginTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        email = loginCell!.inputValueTextField.text!
        let vaildateEmail = self.isEmailIsVaild(email : email)
        
        if vaildateEmail.0 == false {
            vaild = false
            vaildationMessage += "\n" + vaildateEmail.1
        }
        
        // password
        indexPath = IndexPath(row: 1, section: 0)
        loginCell = loginTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        password = loginCell!.inputValueTextField.text!
        let vaildatePassword = self.isPasswordIsVaild(password: password)
        
        if vaildatePassword.0 == false {
            vaild = false
            vaildationMessage += "\n" + vaildatePassword.1
        }
        
        if vaild {
            
            let loginCredentialsVaild = DataBaseManager.sharedInstance.checkUserLoginAuthorizationWith(userEmail: email, password: password)
            
            if loginCredentialsVaild.0 {
                DataBaseManager.sharedInstance.setCurrentLoginUserWithUser(user: loginCredentialsVaild.1!)
                return (true , "" , loginCredentialsVaild.1)
            }
            else
            {
                return (false,EMAILORPASSWORDNOTCORRECT, nil)
            }
           
        }
        
        return (false , vaildationMessage , nil)
    }
    
    
    //MARK: AddNewActivity
    /**
     Check if data that user added to add new activity is Vaild.
     
     - Parameter addActivityTableView: The add new activity Table View.
     
     - Returns: Tuple With - Bool true Data is vaild and with empty error message And false if data is not vaild with error message.
     */
    class func isUserAddNewActivityDataIsVaild(addActivityTableView : UITableView) -> (Bool , String , Activity?) {
        
        var vaildationMessage = ""
        var vaild = true
        var dataInputCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        
        // Name
        indexPath = IndexPath(row: 0, section: 0)
        dataInputCell = addActivityTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        guard let inputCell = dataInputCell  else {
            return (false, "" , nil)
        }
        
        let vaildateName = self.isActivityNameIsVaild(name: inputCell.inputValueTextField.text!)
        
        if vaildateName.0 == false {
            vaild = false
            vaildationMessage += "\n" + vaildateName.1
        }
        
        if vaild {
            let activity = self.initActivityModelFromInputesData(addActivityTableView: addActivityTableView)
            return (true , "" , activity)
        }
        
        return (false , vaildationMessage , nil)
    }
    
    class func initActivityModelFromInputesData (addActivityTableView : UITableView) -> Activity {
        
        let Name = self.getTextInputStringFromTextFieldAt(tableView: addActivityTableView, section: 0, row: 0)
        let type = self.getSelectedActivityTypeFrom(addActivityTableView: addActivityTableView)
        let startDate = self.getTextInputStringFromTextFieldAt(tableView: addActivityTableView, section: 2, row: 0)
        let startTime = self.getTextInputStringFromTextFieldAt(tableView: addActivityTableView, section: 2, row: 1)

        let activity = Activity()
        
        activity.initActivityWithInfo(name: Name, type: type, startDate: startDate, startTime: startTime)
        
        return activity
    }
    
    /**
     This function return the type of activity that user did choice to add new activity from the segment controller.
     
     - Parameter addActivityTableView: The add new activity Table View.
     
     - Returns: String  Type name.
     */
    
   class func getSelectedActivityTypeFrom(addActivityTableView : UITableView) -> String {
        
        let typeCellIndexPath = IndexPath(row: 0, section: 1)
        let typeCell = addActivityTableView.cellForRow(at: typeCellIndexPath) as! ActivityTypeTableViewCell
        let typeValueIndex = typeCell.activityTypeSegmentControl.selectedSegmentIndex
        let selectedTypeValue = ACTIVITESTAYPELIST[typeValueIndex]
        return selectedTypeValue
        
    }
    
    //MARK: - Genenral
    class func isUserFirstNameIsVaild (name : String) -> (Bool, String) {
        
        if name == "" {
            return (false , FIRSTNAMEREQUIREDMESSAGE)
        }
        else {
            return (true , "")
        }
    }
    
    class func isActivityNameIsVaild (name : String) -> (Bool, String) {
        
        if name == "" {
            return (false , ACTIVITYNAMEEQUIREDMESSAGE)
        }
        else {
            return (true , "")
        }
    }
    
    class func isEmailIsVaild (email : String) -> (Bool, String) {
        
        if email == "" {
            return (false , EMAILREQUIREDMESSAGE)
        }
        else  {
            
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let vailed = emailTest.evaluate(with: email)
            if vailed {
                return (true , "")
                
            }
            else
            {
                return (false , EMAILNOTVAILDMESSAGE)
            }
        }
    }
    
    class func isPasswordIsVaild (password : String) -> (Bool, String) {
        
        if password == "" {
            return (false , PASSWORDREQUIREDMESSAGE)
        }
        else {
            return (true , "")
        }
    }
    
    
    /**
     This function Help to get the value of textfield at cell.
     
     - Parameter tableView: The cell's table view.
     
     - Returns: String  TextField text value.
     */
    
    class func getTextInputStringFromTextFieldAt (tableView : UITableView, section : Int , row : Int) -> String {
        
        var registrationCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        
        indexPath = IndexPath(row: row, section: section)
        registrationCell = tableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        guard let cell = registrationCell  else {
            return ""
        }
        
        return cell.inputValueTextField.text!
        
    }
}
