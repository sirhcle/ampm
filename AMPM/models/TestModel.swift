//
//  TestModel.swift
//  AMPM
//
//  Created by CHERNANDER04 on 06/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation
import RealmSwift

class Test: Object {
    
    @objc dynamic var dateTime:Date = Date()
    @objc dynamic var presionSistolica = ""
    @objc dynamic var presionDiastolica = ""
    @objc dynamic var frecuenciaCardiaca = ""
    @objc dynamic var temperatura = ""
    @objc dynamic var estatura = ""
    @objc dynamic var peso = ""
    @objc dynamic var masaCorporal = ""
    
    @objc dynamic var cancer = ""
    @objc dynamic var diabetes = ""
    @objc dynamic var embarazo = ""
    @objc dynamic var cerebrovascular = ""
    @objc dynamic var digestiva = ""
    @objc dynamic var renal = ""
    @objc dynamic var cardiovasculares = ""
    @objc dynamic var epoc = ""
    @objc dynamic var hipertension = ""
    @objc dynamic var inmunosupresion = ""
    @objc dynamic var lactancia = ""
    
    @objc dynamic var pregunta1 = ""
//    @objc dynamic var pregunta2 = ""
    @objc dynamic var pregunta3 = ""
    @objc dynamic var pregunta4 = ""
    @objc dynamic var pregunta5 = ""
    @objc dynamic var pregunta6 = ""
    @objc dynamic var pregunta7 = ""
    @objc dynamic var pregunta8 = ""
    @objc dynamic var pregunta9 = ""
    
    @objc dynamic var pregunta10 = ""
    @objc dynamic var pregunta11 = ""
    @objc dynamic var pregunta12 = ""
    @objc dynamic var pregunta13 = ""
    @objc dynamic var pregunta14 = ""
    @objc dynamic var pregunta15 = ""
    @objc dynamic var pregunta16 = ""
    @objc dynamic var pregunta17 = ""
    @objc dynamic var pregunta18 = ""
    
    @objc dynamic var curp = ""
    
    override class func primaryKey() -> String? {
        return "curp"
    }

}
