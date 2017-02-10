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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if isLaunchedWith(LaunchArguments.MockNetworkResponses) {
            
        }
    }


    @IBAction func showButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = false
    }
    @IBAction func hideButtonTouchUpInside(_ sender: Any) {
        hideButton.isHidden = true
    }
}

