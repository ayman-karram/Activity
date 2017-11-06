//
//  LoginViewController.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var loginTableView: UITableView!
    
    var fieldsTitlesList       = ["Email", "Password"]
    var fieldsPlaceHoldersList = ["your@email.com" , "Password"]
    
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
    class func instantiateFromStoryboard() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "Log in"
        loginTableView.register(UINib(nibName: "RegistrationInputTableViewCell", bundle: nil), forCellReuseIdentifier: "inputInfoCell")
        addTabGestureToTableView()
        addDoneNavigationBarItem()
    }
    
    func addTabGestureToTableView () {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector (self.dismissKeyboard))
        loginTableView.addGestureRecognizer(tapGesture)
    }
    
    func addDoneNavigationBarItem () {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneBarButtonItemClicked))
        self.navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    //MARK: - Actions Functions
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func doneBarButtonItemClicked (sender : Any) {
        
        let dataValidation = VaildationManager.isUserLoginDataIsVaild(loginTableView: self.loginTableView)
        if dataValidation.0 { // is vaild
            UserDefaultsManager.setUserDidLogin(login: true)
            HelperManager.makeMainTabbarAsRootViewControllerToWindow()
        }
        else                 // not vaild
        {
            let alert = AlertManager.getAlerWith(title: "Notes", message: dataValidation.1)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension LoginViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputInfoCell") as! RegistrationInputTableViewCell
        
        let  inputTitle = self.fieldsTitlesList[indexPath.row]
        let  inputPlaceHolder = self.fieldsPlaceHoldersList[indexPath.row]
        
        if indexPath.row == 1 {
            cell.inputValueTextField.isSecureTextEntry = true
        }
        cell.setUpCellWithInput(title: inputTitle, placeHolder: inputPlaceHolder)
        
        return cell
    }
}
