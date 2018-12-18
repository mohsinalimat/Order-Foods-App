//
//  cartFood.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/12/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class cartFood {
    var name: String?
    var image: String?
    var price: String?
    var count: Int? = 0
    
    init(_ name: String,_ image: String,_ price: String?,_ count: Int) {
        self.name = name
        self.image = image
        if price != nil {
            self.price = price
        } else {
            self.price = ""
        }
        self.count = count
    }
    
    
}
