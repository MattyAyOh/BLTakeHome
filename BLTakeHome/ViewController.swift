//
//  ViewController.swift
//  BLTakeHome
//
//  Created by Matt Ao on 10/15/19.
//  Copyright © 2019 Betty Labs. All rights reserved.
//

import UIKit
import PushNotifications

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Channel switches
    @IBOutlet weak var gameChannelSwitch: UISwitch!
    @IBOutlet weak var globalSwitch: UISwitch!
    
    // Text fields
    @IBOutlet weak var channelNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    // Send Button
    @IBOutlet weak var sendPushButton: UIButton!
    
    
    let GLOBAL_CHANNEL = "Global";
    let GAME_XYZ_CHANNEL = "Game_XYZ";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelNameTextField.delegate = self;
        titleTextField.delegate = self;
        bodyTextField.delegate = self;
        try? PushNotifications.shared.addDeviceInterest(interest: GLOBAL_CHANNEL)
        try? PushNotifications.shared.addDeviceInterest(interest: GAME_XYZ_CHANNEL)
    }
    
    func toggleDeviceInterest(channelName: String, toggle: Bool) {
        if (toggle){
            try? PushNotifications.shared.addDeviceInterest(interest: channelName);
        } else {
            try? PushNotifications.shared.removeDeviceInterest(interest: channelName);
        }
    }
    
    @IBAction func globalSwitchChanged(_ sender: UISwitch) {
        toggleDeviceInterest(channelName: GLOBAL_CHANNEL, toggle: sender.isOn)
    }
    
    @IBAction func gameXyzSwitchChanged(_ sender: UISwitch) {
        toggleDeviceInterest(channelName: GAME_XYZ_CHANNEL, toggle: sender.isOn)
    }
    
    @IBAction func sendPushNotificationPressed(_ sender: Any) {
        guard let channelNameId = channelNameTextField.text else {
            return;
        }
        if (channelNameId.count == 0) {
            let alert = UIAlertController(
                title: "No Channel Specified",
                message: "You must type in a channel before pressing send",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))

            self.present(alert, animated: true)
            return;
        }
        guard let titleText = titleTextField.text else {
            return;
        }
        guard let bodyText = bodyTextField.text else {
            return;
        }
        APIClient.shared.data(
            .sendPushToChannel(
                channelId: channelNameId,
                title: titleText,
                body: bodyText
            )
        )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /* ------------------Unused-------------------- */
    
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBAction func sendToUserToggled(_ sender: UISwitch) {
        channelNameLabel.isEnabled = !sender.isOn
    }
}

