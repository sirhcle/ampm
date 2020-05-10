//
//  PrevencionViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 22/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import WebKit
import RAMAnimatedTabBarController

class PrevencionViewController: UIViewController, WKNavigationDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        ProgressHUD.sharedInstance.show()
        let url = Bundle.main.url(forResource: "prevencion2", withExtension: "html")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
        webView.navigationDelegate = self

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.sharedInstance.dismiss()
    }
}
