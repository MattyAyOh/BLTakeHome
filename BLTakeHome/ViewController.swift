//
//  ViewController.swift
//  BLTakeHome
//
//  Created by Matt Ao on 10/15/19.
//  Copyright © 2019 Betty Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelNameTextFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sendToUserToggled(_ sender: UISwitch) {
        channelNameLabel.isEnabled = !sender.isOn
        channelNameTextFIeld.isEnabled = !sender.isOn
    }
    
}

