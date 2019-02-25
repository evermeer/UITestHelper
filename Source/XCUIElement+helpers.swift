//
//  XCUIElement+helpers.swift
//
//  Created by Edwin Vermeer on 29/01/2017.
//  Copyright © 2017 EVICT BV. All rights reserved.
//

import XCTest


open class DummyUITestHelper {
    
}

/**
 Helper extension for performing functions on an element
 */
@available(iOS 9.0, *)
public extension XCUIElement {
    
    /**
     Perform this function on an element if you want to wait until it's available.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element iteself
     */
    @discardableResult
    func waitUntilExists(_ timeout: TimeInterval = 10) -> XCUIElement {
        if self.exists {
            return self
        }
        let test = XCTestCase()
        test.continueAfterFailure = true
        let predicate = NSPredicate(format: "exists == true")
        let exp = test.expectation(for: predicate, evaluatedWith: self, handler: nil)
        XCTWaiter().wait(for: [exp], timeout: timeout)
        return self
    }
    
    /**
     Perform this function on an element if you want to wait until it's available. And make an assertion if it really .exists
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element iteself
     */
    @discardableResult
    func waitUntilExistsAssert(_ timeout: TimeInterval = 10) -> XCUIElement {
        let r = waitUntilExists(timeout)
        XCTAssert(r.exists, "Element should exist: \(r)")
        return r
    }
    
    /**
     Perform this function on an element if you want to wait until it or an other specific element is available.
     
     - parameter element: The second element where we want to wait for
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element that was found. (or itself if it was not found)
     */
    @discardableResult
    func or(_ element: XCUIElement, _ timeout: Int = 10) -> XCUIElement {
        for _ in 1...timeout {
            if self.exists {
                return self
            }
            if element.exists {
                return element
            }
            // or should we just do a sleep(1) ?
            let exists = NSPredicate(format: "exists == 1")
            let test = XCTestCase()
            test.expectation(for: exists, evaluatedWith: self, handler: nil)
            test.waitForExpectations(timeout: TimeInterval(1), handler: nil)
            
        }
        if self.exists {
            return self
        }
        if element.exists {
            return element
        }
        return self
    }
    
    /**
     Perform this function on an element if you want to wait until it or an other specific element is available. Perform an assert if none of these elements where available.
     
     - parameter element: The second element where we want to wait for
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element that was found. (or itself if it was not found)
     */
    @discardableResult
    func orAssert(_ element: XCUIElement, _ timeout: Int = 10) -> XCUIElement {
        let r = self.or(element, timeout)
        XCTAssert(r.exists, "One of the elements should exist: \(r)")
        return r
    }
    
    /**
     Perform this function on an element if you want to wait until it's available before calling a function on it.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     - parameter callback: The function to perform if the element exists
     */
    func ifExists(_ timeout: TimeInterval = 10,_ callback: (_ element: XCUIElement) -> ()) {
        self.waitUntilExists(timeout)
        if self.exists {
            callback(self)
        }
    }
    
    /**
     Perform this function if an element is really not available available.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     - parameter callback: The function to perform if the element does not exists
     */
    @discardableResult
    func ifNotExist(_ timeout: TimeInterval = 10,_ callback: () -> ()) -> XCUIElement? {
        self.waitUntilExists(timeout)
        if !self.exists {
            callback()
            return nil
        }
        return self
    }
    
    /**
     Perform this function if an element is really not available available. The function is supposed to make the element available.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     - parameter callback: The function to perform if the element does not exists
     */
    @discardableResult
    func ifNotExistwaitUntilExists(_ timeout: TimeInterval = 10,_ callback: () -> ()) -> XCUIElement {
        if self.waitUntilExists(timeout).exists {
            return self
        }
        callback()
        return self.waitUntilExists(timeout)
    }
    
    /**
     Perform this function on an element if you want to wait until it's available and then type a text into it.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element iteself
     */
    @discardableResult
    func tapAndType(_ text: String, _ timeout: TimeInterval = 10) -> XCUIElement {
        self.waitUntilExists(timeout).tap()
        sleep(1) //Wait for keyboard... test?
        self.typeText(text)
        return self
    }
    
    /**
     Perform this function on a switch element if you want to wait until it's available and then turn it on or off.
     
     - parameter timeout: The maximum number of seconds that you want to wait. (Default is 10)
     
     :return: Return the element iteself
     */
    @discardableResult
    func setSwitch(_ on: Bool, _ timeout: TimeInterval = 10) -> XCUIElement  {
        self.waitUntilExists(timeout)
        if self.elementType == .`switch` {
            if  (!on && "\(self.value ?? "0")" == "1") || (on && "\(self.value ?? "0")" != "1") {
                self.tap()
            }            
        } else {
            XCTAssert(false, "Element is not a switch: \(self)")
        }
        return self
    }
}
