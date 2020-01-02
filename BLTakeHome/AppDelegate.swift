//
//  AppDelegate.swift
//  BLTakeHome
//
//  Created by Matt Ao on 10/15/19.
//  Copyright © 2019 Betty Labs. All rights reserved.
//

import UIKit
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initSettings = [kOSSettingsKeyAutoPrompt: false]
        OneSignal.initWithLaunchOptions(
            launchOptions,
            appId: "d7d16830-f584-40a7-83c3-ed1eb2932538",
            handleNotificationAction: nil,
            settings: initSettings
        )
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
                
        return true
    }

    
}

