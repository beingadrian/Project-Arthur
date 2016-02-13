//
//  HealthKitAPI.swift
//  project-arthur
//
//  Created by Adrian Wisaksana on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import HealthKit
import RxSwift

/**
 * Handles everything relatd to HealthKit.
 */
class HealthKitAPI {
    
    // MARK: - Errors
    
    enum Error: ErrorType {
        case HealthStoreNotAvailable
        case TypeNotAvailable(type: ReadType)
        case FailedToGetAuthorization(error: NSError?)
        case UnexpectedError(error: NSError?)
        case NoResultForQuery
        case NoSumQuantityForQuery
    }
    
    enum ReadType {
        case Steps
        case DistanceOnFoot
        
        var type: HKQuantityType? {
            switch self {
            case .Steps:
                return HKQuantityType.quantityTypeForIdentifier(
                    HKQuantityTypeIdentifierStepCount)
            case .DistanceOnFoot:
                return HKQuantityType.quantityTypeForIdentifier(
                    HKQuantityTypeIdentifierDistanceWalkingRunning)
            }
        }
    }
    
    // MARK: - Properties
    
    private var healthStore: HKHealthStore?
    
    // MARK: - Initialization
    
    init() {
        
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        }
        
    }
    
    // MARK: - Request permissions
    
    func requestHealthKitPermissions() -> Observable<Bool> {
        
        guard let stepsType = ReadType.Steps.type else {
            return Observable.error(
                Error.TypeNotAvailable(type: .Steps))
        }
        
        guard let distanceOnFootType = ReadType.DistanceOnFoot.type else {
            return Observable.error(
                Error.TypeNotAvailable(type: .DistanceOnFoot))
        }
        
        let dataTypesToRead = Set<HKQuantityType>(arrayLiteral: stepsType, distanceOnFootType)
        
        guard let healthStore = self.healthStore else {
            return Observable.error(Error.HealthStoreNotAvailable)
        }
        
        return Observable.create { observer in
            healthStore.requestAuthorizationToShareTypes(
                nil,
                readTypes: dataTypesToRead)
                { (success, error) in
                    if let error = error {
                        observer.onError(error)
                    }
                    
                    if !success {
                        observer.onError(Error.FailedToGetAuthorization(error: error))
                    }
                    
                    observer.onNext(success)
                    observer.onCompleted()
            }
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Helper methods
    
    private func createPredicate(from startDate: NSDate, to endDate: NSDate) -> NSPredicate {
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(
            startDate,
            endDate: endDate,
            options: .None)
        
        return predicate
        
    }
    
    private func createStatisticsQuery(forQuantityType quantityType: HKQuantityType, predicate: NSPredicate, unit: HKUnit) -> Observable<Double> {
        
        guard let healthStore = self.healthStore else {
            return Observable.error(Error.HealthStoreNotAvailable)
        }
        
        return Observable.create { observer in
            
            let queryOptions: HKStatisticsOptions = [.CumulativeSum]
            
            let query = HKStatisticsQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: queryOptions) {
                    (query, result, error) in
                    
                    if let error = error {
                        return observer.onError(
                            Error.UnexpectedError(error: error))
                    }
                    
                    guard let result = result else {
                        return observer.onError(Error.NoResultForQuery)
                    }
                    
                    guard let sumQuantity = result.sumQuantity() else { return observer.onError(
                        Error.NoSumQuantityForQuery)
                    }
                    
                    let value = sumQuantity.doubleValueForUnit(unit)
                    observer.onNext(value)
                    observer.onCompleted()
            }
            
            healthStore.executeQuery(query)
            
            return NopDisposable.instance
        }
        
    }
    
    // MARK: - Health queries
    
    func queryTotalStepCount(fromDate startDate: NSDate, toDate endDate: NSDate) -> Observable<Double> {
        
        let predicate = createPredicate(from: startDate, to: endDate)
        
        guard let stepsType = ReadType.Steps.type else {
            return Observable.error(
                Error.TypeNotAvailable(type: .Steps))
        }
        
        return createStatisticsQuery(forQuantityType: stepsType, predicate: predicate, unit: HKUnit.countUnit())
        
    }
    
    func queryTotalDistanceOnFoot(fromDate startDate: NSDate, toDate endDate: NSDate, unit: HKUnit) -> Observable<Double> {
        
        let predicate = createPredicate(from: startDate, to: endDate)
        
        guard let distanceOnFootType = ReadType.DistanceOnFoot.type else {
            return Observable.error(
                Error.TypeNotAvailable(type: .DistanceOnFoot))
        }
        
        return createStatisticsQuery(forQuantityType: distanceOnFootType, predicate: predicate, unit: unit)
        
    }
    
}
