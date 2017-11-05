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
    
    class func isUserRegistarionDataIsVaild(registrationTableView : UITableView) -> (Bool , String , User?) {
        
        var vaildationMessage = ""
        var vaild = true
        var registrationCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        
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
        
        let vaildateEmail = self.isEmailIsVaild(email : registrationCell!.inputValueTextField.text!)
        
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
        
        if vaild {
            let user = self.initUserModelFromInputesData(registrationTableView: registrationTableView)
            return (true , "" , user)
        }
        
        return (false , vaildationMessage , nil)
    }
    
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
    
    
    class func isUserFirstNameIsVaild (name : String) -> (Bool, String) {
        
        if name == "" {
            return (false , FIRSTNAMEREQUIREDMESSAGE)
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
    
    
    class func initUserModelFromInputesData (registrationTableView : UITableView) -> User {
        
        let fistName = self.getTextInputStringFromTextFieldAt(registrationTableView: registrationTableView, section: 0, row: 0)
        let lastName = self.getTextInputStringFromTextFieldAt(registrationTableView: registrationTableView, section: 0, row: 1)
        let email = self.getTextInputStringFromTextFieldAt(registrationTableView: registrationTableView, section: 1, row: 0)
        let password = self.getTextInputStringFromTextFieldAt(registrationTableView: registrationTableView, section: 1, row: 1)
        let birthday = self.getTextInputStringFromTextFieldAt(registrationTableView: registrationTableView, section: 1, row: 2)
        
        let user = User()
        user.initUserWithInfo(firstName: fistName, lastName: lastName, email: email, birthday: birthday, password: password)
        
        return user
        
    }
    
    class func getTextInputStringFromTextFieldAt (registrationTableView : UITableView, section : Int , row : Int) -> String {
        
        var registrationCell : RegistrationInputTableViewCell?
        var indexPath : IndexPath?
        
        indexPath = IndexPath(row: row, section: section)
        registrationCell = registrationTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
        
        guard let cell = registrationCell  else {
            return ""
        }
        
        return cell.inputValueTextField.text!
        
    }
}
