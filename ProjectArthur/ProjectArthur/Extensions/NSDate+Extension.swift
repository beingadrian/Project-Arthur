//
//  NSDate+Extension.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/14/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation

extension NSDate {
    
    func simpleTimeString() -> String? {
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        
        formatter.timeZone = NSTimeZone.localTimeZone()
        
        formatter.dateFormat = "hh:mm"
        
        return formatter.stringFromDate(self)
        
    }
    
}