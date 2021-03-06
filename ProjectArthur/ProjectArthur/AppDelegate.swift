//
//  AppDelegate.swift
//  ProjectArthur
//
//  Created by Adrian Wisaksana on 2/13/16.
//  Copyright © 2016 TheInitiative. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // MARK: - Push notifications
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        // MARK: - Beacons
        
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        
        let beaconRegion = CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
            major: 7348,
            minor: 43372,
            identifier: "Home")
        self.beaconManager.startMonitoringForRegion(beaconRegion)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: ESTBeaconManagerDelegate {
    
    func beaconManager(manager: AnyObject!, didEnterRegion region: CLBeaconRegion!) {
        
        print("Did enter region")
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isHome")
        
        NotificationAPI().notifyUser()
        
    }
    
    func beaconManager(manager: AnyObject!, didExitRegion region: CLBeaconRegion!) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isHome")
        
        print("Did exit region")
        
    }
    
    func beaconManager(manager: AnyObject!, monitoringDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        
        print("Failed monitoring for region: \(error)")
        
    }
    
    func beaconManager(manager: AnyObject!, didFailWithError error: NSError!) {
        
        print("Beacon manager error: \(error)")
        
    }
    
}

