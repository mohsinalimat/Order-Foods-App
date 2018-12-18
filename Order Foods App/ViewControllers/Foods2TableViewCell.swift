//
//  Foods2TableViewCell.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/3/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class Foods2TableViewCell: UITableViewCell {
    
    weak var delegate: CartTableViewCellDelegate?

    @IBOutlet weak var foods2CellView: UIView!
    @IBOutlet weak var foods2CellImage: UIImageView!
    @IBOutlet weak var foods2CellName: UILabel!
    @IBOutlet weak var foods2CellDescription: UILabel!
    @IBOutlet weak var foods2CellPrice: UILabel!
    @IBOutlet weak var foods2Stepper: UIStepper!
    @IBOutlet weak var foods2ButtonView: UIView!
    @IBOutlet weak var foods2Button: UIButton!
    @IBOutlet weak var foods2StepperLabel: UILabel!
    @IBOutlet weak var foods2CounterView: UIView!
    
    @IBAction func foods2CartButtonTouch(_ sender: UIButton) {
        addToCart()
        
        foods2ButtonView.frame.size.width = 94
        
        for constraint in foods2ButtonView.constraints {
            if constraint.identifier == "btnViewWidth" {
                constraint.constant = 94
            }
        }
        
        foods2Stepper.isHidden = false
        foods2CounterView.isHidden = false
        foods2Button.isHidden = true
        
        foods2Stepper.value = 1
        foods2StepperLabel.text = "1"
    }
    
    @IBAction func foods2Stepper(_ sender: UIStepper) {
        foods2StepperLabel.text = String(Int(sender.value))
        
        if sender.value == 0 {
            for constraint in foods2ButtonView.constraints {
                if constraint.identifier == "btnViewWidth" {
                    constraint.constant = 60
                }
            }
            foods2Stepper.isHidden = true
            foods2CounterView.isHidden = true
            foods2Button.isHidden = false
        }
        
        for index in 0..<CartViewController.products.count {
            if self.foods2CellName.text == CartViewController.products[index].name {
                CartViewController.products[index].count = Int(sender.value)
                break
            }
        }
        
        if self.foods2StepperLabel.text! == "0"{
            removeAtCart()
        }
        
    }
    
    func addToCart(){
        let food = cartFood(foods2CellName.text!, "1", foods2CellPrice.text,1)
        for index in 0..<CartViewController.products.count {
            if food.name == CartViewController.products[index].name {
                return
            }
        }
        CartViewController.products.append(food)
        
    }
    
    func removeAtCart(){
        let food = cartFood(foods2CellName.text!, "1", foods2CellPrice.text,1)
        for index in 0..<CartViewController.products.count{
            if CartViewController.products[index].name == food.name {
                CartViewController.products.remove(at: index)
                break
            }
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
