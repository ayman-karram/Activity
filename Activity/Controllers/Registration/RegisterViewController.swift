//
//  RegisterViewController.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit

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
        addTabGestureToTableView()
        addJoinNavigationBarItem()
    }
    
    func addTabGestureToTableView () {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector (self.dismissKeyboard))
        registrationTableView.addGestureRecognizer(tapGesture)
    }
    
    func addJoinNavigationBarItem () {
        let JoinButton = UIBarButtonItem(title: "JOIN" ,style: .plain, target: self, action: #selector (self.doneBarButtonItemClicked(sender:)))
        self.navigationItem.setRightBarButton(JoinButton, animated: true)
    }
    
    //MARK: - Actions Functions
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func doneBarButtonItemClicked (sender : Any) {
        
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
            break
        default:
            break
        }
        
        cell.setUpCellWithInput(title: inputTitle, placeHolder: inputPlaceHolder)
        
        return cell
    }
}
