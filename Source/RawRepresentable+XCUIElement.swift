//
//  RawRepresentable+XCUIElement.swift
//  Pods-UITestHelperApp
//
//  Created by Maljaars, Samuel on 29/05/2018.
//

import XCTest

/*
 This extension enables retrieving an XCUIElement from a string enum value that has also been used as accessibility identifier.

 Example usage:

 // Example enum shared between app development target and app UI testing target (Page Object Pattern).
 // This enum needs to be shared between the main development and UI testing target.
 enum Login: String {
    case userNameField
    case passwordField
    case submitButton
 }

 // Use of enum in your app source code:
 userNameField.accessibilityIdentifier = Login.userNameField.rawValue
 passwordField.accessibilityIdentifier = Login.passwordField.rawValue
 submitButton.accessibilityIdentifier = Login.submitButton.rawValue

 // Use of enum in your UI test code:
 Login.userNameField.tap()
 Login.passwordField.tap()
 Login.submitButton.tap()
 XCTAssertTrue(Login.submitButton.exists)

 */
public extension RawRepresentable {

    var element: XCUIElement {
        if let identifier = self.rawValue as? String {
            return elementForIdentifier(identifier).firstMatch
        }
        fatalError("Couldn't cast rawValue \(self.rawValue) to String")
    }

    var exists: Bool {
        return element.exists
    }

    func tap() {
        element.tap()
    }
}
