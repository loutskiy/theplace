//
//  AppDelegate.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 17/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import NMAKit
import RealmSwift

let realm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let kHelloMapAppID = "7G8B8R5AhXyJcWamH5bA"
        let kHelloMapAppCode = "eHs9MPlm2N1Bqu7cRm3woQ"
        let kHelloMapLicenseKey = "Tw7dzdNaKaP/9VJl4wauXpNrCDgz4rFth2eAaPFNN99tlTze5uD5r2pZ5iepP+Tib1zZKynwtaNQJPGv91g+gOiKZXTjt39Q/2kYgMcm9w0puMfArLgjIM8qoI32MW2BQT1dWBl3qHwbU1lh7qdsfDCd3Y1D2ZNQ2PMlCLVw/U5YpHyF+HyEbJvSQaU4VpyhQRpDMKDjqdu1mOfeMgM7y2mYKpiqb63kS00n/ZT/l0a29WKfiiW7HvCA2ogW2gS/3S+Sbf1ZJXxKcJ3jM7NyxDCDt70dPtSciwwe1qrgpQuoY+PLm7FUnx43AOEpQKDaGbBVcYhwYDWbWKQig+zOY2IByNMGhvzLGmSZ8y3/2GlaGU315A2c/w/V7wR1DkKJmZpQzqX3/YDwjXAZxiLwdAnv0mHJ6JWXPKZQNiFOT46uSUfeL0Ti5tFLCpyCNWwfw6qAj3WyNzv2fY0yWIO9jkkkWGHaw7t8dsaZsNSFuF2HsbIueIVgXfFsra8wsvsLmlF6VTqU7ZQwE+/LdfsfIWk588zTcp3/0xRVc5zFJ9dlOdpc6rbBFiHgn7x5WkEqj2jgmWJyBVW1jNSa2Tw3/GyLS3EAsDevvpctcnrZ9TscAxjXNqVcq/sz3xWl0C3uE71kTG6kmCSk3itgfz/7ngqp5Gh+i7aoeO/tOQiuTLw="
        
        let error =  NMAApplicationContext.setAppId(kHelloMapAppID,
                                                    appCode: kHelloMapAppCode,
                                                    licenseKey: kHelloMapLicenseKey)
        assert(error == NMAApplicationContextError.none)
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

