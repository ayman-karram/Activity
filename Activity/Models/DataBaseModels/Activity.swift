//
//  Activity.swift
//  Activity
//
//  Created by Ayman  on 11/6/17.
//  Copyright © 2017 Ayman . All rights reserved.
//

import Foundation
import RealmSwift

class Activity: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var type  = ""
    @objc dynamic var startDate  = ""
    @objc dynamic var startTime  = ""
    
    
    func initActivityWithInfo(name : String , type: String , startDate : String, startTime : String) {
        
        self.name = name
        self.type = type
        self.startDate  = startDate
        self.startTime  = startTime
        
    }
}
