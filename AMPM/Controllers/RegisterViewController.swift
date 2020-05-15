//
//  RegisterViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 26/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import Eureka

import Firebase
import FirebaseCore
import FirebaseFirestore
import CFAlertViewController
import Loaf
import RealmSwift

protocol RegisterDelegate {
    func registerSucces(curp: String)
}

class RegisterViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    var eurekaForm: FormViewController! = FormViewController()
    var delegate: RegisterDelegate!
    var form:Eureka.Form!
    
    let colorEditing = UIColor.init(red: 174.0/255.0, green: 204.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    
    override func viewDidLayoutSubviews() {
        self.eurekaForm.view.frame.size.width = self.viewContainer.frame.size.width
        self.eurekaForm.view.frame.size.height = self.viewContainer.frame.size.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        form = self.eurekaForm.form
        
        form +++ Section("Datos personales")
//
        <<< TextRow(){ row in
            row.title = "Apellido paterno"
            row.tag = "apPaterno"
            row.add(rule: RuleRequired(msg: "Campo requerido", id: ""))
            row.validationOptions = .validatesOnChange
            
        }.cellUpdate { cell, row in
            self.configStyles(cell: cell, row: row)
            if cell.textField.text!.count > 50 {
                row.value?.removeLast()
            }
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }.onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Apellido materno"
            row.tag = "apMaterno"
            row.value = ""
        }.cellUpdate { cell, row in
            self.configStyles(cell: cell, row: row)
            if cell.textField.text!.count > 50 {
                row.value?.removeLast()
            }
        }.onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Nombre(s)"
            row.tag = "nombre"
            row.add(rule: RuleRequired(msg: "Campo requerido", id: ""))
            row.validationOptions = .validatesOnChange
            
        }.cellUpdate { cell, row in
            self.configStyles(cell: cell, row: row)
            if cell.textField.text!.count > 50 {
                row.value?.removeLast()
            }
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }.onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })
            
        <<< SegmentedRow<String>() {
            $0.title = "Sexo"
            $0.options = ["Masculino", "Femenino"]
            $0.value = "Masculino"
            $0.tag = "sexo"
        }.cellUpdate { cell, row in
            let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
            let segmentedSelected = UIColor.lightGray
//            let segmentedSelected = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            let segmentedNormal = UIColor.white
            
            cell.titleLabel?.textColor = titleColor
            cell.segmentedControl.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
            cell.segmentedControl.backgroundColor = segmentedSelected
            cell.segmentedControl.tintColor = titleColor
            
            cell.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: segmentedNormal], for: .selected)
            
            cell.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: segmentedNormal], for: .normal)
            
            if #available(iOS 13.0, *) {
                cell.segmentedControl.backgroundColor = titleColor
                cell.segmentedControl.tintColor = UIColor.clear
                cell.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
                    segmentedNormal], for: .selected)
                cell.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: segmentedNormal], for: .normal)
                cell.segmentedControl.selectedSegmentTintColor = segmentedSelected
            } 
        }
            
        <<< DateRow(){ row in
            row.title = "Fecha de nacimiento"
            row.tag = "fNacimiento"
            row.value = Date()
        }.onChange({ (row) in
            let dateNow = Date()
            let birthday = row.value
            let calendar = Calendar.current
            
            let ageComponets = calendar.dateComponents([.year], from: birthday!, to: dateNow)
            let age = ageComponets.year
            
            let edadRow = self.form.rowBy(tag: "edad") as! TextRow
            edadRow.value = "\(age ?? 0)"
            edadRow.reload()
        }).cellUpdate({ (cell, row) in
            cell.datePicker.maximumDate = Date()
            let textfieldColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
            cell.textLabel!.textColor = titleColor
            cell.detailTextLabel?.textColor = textfieldColor
        })

        <<< TextRow(){ row in
            row.title = "Edad"
            row.tag = "edad"
            row.disabled = true
            row.value = "0"
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "CURP"
            row.tag = "curp"
            row.add(rule: RuleRequired(msg: "Campo requerido", id: ""))
            row.validationOptions = .validatesOnChange
            
        }.cellUpdate({ (cell, row) in
            row.cell.textField.text = row.cell.textField.text?.uppercased()
            self.configStyles(cell: cell, row: row)
            if let txtCurp:String = (row.baseValue as? String) {
                do {
                    let regex = try NSRegularExpression(pattern: "^[A-Z]{4}[0-9]{6}[A-Z]{6}[A-Z0-9]{1}[0-9]{1}$")
                    let validRegex = regex.matches(txtCurp)
                    
                    if !validRegex {
                        cell.titleLabel?.textColor = .systemRed
                    }
                } catch {
                    print(error)
                }
            }
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }).onChange({ (row) in
            row.cell.textField.text = row.cell.textField.text?.uppercased()
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })
        


        form +++ Section("Dirección")
        
        <<< TextRow(){ row in
            row.title = "Código postal"
            row.tag = "cp"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
            cell.textField.keyboardType = .numberPad
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "País"
            row.tag = "pais"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Estado"
            row.tag = "estado"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Condado"
            row.tag = "condado"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Ciudad"
            row.tag = "ciudad"
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
            row.value = ""
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Calle"
            row.tag = "calle"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })

        <<< TextRow(){ row in
            row.title = "Teléfono"
            row.tag = "telefono"
            row.value = ""
        }.cellUpdate({ (cell, row) in
            self.configStyles(cell: cell, row: row)
            cell.textField.keyboardType = .numberPad
        }).onCellHighlightChanged({ (cell, row) in
            
            if cell.textField.isEditing {
                cell.backgroundColor = self.colorEditing
            } else {
                cell.backgroundColor = UIColor.white
            }
        })
        
        <<< ButtonRow() { row in
            row.title = "Registrarse"
            row.onCellSelection(self.registrarse)
        }.cellSetup({ (cell, row) in
            cell.tintColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        })
        
        self.viewContainer.addSubview(eurekaForm.view)
    }
    
    //MARK: FUNCIONES
    
    func configStyles(cell: TextCell, row: TextRow ) {
        let textfieldColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        cell.titleLabel?.textColor = titleColor
        cell.textField.textColor = textfieldColor
    }
    
    func registrarse(cell: ButtonCellOf<String>, row: ButtonRow) {
        
        let formValues = form.values()
        
        let db = Firestore.firestore()
        
        if (self.form.validate().count != 0) {
            // Create Alet View Controller
            ProgressHUD.sharedInstance.dismiss()
            
            Loaf("Validar campos erroneos",
                 state: .error,
                 location: .top,
                 presentingDirection: .vertical,
                 dismissingDirection: .vertical,
                 sender: self)
            .show()

            return
        }
        ProgressHUD.sharedInstance.show()
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: formValues["fNacimiento"]! as! Date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let fNacimientoStr = formatter.string(from: yourDate!)
        
        let dataRegister = Register()
        
        dataRegister.apPaterno = (formValues["apPaterno"]! ?? "") as! String
        dataRegister.apMaterno = (formValues["apMaterno"]! ?? "") as! String
        dataRegister.nombre = (formValues["nombre"]! ?? "") as! String
        dataRegister.sexo = (formValues["sexo"]! ?? "") as! String
        dataRegister.fNacimiento = fNacimientoStr
        dataRegister.edad = (formValues["edad"]! ?? "") as! String
        dataRegister.curp = (formValues["curp"]! ?? "") as! String
        dataRegister.cp = (formValues["cp"]! ?? "") as! String
        dataRegister.pais = (formValues["pais"]! ?? "") as! String
        dataRegister.estado = (formValues["estado"]! ?? "") as! String
        dataRegister.condado = (formValues["condado"]! ?? "") as! String
        dataRegister.ciudad = (formValues["ciudad"]! ?? "") as! String
        dataRegister.calle = (formValues["calle"]! ?? "") as! String
        dataRegister.telefono = (formValues["telefono"]! ?? "") as! String
        
        
        self.saveOnLocal(dataRegister: dataRegister) {
            db.collection("registerd-users").document(formValues["curp"]!! as! String).setData([
                "apPAterno": dataRegister.apPaterno,
                "apMaterno": dataRegister.apMaterno,
                "nombre": dataRegister.nombre,
                "sexo": dataRegister.sexo,
                "fNacimiento": dataRegister.fNacimiento,
                "edad": dataRegister.edad,
                "curp": dataRegister.curp,
                "cp": dataRegister.cp,
                "pais": dataRegister.pais,
                "estado": dataRegister.estado,
                "condado": dataRegister.condado,
                "ciudad": dataRegister.ciudad,
                "calle": dataRegister.calle,
                "telefono": dataRegister.telefono
            ]) { error in
                if let err = error {
                    ProgressHUD.sharedInstance.showError(withMessage: "Error al registrarse \(err)")
                } else {
                    
//                    ProgressHUD.sharedInstance.show(withText: "Información almacenada correctamente")
                    ProgressHUD.sharedInstance.success(withMessage: "Información almacenada correctamente")
                    
                    UserDefaults.standard.set(dataRegister.curp, forKey: "CURP")
                    
                    if let delegate = self.delegate {
                        self.dismiss(animated: true) {
                            delegate.registerSucces(curp: dataRegister.curp)
                        }
                    }
                }
            }
        }
        
        
    }
    
    func saveOnLocal(dataRegister: Register, _ registerSucced: ()->Void)
    {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(dataRegister, update: Realm.UpdatePolicy.modified)
        try! realm.commitWrite()
        registerSucced()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location < 11 {
            return true
        }
        
        return false
    }
}
