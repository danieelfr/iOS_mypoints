//
//  Point.swift
//  mypoints
//
//  Created by Daniel Fonseca Reis on 5/23/17.
//  Copyright © 2017 danielfr. All rights reserved.
//

import UIKit

class Point {
    
    var Name:String
    var Local:String
    var Latitude:String
    var Longitude:String

    init(Name:String,Local:String,Latitude:String,Longitude:String) {
        
        self.Name = Name
        self.Local = Local
        self.Latitude = Latitude
        self.Longitude = Longitude
    
    }
}
