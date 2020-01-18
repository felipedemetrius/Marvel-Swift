//
//  AppDelegate.swift
//  Marvel-Swift
//
//  Created by Felipe Silva  on 17/01/20.
//  Copyright © 2020 Felipe Silva . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startCoordinator()
        return true
    }

    private func startCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator(window: window)
        self.window = window
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}

