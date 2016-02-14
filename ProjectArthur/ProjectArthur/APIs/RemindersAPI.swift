//
//  RemindersAPI.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import EventKit
import RxSwift

/**
 * All things related to the Reminders API.
 */
class RemindersAPI {
    
    enum Error: ErrorType {
        case RequestAccessError(error: NSError?)
        case RequestAccessNotGranted
        case NoRemindersFound
    }
    
    // MARK: - Properties
    
    let eventStore = EKEventStore()
    
    // MARK: - Authorization
    
    func requestAccessToReminders() -> Observable<Bool> {
        
        return Observable.create { observer in
            
            self.eventStore.requestAccessToEntityType(.Reminder) {
                (granted, error) in
                
                if let error = error {
                    observer.onError(Error.RequestAccessError(error: error))
                }
                
                if granted {
                    observer.onNext(granted)
                    observer.onCompleted()
                } else {
                    observer.onError(Error.RequestAccessNotGranted)
                }
                
            }
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Fetching reminders
    
    func fetchCompletedReminders(fromDate startDate: NSDate, toDate endDate: NSDate) -> Observable<[EKReminder]> {
        
        let predicate = eventStore.predicateForCompletedRemindersWithCompletionDateStarting(
            nil,
            ending: nil,
            calendars: nil)
        
        return Observable.create { observer in
         
            self.eventStore.fetchRemindersMatchingPredicate(predicate) {
                (reminders) in
                
                guard let completedReminders = reminders else {
                    return observer.onError(Error.NoRemindersFound)
                }

                let startDateInterval = startDate.timeIntervalSince1970
                let endDateInterval = endDate.timeIntervalSince1970
                let filteredCompletedReminders = completedReminders.filter { reminder in
                    if let creationDate = reminder.creationDate {
                        let creationDateInterval = creationDate.timeIntervalSince1970
                        return creationDateInterval >= startDateInterval && creationDateInterval < endDateInterval
                    } else {
                        return false
                    }
                }
                
                observer.onNext(filteredCompletedReminders)
                observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
    
    func fetchIncompletedReminders() -> Observable<[EKReminder]> {
        
        let predicate = eventStore.predicateForIncompleteRemindersWithDueDateStarting(
            nil,
            ending: nil,
            calendars: nil)
        
        return Observable.create { observer in
            
            self.eventStore.fetchRemindersMatchingPredicate(predicate) {
                reminders in
                
                guard let incompletedReminders = reminders else {
                    return observer.onError(Error.NoRemindersFound)
                }
                
                observer.onNext(incompletedReminders)
                observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
    
}