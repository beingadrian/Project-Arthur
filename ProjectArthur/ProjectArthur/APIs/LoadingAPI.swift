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
    
    static var disposeBag = DisposeBag()
    
    static func loadHealthData() {
        
        let twelveHoursAgoInterval: NSTimeInterval = 60 * 60 * 9
        let now = NSDate()
        let twelveHoursAgo = NSDate(timeIntervalSinceNow: -twelveHoursAgoInterval)
        
        let healthAPI = HealthKitAPI()
        healthAPI.queryTotalStepCount(fromDate: twelveHoursAgo, toDate: now)
            .subscribeNext { steps in
                
                
            }
            .addDisposableTo(disposeBag)
        
        healthAPI.queryTotalDistanceOnFoot(fromDate: twelveHoursAgo, toDate: now, unit: HKUnit.mileUnit())
            .subscribeNext { distance in
                
            }
            .addDisposableTo(disposeBag)
        
    }
    
}

