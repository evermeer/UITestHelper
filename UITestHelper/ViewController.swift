//
//  ViewController.swift
//  UITestHelper
//
//  Created by Edwin Vermeer on 03/02/2017.
//  Copyright © 2017 evict. All rights reserved.
//

import UIKit
import UITestHelper

class ViewController: UIViewController {

    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var theTextField: UITextField!
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // For if you want to react to parameters that are passed on from a UITest
        if isLaunchedWith(LaunchArguments.MockNetworkResponses) {
            
        }
        if isLaunchedWith("NoneEnumOption") {
            
        }

        
        theLabel.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.theLabel.rawValue
        theTextField.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.theTextField.rawValue
        theButton.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.theButton.rawValue
        switch1.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.switch1.rawValue
        switch2.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.switch2.rawValue
        hideButton.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.hideButton.rawValue
        showButton.accessibilityIdentifier = AccessibilityIdentifier.HomeScreen.showButton.rawValue
    }

    @IBAction func showButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = false
    }
    @IBAction func hideButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = true
    }
}

