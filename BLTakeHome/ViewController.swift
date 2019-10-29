//
//  ViewController.swift
//  BLTakeHome
//
//  Created by Matt Ao on 10/15/19.
//  Copyright © 2019 Betty Labs. All rights reserved.
//

import UIKit
import PushNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelNameTextFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? PushNotifications.shared.addDeviceInterest(interest: "Global-YOURNAME")
        try? PushNotifications.shared.addDeviceInterest(interest: "Game_XYZ-YOURNAME")
    }
    
    @IBAction func sendPushNotificationPressed(_ sender: Any) {
        APIClient.shared.data(.exampleSendPushNotification(channelId: nil, userId: nil, title: "MISSING", body: "MISSING"))
    }
    
}

