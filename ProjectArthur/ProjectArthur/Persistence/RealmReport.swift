//
//  RealmReport.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RealmSwift

class RealmReport: Object {
    dynamic var id = 0
    dynamic var script = ""
    let cards = List<RealmCard>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
