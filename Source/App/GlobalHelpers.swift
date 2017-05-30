//
//  GlobalHelpers.swift
//
//  Created by Edwin Vermeer on 29/01/2017.
//  Copyright © 2017 EVICT BV. All rights reserved.
//

/**
 Test if the app is launche with a specific parameter.
 
 :return: True if the app was started with the setting parameter
 */
public func isLaunchedWith<T>(_ setting: T) -> Bool where T: RawRepresentable {
    return ProcessInfo.processInfo.arguments.contains(setting.rawValue as! String)
}

/**
 Test if the app is launche with a specific parameter.
 
 :return: True if the app was started with the setting parameter
 */
public func isLaunchedWith(_ setting: String) -> Bool {
    return ProcessInfo.processInfo.arguments.contains(setting)
}

