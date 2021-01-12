//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by Anderson Costa on 11/01/2021.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutConfigurator.applyLayoutAppearance()
        return true
    }
}

