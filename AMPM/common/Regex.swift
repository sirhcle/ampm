//
//  Regex.swift
//  AMPM
//
//  Created by CHERNANDER04 on 29/03/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation

func regexCURP(curp: String) {
    
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
