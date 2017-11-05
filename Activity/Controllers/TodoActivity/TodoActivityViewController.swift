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
    
    //MARK: - Helper Functions
    func initiateUIComponentsView () {
        self.title = "ToDo"
        addActivityNavigationBarItem()
    }
    
    func addActivityNavigationBarItem () {
        
        let JoinButton = UIBarButtonItem(barButtonSystemItem:.add , target: self, action: #selector (self.addNewActivityBarButtonItemClicked(sender:)))
        self.navigationItem.setRightBarButton(JoinButton, animated: true)
    }

    //MARK: -  Actions
    @objc func addNewActivityBarButtonItemClicked (sender : Any) {
        
    }

}
