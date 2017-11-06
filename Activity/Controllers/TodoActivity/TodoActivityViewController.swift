//
//  TodoActivityViewController.swift
//  Activity
//
//  Created by Ayman  on 11/5/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit

class TodoActivityViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var toDoTableView: UITableView!
    var userActivites : [String : [Activity]]? // String key is activity type
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateUIComponentsView()
        getUserActivites()
        addNotificationsObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "ToDo"
        addActivityNavigationBarItem()
    }
    
    func pushAddNewActivityVC () {
        
        let addNewActivityNC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewActivityNC") as! UINavigationController
        self.present(addNewActivityNC, animated: true, completion: nil)
    }
    
    func addActivityNavigationBarItem () {
        
        let JoinButton = UIBarButtonItem(barButtonSystemItem:.add , target: self, action: #selector (self.addNewActivityBarButtonItemClicked(sender:)))
        self.navigationItem.setRightBarButton(JoinButton, animated: true)
    }
   
    func getUserActivites () {
        self.userActivites = DataBaseManager.sharedInstance.getLoggedInUserActivites()
        self.toDoTableView.reloadData()
    }
    
    //MARK: - Notifications Center
    func addNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDidAddNewActivity(notification:)), name: NSNotification.Name(rawValue: ADDEDNEWACTIVITYNOTIFICATIONNAME), object: nil)
    }

    @objc func userDidAddNewActivity (notification : NSNotification) {
        self.getUserActivites()
    }
    
    //MARK: -  Actions
    @objc func addNewActivityBarButtonItemClicked (sender : Any) {
        pushAddNewActivityVC()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TodoActivityViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        guard let _ = self.userActivites else {
            return 0
        }
        
        return ACTIVITESTAYPELIST.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let activites = self.userActivites else {
            return 0
        }
        
        let selectedActivityType = ACTIVITESTAYPELIST[section]

        return activites[selectedActivityType]!.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoCell")
        let selectedActivityType = ACTIVITESTAYPELIST[indexPath.section]
        let selectedActivity = self.userActivites![selectedActivityType]![indexPath.row]
        
        cell.textLabel?.text = selectedActivity.name
        
        return cell
    }
    
    func  tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let selectedActivityType = ACTIVITESTAYPELIST[section]
        return selectedActivityType
    }

}
