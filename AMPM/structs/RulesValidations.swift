//
//  RulesValidations.swift
//  AMPM
//
//  Created by CHERNANDER04 on 28/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation
import Eureka

public struct RuleMaxLength: RuleType {

    let max: UInt

    public var id: String?
    public var validationError: ValidationError

    public init(maxLength: UInt, msg: String? = nil){
        let ruleMsg = msg ?? "solo \(maxLength) caracteres"
        max = maxLength
        validationError = ValidationError(msg: ruleMsg)
    }

    public func isValid(value: String?) -> ValidationError? {
        guard let value = value else { return nil }
        return value.count > Int(max) ? validationError : nil
    }
}
