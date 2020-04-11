//
//  StructFormElements.swift
//  AMPM
//
//  Created by CHERNANDER04 on 03/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation

struct TextRowConfiguration {
    var tag:String? = ""
    var title:String? = ""
}

struct LabelRowConfiguration {
    var title:String? = ""
}

struct SegmentedRowConfiguration {
    var title: String? = ""
    var options: [String]? = []
    var value: String? = ""
    var tag: String? = ""
}
