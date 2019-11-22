//
//  AppDelegate.swift
//  Todoish
//
//  Created by Kateryna Tsysarenko on 24/10/2019.
//  Copyright © 2019 Kateryna Tsysarenko. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
                
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
           = try Realm()
        } catch {
            print("Error initializing new realm", error)
        }
        
        return true
    }

}

