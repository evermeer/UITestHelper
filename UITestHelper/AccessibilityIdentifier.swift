//
//  AccessibilityIdentifier.swift
//  UITestHelperApp
//
//  Created by Maljaars, Samuel on 29/05/2018.
//  Copyright © 2018 evict. All rights reserved.
//

import Foundation

//Enum is added to both UITestHelperApp and UITestHelperUITests targets
enum AccessibilityIdentifier {
    enum HomeScreen: String {
        case theLabel
        case theTextField
        case theButton
        case switch1
        case switch2
        case showButton
        case hideButton
    }
}
