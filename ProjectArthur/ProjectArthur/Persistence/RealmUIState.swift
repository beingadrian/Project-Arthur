//
//  RealmUIState.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUIState: Object {
    dynamic var name = ""
    dynamic var state = [] // [String:AnyObject]
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
