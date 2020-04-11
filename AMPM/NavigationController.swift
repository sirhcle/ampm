//
//  NavigationController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 04/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            
            let appearance = UINavigationBarAppearance()

            appearance.backgroundColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // With a red
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance // For iPhone small navigation bar in landscape.
        } else {
//            self.navigationBar.barTintColor = UIColor.black
//            self.navigationBar.tintColor = UIColor.white
            self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
