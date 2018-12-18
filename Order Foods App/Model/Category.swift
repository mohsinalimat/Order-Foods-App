//
//  Category.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 11/13/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class Category {
    var name: String?
    var image: String?
    var productCategories: [ProductCategory]?
    private var prCat: [ProductCategory] = []
    
    init(_ name: String,_ image: String, _ productCategories: AnyObject?) {
        self.name = name
        self.image = image
        if productCategories != nil{
            for obj in 1...(productCategories!.count){
                
                let productCategory = ProductCategory(((productCategories!["0\(obj)"] as AnyObject).allObjects[3] as! String), ((productCategories!["0\(obj)"] as AnyObject).allObjects[2] as! String), ((productCategories!["0\(obj)"] as AnyObject).allObjects[1] as! String), ((productCategories!["0\(obj)"] as AnyObject).allObjects[0] as AnyObject))
                prCat.append(productCategory)
                
            }
            self.productCategories = prCat
        }
        
    }
    
    
}
