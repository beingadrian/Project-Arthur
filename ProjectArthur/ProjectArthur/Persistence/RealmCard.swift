//
//  RealmCard.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCard: Object {
    dynamic var name = ""
    dynamic var enabled = true
    dynamic var content = ""
    dynamic var values = [String:AnyObject]() // [String:AnyObject]
    dynamic var settings = [String:AnyObject]() // [String:AnyObject]
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
