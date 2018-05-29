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

    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // For if you want to react to parameters that are passed on from a UITest
        if isLaunchedWith(LaunchArguments.MockNetworkResponses) {
            
        }
        if isLaunchedWith("NoneEnumOption") {
            
        }

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

