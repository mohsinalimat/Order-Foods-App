//
//  File.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 11/19/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class Food {
    var name: String?
    var image: String?
    var price: String?
    var description: String?
    
    init(_ name: String,_ image: String,_ price: String?, _ dscrp: String?) {
        self.name = name
        self.image = image
        self.description = dscrp
        if price != nil {
            self.price = price
        } else {
            self.price = ""
        }
    }
    
    
}
