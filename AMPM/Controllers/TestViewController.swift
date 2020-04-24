//
//  TestViewController.swift
//  AMPM
//
//  Created by CHERNANDER04 on 22/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController
import Eureka
import Loaf
import KRProgressHUD
import RealmSwift
import Firebase
import FirebaseCore
import FirebaseFirestore

class TestViewController: UIViewController, RegisterDelegate, UserListDelegate {
    
    //MARK: -
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnRegistro: UIBarButtonItem!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var btnCallDoctor: UIBarButtonItem!
    
    var isRegistered: Bool! = false
    var eurekaForm: FormViewController! = FormViewController()
    var form:Eureka.Form!
    var estatura: String! = ""
    var peso: String! = ""
    var callID: String! = ""
    
    override func viewDidLayoutSubviews() {
        self.eurekaForm.view.frame.size.width = self.viewContainer.frame.size.width
        self.eurekaForm.view.frame.size.height = self.viewContainer.frame.size.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUD.sharedInstance.show(withText: "Verificando usuarios registrados")
        self.enableDisableForm()
        self.checkForDoctor()
        
        let alertShowed = UserDefaults.standard.bool(forKey: "alertShowed")
        if alertShowed != true {
            let alert = UIAlertController(title: "", message: "Inicio del test aparecer alerta: Este cuestionario es únicamente informativo y no representa un diagnóstico médico, si presentas algún deterioro en tu salud, solicita inmediatamente la atención médica necesaria.  Juntos trabajaremos para prevenir el COVD-19", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "alertShowed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnCallDoctor.isEnabled = false
        self.isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        
        self.form = self.eurekaForm.form
        
        //MARK: - SECCION 1
        form +++ Section("Signos vitales y somatometria")
        
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "presionSistolica", title: "Presión sistólica (mmHg)"))
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "presionDiastolica", title: "Presión diastólica (mmHg)"))
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "frecuenciaCardiaca", title: "Frecuencia cardiaca (PPM)"))
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "temperatura", title: "Temperatura ºC"))
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "estatura", title: "Estatura(m)"))
                .onChange({ (row) in
                    self.estatura = row.baseValue as? String
                    self.calculaasaCorporal()
            })
        
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "peso", title: "Peso(Kg)"))
                .onChange({ (row) in
                    self.peso = row.baseValue as? String
                    self.calculaasaCorporal()
            })
            <<< FormElements.TextRowElement(parameters: TextRowConfiguration(tag: "masaCorporal", title: "Índice de Masa Corporal (IMC)"))
                
        
        //MARK: - SECCION 2
        
        form +++ Section("Antecedentes personales patológicos")
            
            <<< FormElements.LabelRowElement(parameters: LabelRowConfiguration(title: "¿Tengo alguno de los siguientes padecimientos?"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Cáncer", options: ["Si", "No"], value: "No", tag: "cancer"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Diabetes", options: ["Si", "No"], value: "No", tag: "diabetes"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Embarazo", options: ["Si", "No"], value: "No", tag: "embarazo"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Enfermedad cerebrovascular", options: ["Si", "No"], value: "No", tag: "cerebrovascular"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Enfermedad digestiva", options: ["Si", "No"], value: "No", tag: "digestiva"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Enfermedad renal crónica", options: ["Si", "No"], value: "No", tag: "renal"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Enfermedades cardiovasculares", options: ["Si", "No"], value: "No", tag: "cardiovasculares"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "EPOC", options: ["Si", "No"], value: "No", tag: "epoc"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Hipertensión", options: ["Si", "No"], value: "No", tag: "hipertension"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Inmunosupresión", options: ["Si", "No"], value: "No", tag: "inmunosupresion"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "Lactancia", options: ["Si", "No"], value: "No", tag: "lactancia"))
        

        //MARK: - SECCCION 3
        form +++ Section("TEST PARA SÍNTOMAS COVID-19")
            
            //PREGUNTA 1
            <<< FormElements.LabelRowElement(parameters: LabelRowConfiguration(title: "1.¿Estuve en contacto con personas con COVID-19?"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "", options: ["Si", "No"], value: "No", tag: "pregunta1"))
            
        
            //PREGUNTA 2
//            <<< FormElements.LabelRowElement(parameters: LabelRowConfiguration(title: "2.¿Regresé de un país/estado con transmisión comunitaria?"))
//            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "", options: ["Si", "No"], value: "No", tag: "pregunta2"))
            
            //PREGUNTA 3
            <<< FormElements.LabelRowElement(parameters: LabelRowConfiguration(title: "2.¿Estuve en contacto con personas que regresaron de un país/estado con transmisión comunitaria?"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "", options: ["Si", "No"], value: "No", tag: "pregunta3"))
        
            //PREGUNTA 4
            <<< FormElements.LabelRowElement(parameters: LabelRowConfiguration(title: "¿Presento los siguientes síntomas?"))
            
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "3. Fiebre", options: ["Si", "No"], value: "No", tag: "pregunta4"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "4. Tos", options: ["Si", "No"], value: "No", tag: "pregunta5"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "5. Dificultad para respirar", options: ["Si", "No"], value: "No", tag: "pregunta6"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "6. Dolor de cabeza", options: ["Si", "No"], value: "No", tag: "pregunta7"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "7. Dolor de articulaciones", options: ["Si", "No"], value: "No", tag: "pregunta8"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "8. Dolor de garganta", options: ["Si", "No"], value: "No", tag: "pregunta9"))
            
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "9. Diarrea", options: ["Si", "No"], value: "No", tag: "pregunta10"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "10. Dolor muscular", options: ["Si", "No"], value: "No", tag: "pregunta11"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "11. Debilidad y malestar en general", options: ["Si", "No"], value: "No", tag: "pregunta12"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "12. Secreción nasal", options: ["Si", "No"], value: "No", tag: "pregunta13"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "13. Conjuntivitis", options: ["Si", "No"], value: "No", tag: "pregunta14"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "14. Dolor en el pecho, sensación de falta de aire", options: ["Si", "No"], value: "No", tag: "pregunta15"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "15. Aumento excesivo en la producción de moco y/o flemas", options: ["Si", "No"], value: "No", tag: "pregunta16"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "16. Fiebre difícil de controlar", options: ["Si", "No"], value: "No", tag: "pregunta17"))
            <<< FormElements.SegmentedRowElement(parameters: SegmentedRowConfiguration(title: "17. Escalofrío", options: ["Si", "No"], value: "No", tag: "pregunta18"))
            
        
            <<< ButtonRow(){ row in
                row.title = "Realizar test"
                row.onCellSelection { (cell, row) in
//                    print("evaluar")
                    ProgressHUD.sharedInstance.show(withText: "Evaluando")
                    self.testResult()
                }.cellSetup { (cell, row) in
                    cell.tintColor = UIColor.systemBlue
                }
            }
        
        self.viewContainer.addSubview(eurekaForm.view)
    }
    
    func checkForDoctor() {
        let db = Firestore.firestore()
        if let curp = UserDefaults.standard.string(forKey: "CURP") {
            
            if curp == "" {
                return
            }
            
            db.collection("user-test-result").document(curp)
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                  print("Error fetching document: \(error!)")
                  return
              }

              if document.get("call-id") != nil
                  && (document.get("call-id") as? String) != "" {
                  
                  let callID = document.get("call-id")! as? String
                  self.callID = callID
                  self.btnCallDoctor.isEnabled = true
              } else {
                  self.btnCallDoctor.isEnabled = false
              }
              
            }
        }
    }
    
    func calculaasaCorporal() {
        let masaCorporal = self.form.rowBy(tag: "masaCorporal")
        if (self.estatura != nil && self.estatura != "") && (self.peso != nil && self.peso != "") {
            let pesoNum = Float(self.peso)
            let estaturaNum = Float(self.estatura)
            let estaturaCuadrada = estaturaNum! * estaturaNum!
            let masaCorporalNum = pesoNum! / estaturaCuadrada
            
            let roundedVal = String(format: "%.1f", masaCorporalNum)
            
//            masaCorporal?.baseValue = "\(masaCorporalNum)"
            masaCorporal?.baseValue = roundedVal
            masaCorporal?.updateCell()
        }
        
    }
    
    func enableDisableForm() {
//        ProgressHUD.sharedInstance.dismiss()
        let curp = UserDefaults.standard.string(forKey: "CURP")
        var userRegistered = false
        
        if curp != nil && curp != "" {
            userRegistered = true
            self.getUser()
        }
        
        for row in self.form.rows {
            row.baseCell.isUserInteractionEnabled = userRegistered
        }
        
        if userRegistered {
            let realm = try! Realm()
            if let registered = realm.objects(Test.self).filter("curp == '\(curp!)'").first {
                
                let laterDate = Date()
                let interval = laterDate.timeIntervalSince(registered.dateTime)

                let hours = interval.stringFromTimeIntervalToHour()
//                print(hours)
                if  hours < 12 {
                    for row in self.form.rows {
                        row.baseCell.isUserInteractionEnabled = false
                        row.updateCell()
                    }
                } else {
                    for row in self.form.rows {
                        row.baseCell.isUserInteractionEnabled = userRegistered
                        row.updateCell()
                    }
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ProgressHUD.sharedInstance.dismiss()
        }
        
    }
    
    func getUser() {
        let curp = UserDefaults.standard.string(forKey: "CURP")
        
        let realm = try! Realm()
        if let registered = realm.objects(Register.self).filter("curp == '\(curp!)'").first {
            self.lblNombre.text = "\(registered.nombre), puedes realizar el test para saber si necesitas atención médica"
        }
        
    }
    
    func testResult() {
        let formValues = self.form.values()
        
        let pregunta1 = formValues["pregunta1"]! ?? "No"
//        let pregunta2 = formValues["pregunta2"]! ?? "No"
        let pregunta2 = formValues["pregunta3"]! ?? "No"
        let pregunta3 = formValues["pregunta4"]! ?? "No"
        let pregunta4 = formValues["pregunta5"]! ?? "No"
        let pregunta5 = formValues["pregunta6"]! ?? "No"
        let pregunta6 = formValues["pregunta7"]! ?? "No"
        let pregunta7 = formValues["pregunta8"]! ?? "No"
        let pregunta8 = formValues["pregunta9"]! ?? "No"
        let pregunta9 = formValues["pregunta10"]! ?? "No"
        let pregunta10 = formValues["pregunta11"]! ?? "No"
        let pregunta11 = formValues["pregunta12"]! ?? "No"
        let pregunta12 = formValues["pregunta13"]! ?? "No"
        let pregunta13 = formValues["pregunta14"]! ?? "No"
        let pregunta14 = formValues["pregunta15"]! ?? "No"
        let pregunta15 = formValues["pregunta16"]! ?? "No"
        let pregunta16 = formValues["pregunta17"]! ?? "No"
        let pregunta17 = formValues["pregunta18"]! ?? "No"
//        let pregunta19 = formValues["pregunta9"]! ?? "No"
    
        
        
        if (
            ((pregunta3 as? String) == "Si" && (pregunta4 as? String) == "Si") ||
            ((pregunta3 as? String) == "Si" && (pregunta6 as? String) == "Si") ||
            ((pregunta4 as? String) == "Si" && (pregunta6 as? String) == "Si") ||
            ((pregunta3 as? String) == "Si" && (pregunta4 as? String) == "Si" && (pregunta6 as? String) == "Si")
            )
            &&
            (
            (pregunta5 as? String) == "Si" || (pregunta7 as? String) == "Si" ||
            (pregunta8 as? String) == "Si" || (pregunta9 as? String) == "Si" ||
            (pregunta10 as? String) == "Si" || (pregunta12 as? String) == "Si" ||
            (pregunta13 as? String) == "Si" || (pregunta14 as? String) == "Si" ||
            (pregunta15 as? String) == "Si" || (pregunta16 as? String) == "Si" ||
            (pregunta17 as? String) == "Si" || (pregunta11 as? String) == "Si"
            ) {
            
            ProgressHUD.sharedInstance.success(withMessage: "Presentas síntomas sopechosos, te recomendamos solicitar asistencia médica", withDuration: 12.0)
            self.saveInformation(saveOnlyLocal: true)
            self.checkForDoctor()
            
        } else {
            if (pregunta1 as? String) == "Si" ||
                (pregunta2 as? String) == "Si" {

                ProgressHUD.sharedInstance.success(withMessage: "Podrías tener la enfermedad COVID-19 causada por el coronavirus SARS-COV2, sin embargo, al momento no presentas síntomas de alarma, te recomendamos que no salgas de casa si no es necesario (aislamiento 14 días) y sigue las recomendaciones.", withDuration: 12.0)
                self.saveInformation(saveOnlyLocal: true)
                self.checkForDoctor()
            } else {
                ProgressHUD.sharedInstance.success(withMessage: "No te preocupes, no tienes síntomas de COVID-19 o coronavirus, pero sigue las recomendaciones para prevención", withDuration: 12.0)
            }
            
        }
    }
    
    //MARK: - FUNCIONES
    
    func saveOnLocal(dataTest: Test)
    {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(dataTest, update: Realm.UpdatePolicy.modified)
        try! realm.commitWrite()
    }
    
    func saveInformation(saveOnlyLocal: Bool) {
        let dataTest = Test()
        let formValues = self.form.values()
        let curp = UserDefaults.standard.string(forKey: "CURP")
        
        dataTest.curp = curp!
        dataTest.presionSistolica = (formValues["presionSistolica"]! ?? "") as! String
        dataTest.presionDiastolica = (formValues["presionDiastolica"]! ?? "") as! String
        dataTest.frecuenciaCardiaca = (formValues["frecuenciaCardiaca"]! ?? "") as! String
        dataTest.temperatura = (formValues["temperatura"]! ?? "") as! String
        dataTest.estatura = (formValues["estatura"]! ?? "") as! String
        dataTest.peso = (formValues["peso"]! ?? "") as! String
        dataTest.masaCorporal = (formValues["masaCorporal"]! ?? "") as! String
        
        dataTest.cancer = (formValues["cancer"]! ?? "") as! String
        dataTest.diabetes = (formValues["diabetes"]! ?? "") as! String
        dataTest.embarazo = (formValues["embarazo"]! ?? "") as! String
        dataTest.cerebrovascular = (formValues["cerebrovascular"]! ?? "") as! String
        dataTest.digestiva = (formValues["digestiva"]! ?? "") as! String
        dataTest.renal = (formValues["renal"]! ?? "") as! String
        dataTest.cardiovasculares = (formValues["cardiovasculares"]! ?? "") as! String
        dataTest.epoc = (formValues["epoc"]! ?? "") as! String
        dataTest.hipertension = (formValues["hipertension"]! ?? "") as! String
        dataTest.inmunosupresion = (formValues["inmunosupresion"]! ?? "") as! String
        dataTest.lactancia = (formValues["lactancia"]! ?? "") as! String
        
        dataTest.pregunta1 = (formValues["pregunta1"]! ?? "") as! String
//        dataTest.pregunta2 = (formValues["pregunta2"]! ?? "") as! String
        dataTest.pregunta3 = (formValues["pregunta3"]! ?? "") as! String
        dataTest.pregunta4 = (formValues["pregunta4"]! ?? "") as! String
        dataTest.pregunta5 = (formValues["pregunta5"]! ?? "") as! String
        dataTest.pregunta6 = (formValues["pregunta6"]! ?? "") as! String
        dataTest.pregunta7 = (formValues["pregunta7"]! ?? "") as! String
        dataTest.pregunta8 = (formValues["pregunta8"]! ?? "") as! String
        dataTest.pregunta9 = (formValues["pregunta9"]! ?? "") as! String
        
        dataTest.pregunta10 = (formValues["pregunta10"]! ?? "") as! String
        dataTest.pregunta11 = (formValues["pregunta11"]! ?? "") as! String
        dataTest.pregunta12 = (formValues["pregunta12"]! ?? "") as! String
        dataTest.pregunta13 = (formValues["pregunta13"]! ?? "") as! String
        dataTest.pregunta14 = (formValues["pregunta14"]! ?? "") as! String
        dataTest.pregunta15 = (formValues["pregunta15"]! ?? "") as! String
        dataTest.pregunta16 = (formValues["pregunta16"]! ?? "") as! String
        dataTest.pregunta17 = (formValues["pregunta17"]! ?? "") as! String
        dataTest.pregunta18 = (formValues["pregunta18"]! ?? "") as! String
        
        if saveOnlyLocal {
            self.saveOnLocal(dataTest: dataTest)
        }
        
        
        let db = Firestore.firestore()
        
        db.collection("user-test-result").document(curp!).setData([
            "presionSistolica" : dataTest.presionSistolica,
            "presionDiastolica" : dataTest.presionDiastolica,
            "frecuenciaCardiaca" : dataTest.frecuenciaCardiaca,
            "temperatura" : dataTest.temperatura,
            "estatura" : dataTest.estatura,
            "peso" : dataTest.peso,
            "masaCorporal" : dataTest.masaCorporal,
            
            "cancer" : dataTest.cancer,
            "diabetes" : dataTest.diabetes,
            "embarazo" : dataTest.embarazo,
            "cerebrovascular" : dataTest.cerebrovascular,
            "digestiva" : dataTest.digestiva,
            "renal" : dataTest.renal,
            "cardiovasculares" : dataTest.cardiovasculares,
            "epoc" : dataTest.epoc,
            "hipertension" : dataTest.hipertension,
            "inmunosupresion" : dataTest.inmunosupresion,
            "lactancia" : dataTest.lactancia,
            
            "pregunta1" : dataTest.pregunta1,
            "pregunta3" : dataTest.pregunta3,
            "pregunta4" : dataTest.pregunta4,
            "pregunta5" : dataTest.pregunta5,
            "pregunta6" : dataTest.pregunta6,
            "pregunta7" : dataTest.pregunta7,
            "pregunta8" : dataTest.pregunta8,
            "pregunta9" : dataTest.pregunta9,
            
            "pregunta10" : dataTest.pregunta10,
            "pregunta11" : dataTest.pregunta11,
            "pregunta12" : dataTest.pregunta12,
            "pregunta13" : dataTest.pregunta13,
            "pregunta14" : dataTest.pregunta14,
            "pregunta15" : dataTest.pregunta15,
            "pregunta16" : dataTest.pregunta16,
            "pregunta17" : dataTest.pregunta17,
            "pregunta18" : dataTest.pregunta18,
            "call-id":"paciente1",
            
            "curp" : curp!,
        ]) { error in
            if let err = error {
                ProgressHUD.sharedInstance.showError(withMessage: "Error al registrarse \(err)")
            } 
        }
        
    }
    
    
    //MARK: - ACTIONS
    @IBAction func actionRegister(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionOpenCall(_ sender: Any) {
//        guard let url = URL(string: "https://video.e-clinic24.mx/\(self.callID ?? "")") else { return }
//        UIApplication.shared.open(url)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VideoConsultaViewController") as! VideoConsultaViewController
        vc.idConferencia = self.callID
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func actionShowList(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UsersListViewController") as! UsersListViewController
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - Delegados
    func registerSucces(curp: String) {
        let alert = UIAlertController(title: "", message: "Inicio del test aparecer alerta: Este cuestionario es únicamente informativo y no representa un diagnóstico médico, si presentas algún deterioro en tu salud, solicita inmediatamente la atención médica necesaria.  Juntos trabajaremos para prevenir el COVD-19", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "alertShowed")
        
        self.resetForms()
        self.enableDisableForm()
    }
    
    func userListRegisterNew() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func userListUserSelected(dataUser: Register) {
        self.resetForms()
        UserDefaults.standard.set(dataUser.curp, forKey: "CURP")
        self.enableDisableForm()
    }
    
    func resetForms()
    {
        for row in self.form.allRows {
            if row is TextRow {
                row.baseValue = ""
                row.updateCell()
            }
            if row is SegmentedRow<String> {
                row.baseValue = "No"
                row.updateCell()
            }
        }
    }
}

extension TimeInterval{

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)

        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

    }
    
    func stringFromTimeIntervalToHour() -> Int {

        let time = NSInteger(self)

//        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
//        let seconds = time % 60
//        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        return hours

    }
}
