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
    
    func getFakePointsList() -> [Point]
    {
        
        var pointsList = [Point]()
        
        var point = Point(Name: "Pico do pontal",
                          Local: "Camboinha - João Pessoa  PB - Brasil",
                          Latitude: "-7.0000000",
                          Longitude: "-34.8166667")
        
        pointsList.append(point)
        
        point = Point(Name: "Praia da areia preta",
                      Local: "Marataízes - ES - Brasil",
                      Latitude: "-21.0333333",
                      Longitude: "-40.8333333")
        
        pointsList.append(point)
        
        point = Point(Name: "Praia da areia preta",
                      Local: "Marataízes - ES - Brasil",
                      Latitude: "-21.0333333",
                      Longitude: "-40.8333333")
        
        pointsList.append(point)
        
        point = Point(Name: "Praia da areia preta",
                      Local: "Marataízes - ES - Brasil",
                      Latitude: "-21.0333333",
                      Longitude: "-40.8333333")
        
        pointsList.append(point)
        
        point = Point(Name: "Praia da areia preta",
                      Local: "Marataízes - ES - Brasil",
                      Latitude: "-21.0333333",
                      Longitude: "-40.8333333")
        
        pointsList.append(point)
        
        
        return pointsList
        
    }
}
