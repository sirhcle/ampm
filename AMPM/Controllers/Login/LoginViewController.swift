//
//  LoginViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 20/05/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, RegisterDelegate {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        
        if txtEmail.text == "" || txtPassword.text == ""
        {
            ProgressHUD.sharedInstance.showError(withMessage: "Usuario y contraseña obligatorios")
            return
        }
//        ProgressHUD.sharedInstance.show()
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { [weak self] authResult, error in
          
            if let error = error {
                ProgressHUD.sharedInstance.showError(withMessage: "\(error.localizedDescription)")
                return
            }
//            ProgressHUD.sharedInstance.dismiss()
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "RAMAnimatedTabBarController")
            UIApplication.shared.keyWindow?.rootViewController = mainVC
//            self?.navigationController?.pushViewController(mainVC, animated: true)
        }
        
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Delegados
    
    func registerSucces(curp: String) {
        let alert = UIAlertController(title: "", message: "Su usuario y contraseña se han creado, ingréselos para poder acceder", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
//        UserDefaults.standard.set(true, forKey: "alertShowed")
        
//        self.callID = curp
//        self.resetForms()
//        self.enableDisableForm()
//        self.btnCallDoctor.isEnabled = true
    }
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
