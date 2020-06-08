//
//  AppDelegate.swift
//  AMPM
//
//  Created by CHERNANDER04 on 22/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import JitsiMeet

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "welcome-message") {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialVC = storyboard.instantiateViewController(identifier: "BienvenidaViewController") as! BienvenidaViewController
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
        else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialVC = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
        FirebaseApp.configure()
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
    
    // MARK: - Linking delegate methods

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        self.redirectUniversalLink(userActivity: userActivity)
        return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return JitsiMeet.sharedInstance().application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return true
    }
    
    
    //MARK: UniversalLInk redirect
    
    func redirectUniversalLink(userActivity: NSUserActivity){
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            
            guard  let urlPage = userActivity.webpageURL else { return }
            //print(urlPage)
            
            let urlString = urlPage.absoluteString
            
//            if let range = urlString.range(of: "https://www.gema.clinic/") {
//                let chatRoom = urlString[range.upperBound...]
//                print(chatRoom)
                
//                guard let tabBarController = window?.rootViewController as? UITabBarController else {
//                  return
//                }
                
//                guard let viewControllers = tabBarController.viewControllers else { return }

//                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "VideoConsultaViewController") as! VideoConsultaViewController
//                vc.idConferencia = String(chatRoom)
//                tabBarController.present(vc, animated: true, completion: nil)
//            }
        }
    }
    
//    func redirectUniversalLinkScheme(url: URL){
//            guard  let rootViewController :UIViewController = self.topViewControllerWithRootViewController(rootViewController:
//                self.window?.rootViewController) else { return  }
//
//            if  !self.UniversalLinksObj.presentCustomViewControllerWithURL(url: url, rootVewController:rootViewController, objUniversalLnk:UniversalLinksObj){
//                //UIApplication.shared.openURL(urlPage)
//                //no hacer nada
//            }
//
//        return
//    }


}

