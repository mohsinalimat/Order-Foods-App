//
//  CartTableViewCell.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/6/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func reloadTabViewData()
    func reloadSum()
}

class CartTableViewCell: UITableViewCell {
    
    weak var delegate: CartTableViewCellDelegate?
    
    @IBOutlet weak var cartCellView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stepperView: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func stepper(_ sender: UIStepper) {
        
        for index in 0..<CartViewController.products.count {
            if self.name.text == CartViewController.products[index].name {
                CartViewController.products[index].count = Int(sender.value)
                break
            }
        }
        
        stepperView.text = String(Int(sender.value))
        delegate?.reloadSum()
        if stepperView.text == "0" {
            for index in 0..<CartViewController.products.count{
                if CartViewController.products[index].name == self.name.text {
                    CartViewController.products.remove(at: index)
                    delegate?.reloadTabViewData()
                    break
                }
            }
        }

    }
    
    
    
}
