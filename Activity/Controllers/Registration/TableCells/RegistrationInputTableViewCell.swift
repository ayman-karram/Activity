//
//  RegistrationInputTableViewCell.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit

class RegistrationInputTableViewCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputValueTextField: UITextField!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Helper Functions
    func setUpCellWithInput (title : String , placeHolder : String) {
        self.inputTitleLabel.text = title
        self.inputValueTextField.placeholder = placeHolder
    }
    
}
