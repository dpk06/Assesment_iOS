//
//  AppDelegate.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var networkIsConnected = false
    let reachability = try? Reachability()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupReachability()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    //--- reachability methods
    
    func setupReachability() {
       
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            networkIsConnected = true
            print("Reachable via WiFi")
            NotificationCenter.default.post(name: NSNotification.Name("Reachability"), object: ["connection":"wifi"])
            NotificationCenter.default.post(name: NSNotification.Name("Reachability"), object: nil, userInfo: ["connection":"wifi"])
            //AppCommonData.showToast(title: nil, message: "Connected", view: UIApplication.shared.keyWindow!)
        case .cellular:
            networkIsConnected = true
            print("Reachable via Cellular")
            NotificationCenter.default.post(name: NSNotification.Name("Reachability"), object: nil, userInfo: ["connection":"data"])
            //AppCommonData.showToast(title: nil, message: "Connected", view: UIApplication.shared.keyWindow!)
        case .none:
            networkIsConnected = false
            print("Network not reachable")
            NotificationCenter.default.post(name: NSNotification.Name("Reachability"), object: nil, userInfo: ["connection":"lost"])
            //AppCommonData.showToast(title: nil, message: "Lost network connection.", view: UIApplication.shared.keyWindow!)
        case .unavailable:
             networkIsConnected = false
            print("Network unavailable")
            NotificationCenter.default.post(name: NSNotification.Name("Reachability"), object: nil, userInfo: ["connection":"lost"])

        }
    }


}

