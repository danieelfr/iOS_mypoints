//
//  PointsBusiness.swift
//  mypoints
//
//  Created by user127656 on 4/28/17.
//  Copyright © 2017 danielfr. All rights reserved.
//

import Foundation


class PointsBusiness
{
    
    func getFakePointsList() -> [(String, String, String, String)]
    {
        
        var teste = [(pointName:String, local:String, latitude:String, longitude:String)]()
        teste.append(("Praia do camelo","Fernando de Noronha  PE - Brasil","-3.8500000","-32.46667"))
        teste.append(("Pico do pontal","Camboinha - João Pessoa  PB - Brasil","-7.0000000","-34.8166667"))
        teste.append(("Praia da areia preta","Marataízes ES","-21.0333333","-40.8333333"))
                     
        return teste
        
    }
}
