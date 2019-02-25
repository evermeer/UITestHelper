//
//  XCTestCase+helpers.swift
//
//  Created by Edwin Vermeer on 29/01/2017.
//  Copyright © 2017 EVICT BV. All rights reserved.
//

import XCTest


extension String : RawRepresentable {
    public init?(rawValue: String) {
        self = rawValue
    }
    public var rawValue: String { get { return self} }
}

/**
 Helper extension for various function to help with writing UI tests.
 */
var EVReflectableStatusesObjectKey = "XCUIApplication"
@available(iOS 9.0, *)
public extension XCTestCase {
    
    /**
     Always have an app property available without the need to start a XCUIApplication
     */
    var app: XCUIApplication {
        get {
            var a: XCUIApplication? = objc_getAssociatedObject(self, &EVReflectableStatusesObjectKey) as? XCUIApplication
            if let a = a {
                return a
            } else {
                a = XCUIApplication()
                objc_setAssociatedObject(self, &EVReflectableStatusesObjectKey, a, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return a!
            }
        }
        set {
            objc_setAssociatedObject(self, &EVReflectableStatusesObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    /**
     Try to force launch the application. This structure tries to ovecome the issues described at https://www.openradar.me/25548393 and https://forums.developer.apple.com/thread/15780
     
     - parameter arguments: An array of RawRepresentable iterms that will be passed on as arguments
     - parameter timeout: The retry counter for trying to startup the app (Default is 10)
     - parameter wait: The number of seconds to wait. Slower test machines might require a longer wait
     */
    func tryLaunch<T>(_ arguments: [T], _ counter: Int = 10, _ wait: UInt32 = 2) where T: RawRepresentable {
        sleep(wait)
        XCUIApplication().terminate()
        sleep(wait)
        
        app = XCUIApplication()
        app.launchArguments = (arguments.map { $0.rawValue as! String })
        app.launch()
        sleep(wait)
        if !app.exists && counter > 0 {
            tryLaunch(arguments, counter - 1)
        }
    }

    /**
     Try to force closing the application
     
     - parameter wait: The number of seconds to wait. Slower test machines might require a longer wait
     */
    func tryTearDown(_ wait: UInt32 = 2) {
        super.tearDown()
        sleep(wait)
        XCUIApplication().terminate()
        sleep(wait)
    }
    
    /**
     Try to force launch the application. This structure tries to ovecome the issues described at https://www.openradar.me/25548393 and https://forums.developer.apple.com/thread/15780
     
     - parameter timeout: The retry counter for trying to startup the app (Default is 10)
     */
    func tryLaunch(_ counter: Int = 10) {
        sleep(3)
        XCUIApplication().terminate()
        sleep(3)
        
        app = XCUIApplication()
        app.launch()
        sleep(3)
        if !app.exists && counter > 0 {
            tryLaunch(counter - 1)
        }
    }

    
    /**
     Are the tests run in the simulator or on a device.
     
     :return: True if the tests run in the simmulator
     */
    func isSimulator() -> Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    /**
     Are the tests run on a tablet (iPad).
     
     :return: True if the tests run on an iPad
     */
    func isTablet() -> Bool {
        return UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone
    }

    /**
     Take a screenshot and attach it to the specified or a new activity
     */
    func takeScreenshot(activity: XCTActivity, _ name: String = "Screenshot") {
        let screen: XCUIScreen = XCUIScreen.main
        let fullscreenshot: XCUIScreenshot = screen.screenshot()
        let fullScreenshotAttachment: XCTAttachment = XCTAttachment(screenshot: fullscreenshot)
        fullScreenshotAttachment.name = name
        fullScreenshotAttachment.lifetime = .keepAlways
        activity.add(fullScreenshotAttachment)
    }
    
    /**
     Take a screenshot and attach it to the specified or a new activity
     */
    func takeScreenshot(groupName: String = "--- Screenshot ---", _ name: String = "Screenshot") {
        group(groupName) { (activity) in
            takeScreenshot(activity: activity, name)
        }
    }
    
    /**
     A simple wrapper around creating an activity for grouping your test statements.
     */
    func group(_ text: String = "Group", closure: (_ activity: XCTActivity)-> ()) {
        XCTContext.runActivity(named: text) { activity in
            closure(activity)
        }
    }
}

public func queryForIdentifier(_ identifier: String) -> XCUIElementQuery {
    return XCUIApplication().descendants(matching: .any).matching(identifier: identifier)
}
