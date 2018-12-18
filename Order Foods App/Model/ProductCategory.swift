//
//  ProductCategory.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/11/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class ProductCategory {
    var name: String?
    var image: String?
    var icon: String?
    var products: [Food]?
    private var fds: [Food] = []
    
    init(_ name: String,_ image: String,_ icon: String,_ foods: AnyObject?) {
        self.name = name
        self.image = image
        self.icon = icon
        if foods != nil{
            for obj in 1...(foods!.count){
                let food = Food(((foods!["0\(obj)"] as AnyObject).allObjects[3] as! String), ((foods!["0\(obj)"] as AnyObject).allObjects[2] as! String),((foods!["0\(obj)"] as AnyObject).allObjects[0] as! String), ((foods!["0\(obj)"] as AnyObject).allObjects[1] as! String) )
                fds.append(food)
            }
            self.products = fds
        }
        
    }
    
    
}
