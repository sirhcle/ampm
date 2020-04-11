//
//  UsersListViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 08/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import RealmSwift

protocol UserListDelegate {
    func userListRegisterNew()
    func userListUserSelected(dataUser: Register)
}
class UsersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataUser: Results<Register>!
    var delegate: UserListDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let registered = realm.objects(Register.self)
        //print(registered)
        self.dataUser = registered
        
    }
    
    //MARK:  - TABLE VIEW DATASOURCE DELEGATE
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.dataUser.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellRegistrados", for: indexPath) as! CellRegistrados
            cell.lblNombre.text = "\(self.dataUser[indexPath.row].nombre) \(self.dataUser[indexPath.row].apPaterno) \(self.dataUser[indexPath.row].apMaterno)"
            cell.lblCURP.text = "\(self.dataUser[indexPath.row].curp)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellRegistrarNuevo", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            self.dismiss(animated: true) {
                if let delegate = self.delegate {
                    delegate.userListUserSelected(dataUser: self.dataUser[indexPath.row])
                }
            }
        default:
            self.dismiss(animated: true) {
                if let delegate = self.delegate {
                    delegate.userListRegisterNew()
                }
            }
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60.0)
            let viewHeader = UIView(frame: frame)
            
            let color = UIColor.init(red: 248/255, green: 157/255, blue: 2/255, alpha: 1.0)
            viewHeader.backgroundColor = color
            
            let lblTitle = UILabel(frame: frame)
            lblTitle.text = "Lista de pacientes registrados"
            lblTitle.font = UIFont(name: "Helvetica", size: 14)
            lblTitle.textAlignment = .center
            lblTitle.textColor = .white
            
            viewHeader.addSubview(lblTitle)
            
            return viewHeader
        default:
            let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50.0)
            let view = UIView(frame: frame)
            
            return view
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 58
        }
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
