//
//  BienvenidaViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 19/05/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit

class BienvenidaViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func aceptarAction(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "welcome-message")
        defaults.synchronize()
        
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        UIApplication.shared.keyWindow?.rootViewController = loginView
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let loginView = storyboard.instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
//        UIApplication.shared.keyWindow?.rootViewController = loginView
        
    }
    
}
