//
//  AppDelegate.swift
//  Moving Letters
//
//  Created by Jeffrey Camealy on 12/16/15.
//  Copyright © 2015 New Engineer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - AppDelegate Methods

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupWindow()
        setupRootVC()
        return true
    }
    
    //MARK: - Internal
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
    }
    
    func setupRootVC() {
        window?.rootViewController = ViewController()
    }

}

