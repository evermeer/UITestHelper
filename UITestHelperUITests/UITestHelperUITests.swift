//
//  UITestHelperUITests.swift
//  UITestHelperUITests
//
//  Created by Edwin Vermeer on 03/02/2017.
//  Copyright © 2017 evict. All rights reserved.
//

import XCTest
import UITestHelper

typealias HomeScreen = AccessibilityIdentifier.HomeScreen

class UITestHelperUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        self.tryLaunch([LaunchArguments.MockNetworkResponses])
        //self.tryLaunch(["NoneEnumOption"]) // For if you don't want an Enum that is both in you test target and application
        //self.tryLaunch() // For if you don't need any options at all
    }
    
    override func tearDown() {
        tryTearDown()
        super.tearDown()
    }
    
    func testAppWaitForElement() {
        XCTAssert(HomeScreen.theLabel.waitUntilExists().exists, "label should exist")
        HomeScreen.theLabel.waitUntilExistsAssert()
        group("Testing the switch") { activity in
            takeScreenshot(activity: activity, "First screenshot")
            app.buttons["Second"].waitUntilExists().tap()
            takeScreenshot()
            app.buttons["Third"].waitUntilExists().tap()
            takeScreenshot(groupName: "Screenshot group?")
            HomeScreen.theButton.waitUntilExists().tap()
            takeScreenshot("Last screenshot")
        }
    }

    func testAppTextEntry() {
        HomeScreen.theTextField.tapAndType("testing")
    }
    
    func testAppOneOfTheseShouldExist() {
        HomeScreen.theLabel.or(HomeScreen.theTextField).tap()
        HomeScreen.theLabel.orAssert(HomeScreen.theTextField)
    }
    
    func testAppConditionalCode() {
        // Only execute the closure if the element is there.
        HomeScreen.theButton.ifExists { $0.tap() } // The button exist, so we do tap it
        HomeScreen.hideButton.ifExists(2) { $0.tap() } // The button does not exist, so we don't tap it
        
        // Only execute the closure if the element is not there
        HomeScreen.hideButton.ifNotExist(2) {
            app.buttons["Third"].waitUntilExists().tap()
        }

        // Only execute the closure if the element is not there and then continue assuming it's there.
        HomeScreen.hideButton.ifNotExistwaitUntilExists(2) {
            HomeScreen.showButton.waitUntilExists().tap()
        }.tap()
        sleep(3)
    }
    
    func testAppSwitches() {
        HomeScreen.switch1.setSwitch(false)
        HomeScreen.switch2.setSwitch(false)
        HomeScreen.switch1.setSwitch(true)
        HomeScreen.switch1.setSwitch(false)
        HomeScreen.switch2.setSwitch(true)
    }

    func testEnumWithIdentifiersReusedForInteractingWithXCUIElement() {
        HomeScreen.showButton.tap()
        HomeScreen.hideButton.tap()
    }
}
