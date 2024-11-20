//
//  AppDelegate.swift
//  RentCar
//
//  Created by beyza nur on 15.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func new(){
        let lsvc=UIStoryboard(name:"LaunchScreen" , bundle: nil)
        let gecisVc=lsvc.instantiateViewController(withIdentifier:"launch" )
        window?.rootViewController = gecisVc
        window?.makeKeyAndVisible()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(home), userInfo: nil, repeats: false)
    }
    @objc func home(){
        let mainvc=UIStoryboard(name:"Main" , bundle: nil)
        let gecisVc=mainvc.instantiateViewController(withIdentifier:"main" )
        window?.rootViewController = gecisVc
        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

