//
//  PushNotificationsAPI.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import Foundation
import NotificationCenter
import UIKit


class NotificationAPI {
    
    // MARK: - Properties
    
    let greetings = [
        "Welcome home",
        "Welcome back",
        "Good to see you again",
        "Hello again"
    ]
    
    // MARK: - Methods 
    
    func notifyUser() {
        
        let number = UInt32(greetings.count-1)
        let randomNumber = Int(arc4random_uniform(number))
        let randomGreeting = greetings[randomNumber]
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate()
        notification.alertTitle = "Arthur"
        notification.alertBody = "\(randomGreeting), Adrian. Shall I read today's report?"
        notification.alertAction = "Read"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}