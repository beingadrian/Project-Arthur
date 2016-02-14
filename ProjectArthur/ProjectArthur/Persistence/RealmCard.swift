//
//  RealmCard.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RealmSwift
import EventKit

class RealmCard: Object {
    dynamic var name = ""
    dynamic var enabled = true
    dynamic var content = ""
    dynamic var adventure: RealmAdventure?
    let quests = List<RealmQuest>()
    let events = List<RealmEvent>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
