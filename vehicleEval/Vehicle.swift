//
//  Vehicles.swift
//  vehicleEval
//
//  Created by LouieDavis on 7/19/17.
//  Copyright © 2017 jpsautner. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Vehicle {
    let feScore: Int
    let fuelCost: Int
    let make: String
    let model: String
    let year: Int
    
    init(json: JSON) {
        self.feScore = json["feScore"].intValue
        self.fuelCost = json["fuelCost08"].intValue
        self.make = json["make"].stringValue
        self.model = json["model"].stringValue
        self.year = json["year"].intValue
    }
    
}
