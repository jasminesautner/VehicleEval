//
//  CustomModelsTableViewCell.swift
//  vehicleEval
//
//  Created by LouieDavis on 7/25/17.
//  Copyright © 2017 jpsautner. All rights reserved.
//

import Foundation
import SwiftyJSON

class CustomModelTableViewCell: UITableViewCell {
    
    var make: String?
    var model: String?
    var year: Int?
    var feScore: Int?
    
    @IBOutlet weak var vehicleModelMake: UILabel!
  
    @IBOutlet weak var vehicleYear: UILabel!
    
    @IBOutlet weak var vehicleFeScore: UILabel!
    
    
}
