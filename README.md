# UITestHelper

[![Issues](https://img.shields.io/github/issues-raw/evermeer/UITestHelper.svg?style=flat)](https://github.com/evermeer/UITestHelper/issues)
[![Documentation](https://img.shields.io/badge/documented-100%25-green.svg?style=flat)](http://cocoadocs.org/docsets/UITestHelper/)
[![Stars](https://img.shields.io/github/stars/evermeer/UITestHelper.svg?style=flat)](https://github.com/evermeer/UITestHelper/stargazers)
[![Downloads](https://img.shields.io/cocoapods/dt/UITestHelper.svg?style=flat)](https://cocoapods.org/pods/UITestHelper)


[![Version](https://img.shields.io/cocoapods/v/UITestHelper.svg?style=flat)](http://cocoadocs.org/docsets/UITestHelper)
[![Language](https://img.shields.io/badge/language-swift%203-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/UITestHelper.svg?style=flat)](http://cocoadocs.org/docsets/UITestHelper)
[![License](https://img.shields.io/cocoapods/l/UITestHelper.svg?style=flat)](http://cocoadocs.org/docsets/UITestHelper)

[![Git](https://img.shields.io/badge/GitHub-evermeer-blue.svg?style=flat)](https://github.com/evermeer)
[![Twitter](https://img.shields.io/badge/twitter-@evermeer-blue.svg?style=flat)](http://twitter.com/evermeer)
[![LinkedIn](https://img.shields.io/badge/linkedin-Edwin%20Vermeer-blue.svg?style=flat)](http://nl.linkedin.com/in/evermeer/en)
[![Website](https://img.shields.io/badge/website-evict.nl-blue.svg?style=flat)](http://evict.nl)
[![eMail](https://img.shields.io/badge/email-edwin@evict.nl-blue.svg?style=flat)](mailto:edwin@evict.nl?SUBJECT=About%20UITestHelper)

# General information

When creating UI tests you will see that you are often repeating the same pieces of code. The UITestHelper library will try to limit this code repetition. Besides that there is also functionality to make your code resistant against wrongly typed identifiers.

## Using UITestHelper in your own App 

'UITestHelper' is available through the dependency manager [CocoaPods](http://cocoapods.org). 
You do have to use cocoapods version 1.1 or later

Below you can see a sample Podfile. You need to add the UITestHelper pod to your UI test target and if you want to use the GlobalHelper function you have to add the UITestHelper/App pod to your application target.

```
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'UITestHelper'

target 'UITestHelperApp' do
  platform :ios, '9.0'
  pod 'UITestHelper/App'
end

target 'UITestHelperUITests' do
    platform :ios, '9.0'
    pod 'UITestHelper'
end

# This will make sure your test project has ENABLE_BITCODE set to NO 
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['UITestHelperUITests'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
end
```


# Instructions

### Launching and connecting to your app with .tryLaunch

If you are using an XCode build server and run your tests in the simulator, then it can happen that you will not be able to connect to the simulator if your server is too bussy. For this the tryLaunch function has a build in retry mechanism. By default it will retry 10 times (can be changed by a parameter). After the tryLaunch all tests in your test class will have an app variable which point to the launched XCUIApplication.

The tryLaunch function also takes an array of RawRepresentable elements. Usually this will be an Enum that has a String as its base type. Your app will be launched with these parameters. In your app you can react on those parameters. In the case below you can see that the app is started with the MockNetworkResponses. Your app can then detect that value using the isLaunchedWith function and start the network Mocking. 

```swift
    // In your XCTestCase class:
    override func setUp() {
        super.setUp()
        self.tryLaunch([LaunchArguments.MockNetworkResponses])
    }

    // Somewhere in your application (if you have added the UITestHelper/App pod)
    if isLaunchedWith(LaunchArguments.MockNetworkResponses) {
        // Start the network mocking
    }
```

### Grouping your test statements

For getting a clear overvouw in your test output, you can group statements together. Groups can also be nested as far as you like. Starting a group is as easy as:

```swift
    group("Testing the switch") { activity in
        // Your test statements here will be grouped nicely in the test output.
    }
```

### Taking screenshots

Screenshot will allways be added to an activity group. If you call the takeScreenshot function without parameter, then it will just create a default screenshot group. You can also specify a groupName for when it creates a new group. You can also give the screenshot any name.

```swift
    group("Testing the switch") { activity in
        takeScreenshot(activity: activity, "First screenshot")
        takeScreenshot()
        takeScreenshot(groupName: "Screenshot group?")
        takeScreenshot("Last screenshot")
    }
```

### Using an enum for identifiers
UITestHelper has an extension for  RawRepresentalbe so that you can directly get an XCElement from an enum value when you also have set that enum value as the accessibility identifier. For instance you can create a nested enum like this:

```swift
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
```

In your UIViewControllers you can then set those to the accessibility identifiers of your elements like this:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    theLabel ~~> AccessibilityIdentifier.HomeScreen.theLabel
    theTextField ~~> AccessibilityIdentifier.HomeScreen.theTextField
    theButton ~~> AccessibilityIdentifier.HomeScreen.theButton
    switch1 ~~> AccessibilityIdentifier.HomeScreen.switch1
    switch2 ~~> AccessibilityIdentifier.HomeScreen.switch2
    hideButton ~~> AccessibilityIdentifier.HomeScreen.hideButton
    showButton ~~> AccessibilityIdentifier.HomeScreen.showButton
}
```

Then In your tests you could use these like this:

```swift
func testEnumWithIdentifiersReusedForInteractingWithXCUIElement() {
    HomeScreen.showButton.tap()
    HomeScreen.hideButton.tap()
}
```

When identifiers are reused for instance when using a collection or table, then you can also enumerate your enum element.

```swift
    // pressing the last theButton
    let i = HomeScreen.theButton.count 
    HomeScreen.theButton[i - 1].tap()
}
```

You can then use all the functions below directly on the enum value

### Waiting for an element

When creating tests you usually have to take into consideration if an element is accessible or not.  For this various helper functions are created. app will be your launched XCUIApplication. By default this function will wait for a maximum of 10 seconds. This can be changed through a parameter. The waitUntilExists will return the element but it could still be unavailable (.exists = false). If you wan to to an Assert based on that existence. then you can use the .waitUntilExistsAssert function

```swift
    // Using the enum:
	XCTAssert(HomeScreen.theLabel.waitUntilExists().exists, "label should exist")
	HomeScreen.theLabel.waitUntilExistsAssert()
    // Or just accessing the elements the old fashioned way:
	app.buttons["Second"].waitUntilExists().tap()
	app.buttons["Button"].waitUntilExists(3).tap()
```

### Select the element that does exists

With the .or function you can get one of the 2 elements that does exists. If both do not exists, then the first element will be returned and that .exists will be false. If you would like an assert in that case, then use the .orAssert function.

```swift
	HomeScreen.theLabel.or(HomeScreen.theTextfield).tap()
	HoeScreen.theLabel.orAssert(HomeScreen.theTextfield)
```

### Conditional code based on existance

Execute some code if an element does exists. The default wait time is here also 10 seconds and can be set as a parameter.

```swift
	// Only execute the closure if the element is there.
	HomeScreen.theButton.ifExists { $0.tap() } // The button exist, so we do tap it
	HomeScreen.hideButton.ifExists(2) { $0.tap() } 
```

Execute some code if the element does not exists. The default wait time is here also 10 seconds and can be set as a parameter.

```swift
    // The button does not exist, so we don't tap it, we do something else
	app.alerts.buttons["Hide"].ifNotExist(2) {
		app.buttons["Third"].waitUntilExists().tap()
	}
```

Execute some code if the element does not exist and assume that after the code the element does exists. In the code below if the Hide button does not exist, then press the show button which will make the Hide button appear and then the hide button will be pressed.
```swift
	HomeScreen.hideButton.ifNotExistwaitUntilExists(2) {
		HomeScreen.showButton.waitUntilExists().tap()
	}.tap()
}
```

### Enter field in a text field
Make sure the text field is ther, then tap on it and enter a text.
```swift
	HomeScreen.theTextField.tapAndType("testing")
```

### Switching a switch on or of
No matter the current state of the switch, it will be switched to the specified state.

```swift
HomeScreen.switch1.setSwitch(false)
```

## License

UITestHelper is available under the MIT 3 license. See the LICENSE file for more info.

## My other libraries:
Also see my other public source iOS libraries:

- [EVReflection](https://github.com/evermeer/EVReflection) - Reflection based (Dictionary, CKRecord, JSON and XML) object mapping with extensions for Alamofire and Moya with RxSwift or ReactiveSwift 
- [EVCloudKitDao](https://github.com/evermeer/EVCloudKitDao) - Simplified access to Apple's CloudKit
- [EVFaceTracker](https://github.com/evermeer/EVFaceTracker) - Calculate the distance and angle of your device with regards to your face in order to simulate a 3D effect
- [EVURLCache](https://github.com/evermeer/EVURLCache) - a NSURLCache subclass for handling all web requests that use NSURLReques
- [AlamofireOauth2](https://github.com/evermeer/AlamofireOauth2) - A swift implementation of OAuth2 using Alamofire
- [EVWordPressAPI](https://github.com/evermeer/EVWordPressAPI) - Swift Implementation of the WordPress (Jetpack) API using AlamofireOauth2, AlomofireJsonToObjects and UITestHelper (work in progress)
- [PassportScanner](https://github.com/evermeer/PassportScanner) - Scan the MRZ code of a passport and extract the firstname, lastname, passport number, nationality, date of birth, expiration date and personal numer.
- [AttributedTextView](https://github.com/evermeer/AttributedTextView) - Easiest way to create an attributed UITextView with support for multiple links (url, hashtags, mentions).
- [UITestHelper](https://github.com/evermeer/UITestHelper) - UI test helper functions.

