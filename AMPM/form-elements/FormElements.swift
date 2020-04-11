//
//  FormElements.swift
//  AMPM
//
//  Created by CHERNANDER04 on 03/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import Foundation
import Eureka



class FormElements {
    
    class func TextRowElement(parameters: TextRowConfiguration) -> TextRow {
        let textfieldColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        
        return TextRow() { row in
            row.title = parameters.title
            row.tag = parameters.tag
        }.cellUpdate({ (cell, row) in
            cell.titleLabel?.textColor = titleColor
            cell.textField.textColor = textfieldColor
        })
    }
    
    class func TextRowElement(parameters: TextRowConfiguration, keyboardType: UIKeyboardType) -> TextRow {
        
        return self.TextRowElement(parameters: parameters).cellSetup { (cell, row) in
            cell.textField.keyboardType = keyboardType
        }
        
    }
    
    class func LabelRowElement(parameters: LabelRowConfiguration) -> LabelRow {
//        let textfieldColor = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        
        return LabelRow() { row in
            row.title = parameters.title
            row.cell.textLabel?.numberOfLines = 0
        }.cellUpdate { (cell, row) in
            cell.textLabel?.textColor = titleColor
        }
    }
    
    class func SegmentedRowElement(parameters: SegmentedRowConfiguration) -> SegmentedRow<String> {
        let titleColor = UIColor.init(red: 0.0/255.0, green: 117.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        let segmentedSelected = UIColor.init(red: 242.0/255.0, green: 138.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        let segmentedNormal = UIColor.white
        
        return SegmentedRow<String>() {
            $0.title = parameters.title
            $0.options = parameters.options
            $0.value = parameters.value
            $0.tag = parameters.tag
        }.cellUpdate { cell, row in
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
    }
    
    
}
