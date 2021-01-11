//
//  main.swift
//  BreakingBad
//
//  Created by Anderson Costa on 11/01/2021.
//

import UIKit

let kIsRunningTests: Bool = NSClassFromString("XCTestCase") != nil
let kAppDelegateClass: String? = kIsRunningTests ? nil : NSStringFromClass(AppDelegate.self)

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, kAppDelegateClass)
