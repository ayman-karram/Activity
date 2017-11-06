//
//  AlertManager.swift
//  Activity
//
//  Created by Ayman  on 11/4/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    class func getAlerWithOkButton(title : String , message : String) -> UIAlertController {
        let aler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        aler.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return aler
    }
    
    class func getAlerWithOutActions(title : String , message : String) -> UIAlertController {
        let aler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return aler
    }
}
