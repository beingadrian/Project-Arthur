//
//  RealmReportHelper.swift
//  ProjectArthur
//
//  Created by Jimmy Yue on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RealmSwift
import EventKit

class RealmReportHelper {
    
    let realm = try! Realm()
    
    // Always should be called before addReportToReportQueue
    func prepareForReportGeneration() {
        let newReport = RealmReport()
        try! realm.write {
            realm.add(newReport, update: true)
        }
    }
    
    func addCardToReport(card: RealmCard) {
        
        let saved = realm.objects(RealmReport)
        if saved.count == 0 {
            print("Please prepare for report generation before adding cards")
            return
        }
        
        let report = saved[0]
        
        try! realm.write {
            report.cards.append(card)
            realm.add(report, update: true)
        }
        
    }
    
    func getScript() -> String {
        let saved = realm.objects(RealmReport)
        if saved.count == 0 {
            print("Please prepare for report generation before adding cards")
            return ""
        }
        
        let report = saved[0]
        var script = ""
        
        for card in report.cards {
            switch card.name {
            case "Adventures":
                script.appendContentsOf("You have walked \(String(card.adventure!.steps)) steps, and you have traveled \(String(card.adventure!.distance)) miles.")
            
            case "Quests":
                let accomplishedQuests = card.quests
                if accomplishedQuests.count == 0 {
                    script.appendContentsOf("You have accomplished no quests today.")
                }
                else {
                    script.appendContentsOf("Today you have accomplished:")
                    for quest in accomplishedQuests {
                        script.appendContentsOf("\(quest.title). ")
                    }
                }
            
            case "Events":
                let upcomingEvents = card.events
                if upcomingEvents.count == 0 {
                    script.appendContentsOf("You have no upcoming events.")
                }
                else {
                    script.appendContentsOf("Your upcoming events are:")
                    for event in upcomingEvents {
                        script.appendContentsOf("\(event.title), at \(event.date). ")
                    }
                }
                
            default:
                print("Unhandled case")
                return "Critical failure"
                
            }
        }
        
        return script
        
    }
}
