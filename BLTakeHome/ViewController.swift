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
        try? PushNotifications.shared.addDeviceInterest(interest: "Global")
        try? PushNotifications.shared.addDeviceInterest(interest: "Game_XYZ")
    }

    @IBAction func sendToUserToggled(_ sender: UISwitch) {
        channelNameLabel.isEnabled = !sender.isOn
        channelNameTextFIeld.isEnabled = !sender.isOn
    }
    
    
    @IBAction func sendPushNotificationPressed(_ sender: Any) {
        APIClient.shared.data(.exampleSendPushNotification(channelId: nil, userId: nil, title: "MISSING", body: "MISSING"))
    }
    
}

