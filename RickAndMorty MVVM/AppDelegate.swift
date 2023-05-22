//
//  AppDelegate.swift
//  RickAndMorty MVVM
//
//  Created by Artem on 22.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var flowController: FlowController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        setupFlowController()
        return true
    }
    
    func setupFlowController() {
        
        flowController = FlowController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = flowController?.mainVC
        
        window?.makeKeyAndVisible()
    }

}

