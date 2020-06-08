//
//  CellRegistrados.swift
//  AMPM
//
//  Created by CHERNANDER04 on 09/04/20.
//  Copyright © 2020 Liverpool. All rights reserved.
//

import UIKit

class CellRegistrados: UITableViewCell {
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCURP: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblNombre.text = ""
        self.lblCURP.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    

}
