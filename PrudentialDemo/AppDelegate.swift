//
//  AppDelegate.swift
//  PrudentialDemo
//
//  Created by Ad on 2021/4/2.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        windowConfig()
        return true
    }
    /// window配置
    private func windowConfig() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainController()
    }
}
