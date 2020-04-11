//
//  VideoConsultaViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 10/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import WebKit
import RAMAnimatedTabBarController

class VideoConsultaViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var idConferencia = ""
    let sampleURL = "https://www.gema.clinic/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.sharedInstance.show(withText: "Video llamada con médico.")
        self.sendRequest(urlString: "\(sampleURL)\(idConferencia)")
    }
    
    // Convert String into URL and load the URL
    private func sendRequest(urlString: String) {
      let myURL = URL(string: urlString)
      let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = self
      webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.sharedInstance.dismiss()
    }

}
