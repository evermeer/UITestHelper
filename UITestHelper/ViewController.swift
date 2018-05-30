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

        // Setting the accessibility identifiers on the elements
        theLabel ~~> AccessibilityIdentifier.HomeScreen.theLabel
        theTextField ~~> AccessibilityIdentifier.HomeScreen.theTextField
        theButton ~~> AccessibilityIdentifier.HomeScreen.theButton
        switch1 ~~> AccessibilityIdentifier.HomeScreen.switch1
        switch2 ~~> AccessibilityIdentifier.HomeScreen.switch2
        hideButton ~~> AccessibilityIdentifier.HomeScreen.hideButton
        showButton ~~> AccessibilityIdentifier.HomeScreen.showButton
    }

    @IBAction func showButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = false
    }
    @IBAction func hideButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = true
    }
}

