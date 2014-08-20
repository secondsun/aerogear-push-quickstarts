quickstart-push-ios: CRUD Mobile Application showing the AeroGear Push feature on iOS  (Swift version)
======================================================================================================
Author: Christos Vasilakis (cvasilak)  
Level: Beginner  
Technologies: Swift, iOS  
Summary: A Contacts CRUD mobile application with Push notification integration.  
Target Product: Mobile  
Product Version: MP 1.0  
Source: https://github.com/aerogear/aerogear-push-quickstarts/tree/swift/client/contacts-mobile-ios-client-swift

What is it?
-----------

This project is an iOS mobile front-end to the [Contacts](https://github.com/aerogear/aerogear-push-quickstarts/contacts-mobile-picketlink-secured) server application found in the [quickstarts](https://github.com/aerogear/aerogear-push-quickstarts) of the Red Hat [JBoss Web Framework Kit](http://www.jboss.org/jdf/). All CRUD features are supported, as well as integration with the Push notification mechanism to instantly retrieve a new Contact when it is created on the server. A video demonstrating the application 'in-action' can be found [here](https://vimeo.com/96095487). 

The application is written in [Swift](https://developer.apple.com/swift/) and uses the [Push SDK Swift](https://github.com/aerogear/aerogear-ios-push/tree/swift) port for registering to the UnifiedPush Server.

System requirements
-------------------
- iOS 8.X
- Xcode version 6 Beta 6


Pre-requisites
---------

* Both the [Contacts](https://github.com/aerogear/aerogear-push-quickstarts/contacts-mobile-picketlink-secured) and the [AeroGear UnifiedPush Server](https://github.com/aerogear/aerogear-unifiedpush-server) applications up and running. Follow the documentation of each respective project to set them up.
* A valid configured variant on the UPS admin console as well as a valid Apple Provisioning profile because you will need to test on device (Push notifications are not available on simulator). Follow the documentation on the [UPS guide](http://aerogear.org/docs/unifiedpush/aerogear-push-ios/) to set them up.
* Replace the name of the '_Bundle ID_ ' with the name that you have associated with your certificate. 
Click on the 'Contacts target -> General' and modify the _Bundle Identifier_:

![change contacts bundle](doc/change-contacts-bundle.png)

* Ensure the Apple Provisioning profile is correctly set:

![change provisioning profile](doc/change-provisioning-profile.png)


Build and Deploy the Contacts
-------------------------------

## Change Push Configuration

In '_LoginViewController.swift_' modify the URL, variant and secret to match your AeroGear UnifiedPush server configuration. 

NOTE:
You can copy/paste these settings from the [UnifiedPush Administration console](http://aerogear.org/docs/unifiedpush/ups_userguide/admin-ui/).

```swift
let registration = AGDeviceRegistration(serverURL: NSURL(string: "<# URL of the running AeroGear UnifiedPush Server #>"))
...
clientInfo.variantID = "<# Variant Id #>"
clientInfo.variantSecret = "<# Variant Secret #>"
---
```

After the Push settings are configured, open '_ContactsNetworker.swift_' and modify the URL to match the path to the Contacts server backend.

```swift
static let kAPIBaseURLString = "<# URL of the Contacts application backend #>";
```

You can now build and run the application.


Application Flow
----------------------

When you first lunch the application, you are required to login. Enter your employee credentials (by default the 'Contacts' backend creates a list of default employees such as '_maria:maria_') and click Login. If the login is successfully, you are presented with a list of existing Contacts residing on the server. 

![contacts list home screen](doc/contacts-list.png)

Clicking a Contact reveals the edit screen where you can modify his/her details.

![contact details](doc/contact-details.png)

Receiving Notifications
----------------------

To test that you can successfully receive notifications when a new contact is created, open the web interface of the application (you can also use the [Android variant](https://github.com/aerogear/aerogear-push-quickstarts/tree/master/client/contacts-mobile-android-client)) and try to add a new Contact. Once done, and if the application is successfully configured, immediately you will see the notification popping up on the screen.

![contact details](doc/notification.png)

## 'Content-Available'

Instead of the regular 'didReceiveRemoteNotification' callback invoked when a new notification is received, the application utilizes the 'silent' push feature (offered by iOS 7 and later), so the application can be instructed to fetch the new content even if background (and possible suspended). Thus when the user opens up the app, the content is already available to be viewed. Take a look at the _AppDelegate.swift_ notification callback method for the impl. details.

```swift
 func application(application: UIApplication!, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]!, fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) { 
- ...
}
```


FAQ
---

* Which iOS version is supported by AeroGear CRUD mobile app?

AeroGear CRUD mobile app supports iOS 8.0 and later.


Debug the Application
=====================

Set a break point in Xcode.
