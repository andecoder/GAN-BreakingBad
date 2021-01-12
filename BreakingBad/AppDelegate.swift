//
//  AppDelegate.swift
//  BreakingBad
//
//  Created by Anderson Costa on 11/01/2021.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appComposer: AppComposer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutConfigurator.applyLayoutAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        appComposer = AppComposer(dependencyProvider: iPhoneDependencyProvider(), window: window!)
        appComposer?.launchInitialScreen()
        return true
    }
}

