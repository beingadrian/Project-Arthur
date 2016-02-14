//
//  RealmAPI.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import RxSwift
import HealthKit
import RealmSwift

class LoadingAPI {
    
    var disposeBag = DisposeBag()
    
    func createWalkCard() -> Observable<RealmCard> {
        
        let twelveHoursAgoInterval: NSTimeInterval = 60 * 60 * 9
        let now = NSDate()
        let twelveHoursAgo = NSDate(timeIntervalSinceNow: -twelveHoursAgoInterval)
        
        var stepCount: Int = 0
        
        let healthAPI = HealthKitAPI()
        return healthAPI.queryTotalStepCount(fromDate: twelveHoursAgo, toDate: now)
            .flatMap { steps -> Observable<Double> in
                stepCount = Int(steps)
                return healthAPI.queryTotalDistanceOnFoot(fromDate: twelveHoursAgo, toDate: now, unit: HKUnit.mileUnit())
            }
            .flatMap { distance -> Observable<RealmCard> in
                
                let card = RealmCard()
                let adventure = RealmAdventure()
                
                adventure.steps = stepCount
                adventure.distance = distance
                
                card.name = "Adventures"
                card.adventure = adventure
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(adventure)
                    realm.add(card, update: true)
                }
                
                return Observable.just(card)
            }
    }
    
    func createQuestCard() -> Observable<RealmCard> {
        
        let twelveHoursAgoInterval: NSTimeInterval = 60 * 60 * 9
        let now = NSDate()
        let twelveHoursAgo = NSDate(timeIntervalSinceNow: -twelveHoursAgoInterval)
        
        let remindersAPI = RemindersAPI()
        return remindersAPI.fetchCompletedReminders(fromDate: twelveHoursAgo, toDate: now)
            .flatMap { reminders -> Observable<RealmCard> in
                let card = RealmCard()
                card.name = "Quest card"
                
                let sliced = reminders.prefix(3)
                var quests: [RealmQuest] = []
                sliced.forEach { reminder in
                    let quest = RealmQuest()
                    quest.title = reminder.title
                    quests.append(quest)
                }
                
                card.quests.appendContentsOf(quests)
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(card, update: true)
                }
                
                return Observable.just(card)
                
            }
        
    }
    
    func createEventsCard() -> Observable<RealmCard> {
        
        let calendarAPI = CalendarAPI()
        return calendarAPI.fetchEventsForTonight(3)
            .flatMap { events -> Observable<RealmCard> in
                var realmEvents: [RealmEvent] = []
                events.forEach { event in
                    let realmEvent = RealmEvent()
                    realmEvent.title = event.title
                    realmEvents.append(realmEvent)
                }
                let card = RealmCard()
                card.name = "Events card"
                card.events.appendContentsOf(realmEvents)
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(card, update: true)
                }
                
                return Observable.just(card)
            }
        
    }
    
}

