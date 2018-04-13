//
//  AppDelegate.swift
//  ContactWithFirebaseExample
//
//  Created by Kenta Nakai on 4/1/18.
//  Copyright © 2018 UROURO. All rights reserved.
//

import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        return true
    }

}

