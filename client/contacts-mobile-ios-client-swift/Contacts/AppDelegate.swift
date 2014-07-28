/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // register with APNS
        let settings = UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        if let options = launchOptions {
            if let option : NSDictionary = options[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
                let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults();
                if let aps : NSDictionary = option["aps"] as? NSDictionary {
                    if let alert : String = aps["alert"] as? String {
                        defaults.setObject(alert, forKey: "message_received")
                        defaults.synchronize()
                    }
                }
            }
        }
        return true
    }

    // Callback called after successfully registration with APNS
    func application(application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        // convenient store the "device token" for later retrieval
        NSUserDefaults.standardUserDefaults().setObject(deviceToken, forKey: "deviceToken")
    }
    
    func application(application: UIApplication!, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]!, fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
        
        // ensure the user has logged in
        let rootVC = self.window?.rootViewController
        let topViewController = (rootVC as UINavigationController).topViewController
        
        // are we logged in ?
        if let contactsController = topViewController as? ContactsViewController {
            
            // if the user clicked the notification, we know that the Contact
            // has already been fetched so we just ask the controller to
            // display the details screen for this Contact.
            if application.applicationState == .Inactive {
                contactsController.displayDetailsForContactWithId(userInfo["id"] as NSNumber)
      
            } else {  // fetch it
                // attempt to fetch new contact
                contactsController.performFetchWithUserInfo(userInfo, completionHandler)
            }
        }
    }
}

