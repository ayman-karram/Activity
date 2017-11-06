//
//  ActivityTypeTableViewCell.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import UIKit

class ActivityTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var activityTypeSegmentControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
