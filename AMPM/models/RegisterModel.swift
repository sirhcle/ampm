//
//  RegisterModel.swift
//  AMPM
//
//  Created by CHERNANDER04 on 05/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation
import RealmSwift

class Register: Object {
    @objc dynamic var apPaterno = ""
    @objc dynamic var apMaterno = ""
    @objc dynamic var nombre = ""
    @objc dynamic var sexo = ""
    @objc dynamic var fNacimiento = ""
    @objc dynamic var edad = ""
    @objc dynamic var curp = ""
    @objc dynamic var cp = ""
    @objc dynamic var pais = ""
    @objc dynamic var estado = ""
    @objc dynamic var condado = ""
    @objc dynamic var ciudad = ""
    @objc dynamic var calle = ""
    @objc dynamic var telefono = ""
    
    override class func primaryKey() -> String? {
        return "curp"
    }
}
