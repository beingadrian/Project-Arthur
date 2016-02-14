//
//  CalendarAPI.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import EventKit
import RxSwift


class CalendarAPI {
    
    enum Error: ErrorType {
        case DateError
    }
    
    // MARK: - Properties
    
    private let eventStore = EKEventStore()
    
    // MARK: - Event fetching
    
    func fetchEventsForTonight(eventCount: Int) -> Observable<[EKEvent]> {
        
        let startOfDay = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        guard let endOfDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions()) else {
            return Observable.error(Error.DateError)
        }
        
        let predicate = self.eventStore.predicateForEventsWithStartDate(NSDate(), endDate: endOfDay, calendars: nil)
        
        let events = self.eventStore.eventsMatchingPredicate(predicate)
        
        return Observable.create { observer in
            
            observer.onNext(events)
            
            return NopDisposable.instance
        }
        
    }
    
}