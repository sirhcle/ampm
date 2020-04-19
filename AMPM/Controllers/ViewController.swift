//
//  ViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 22/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import WebKit
import RAMAnimatedTabBarController
import CoreLocation

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    let sampleURL = "https://www.google.com/maps/d/u/0/viewer?mid=1S0vCi3BA-7DOCS13MomK7KebkPsvYl8C&ll=20.94795435265575%2C-101.38373951049061&z=5"
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** obtener localización **/
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
        ProgressHUD.sharedInstance.show(withText: "Cargando mapa de transmisión.")
        self.sendRequest(urlString: sampleURL)
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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

