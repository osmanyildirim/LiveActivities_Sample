//
//  AppDelegate.swift
//  LiveActivities_Sample
//
//  Created by osmanyildirim
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewControllerCreator.create()
        window?.makeKeyAndVisible()

        registerForPushNotifications()

        return true
    }
}

extension AppDelegate {
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted, error != nil else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        guard let phone = url.queryItems.first?.value as? String, let number = URL(string: "tel://" + phone) else { return true }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)

        return true
    }
}
