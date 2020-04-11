//
//  ProgressHUD.swift
//  AMPM
//
//  Created by CHERNANDER04 on 02/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation
import KRProgressHUD

class ProgressHUD {
    
    static let sharedInstance: ProgressHUD = {
        let instance = ProgressHUD()
        let color = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let textColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let iconColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        
        KRProgressHUD.set(style: KRProgressHUDStyle.custom(background: color, text: textColor, icon: nil))
            .set(activityIndicatorViewColors: [iconColor])
            .set(maskType: KRProgressHUDMaskType.black)
        return instance
    }()
    
    func show() {
        KRProgressHUD.show()
    }
    
    func show(withText: String) {
        KRProgressHUD.show(withMessage: withText, completion: nil)
    }
    
    func success() {
        KRProgressHUD.set(duration: 3.0)
        KRProgressHUD.showSuccess()
    }
    
    func success(withMessage: String) {
        KRProgressHUD.set(duration: 3.0)
        KRProgressHUD.showSuccess(withMessage: withMessage)
    }
    
    func dismiss() {
        KRProgressHUD.dismiss()
    }
    
    func showError(withMessage: String) {
        KRProgressHUD.set(duration: 3.0)
        KRProgressHUD.showError(withMessage: withMessage)
    }
    
}


