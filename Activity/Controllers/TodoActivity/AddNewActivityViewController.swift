//
//  AddNewActivityViewController.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit
import DatePickerDialog

class AddNewActivityViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var addNewActivityTableView: UITableView!
    @IBOutlet weak var addActivityNavigationBar: UINavigationBar!
    
    var fieldsTitlesList       = ["Activity Name", "Start Date", "Start Time"]
    var fieldsPlaceHoldersList = ["Name" , "Date" , "Time" ]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Instantiation
    class func instantiateFromStoryboard() -> AddNewActivityViewController {
        let storyboard = UIStoryboard(name: "ToDoActivities", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddNewActivityViewController") as! AddNewActivityViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "Add Activity"
        setTableViewCellsRegister()
        addDoneNavigationBarItem()
        addCancelNavigationBarItem()
    }
    
    func setTableViewCellsRegister() {
        
        addNewActivityTableView.register(UINib(nibName: "RegistrationInputTableViewCell", bundle: nil), forCellReuseIdentifier: "inputInfoCell")
        addNewActivityTableView.register(UINib(nibName: "ActivityTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "typeCell")
    }
    
    func addDoneNavigationBarItem () {
        
        let doneButton = UIBarButtonItem(barButtonSystemItem:.done , target: self, action: #selector (self.doneBarButtonItemClicked(sender:)))
        self.navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    func addCancelNavigationBarItem () {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem:.cancel , target: self, action: #selector (self.cancelBarButtonItemClicked(sender:)))
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
    }
    
    func showDatePickerView () {
        
        DatePickerDialog().show("Activity Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate:Date() as Date, datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = APPDATEFORMATE
                
                var registrationCell : RegistrationInputTableViewCell?
                var indexPath : IndexPath?
                
                indexPath = IndexPath(row: 0, section: 2)
                registrationCell = self.addNewActivityTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
                registrationCell?.inputValueTextField.text = formatter.string(from: dt)
            }
        }
    }
    
    func showTimePickerView () {
        
        DatePickerDialog().show("Activity Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate:Date() as Date, datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = APPTIMEFORMATE
                
                var registrationCell : RegistrationInputTableViewCell?
                var indexPath : IndexPath?
                
                indexPath = IndexPath(row: 1, section: 2)
                registrationCell = self.addNewActivityTableView.cellForRow(at: indexPath!) as? RegistrationInputTableViewCell
                registrationCell?.inputValueTextField.text = formatter.string(from: dt)
            }
        }
    }
    
    func showAddedActivitySuccessAlert () {
        
        let alert = AlertManager.getAlerWithOutActions(title: SCUESS, message: ADDACTIVITYSUCCESSMESSAGE)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAddedActivityFailAlert () {
        
        let alert = AlertManager.getAlerWithOutActions(title: FAIL, message: ADDACTIVITYFAILESSAGE)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -  Actions
    @objc func doneBarButtonItemClicked (sender : Any) {
        
        let validation = VaildationManager.isUserAddNewActivityDataIsVaild(addActivityTableView: self.addNewActivityTableView)
        
        if validation.0 {
            let activityModel = validation.2
            let addedResult = DataBaseManager.sharedInstance.addActivityToCurrentLoggedUserWith(activity: activityModel!)
            
            if addedResult
            {
                self.showAddedActivitySuccessAlert()
            }
            else
            {
                self.showAddedActivityFailAlert()
            }
        }
        else
        {
            let alert = AlertManager.getAlerWithOkButton(title: "Notes", message: validation.1)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func cancelBarButtonItemClicked (sender : Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AddNewActivityViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1 // name
        case 1:
            return 1 // type
        case 2:
            return 2 // date and time
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputInfoCell") as! RegistrationInputTableViewCell
        
        var inputTitle = ""
        var inputPlaceHolder = ""
        switch indexPath.section {
        case 0: // Name
            inputTitle = self.fieldsTitlesList[indexPath.row]
            inputPlaceHolder = self.fieldsPlaceHoldersList[indexPath.row]
            break
        case 1: // type
            let TypeCell = tableView.dequeueReusableCell(withIdentifier: "typeCell") as! ActivityTypeTableViewCell
            return TypeCell
            
        case 2: // Date and Time
            inputTitle = self.fieldsTitlesList[indexPath.row + 1]
            inputPlaceHolder = self.fieldsPlaceHoldersList[indexPath.row + 1]
            cell.inputValueTextField.isEnabled = false
        default:
            break
        }
        
        cell.setUpCellWithInput(title: inputTitle, placeHolder: inputPlaceHolder)
        
        return cell
    }
    
    func  tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Type"
        case 2:
            return "Date and Time"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 { // Date
            self.showDatePickerView()
        } else if indexPath.section == 2 && indexPath.row == 1 { // Time
            self.showTimePickerView()
        }
    }
}

