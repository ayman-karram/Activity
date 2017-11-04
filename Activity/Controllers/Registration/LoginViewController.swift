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
    @IBOutlet weak var registrationTableView: UITableView!
    
    var fieldsTitlesList       = ["Email", "Password", "Birthdate"]
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Instantiation
    class func instantiateFromStoryboard() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "Log in"
        registrationTableView.register(UINib(nibName: "RegistrationInputTableViewCell", bundle: nil), forCellReuseIdentifier: "inputInfoCell")
        addTabGestureToTableView()
        addDoneNavigationBarItem()
    }
    
    func addTabGestureToTableView () {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector (self.dismissKeyboard))
        registrationTableView.addGestureRecognizer(tapGesture)
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
        
        cell.setUpCellWithInput(title: inputTitle, placeHolder: inputPlaceHolder)
        
        return cell
    }
}
