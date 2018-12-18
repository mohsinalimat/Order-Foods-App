//
//  FoodViewController.swift
//  
//
//  Created by Gerasim Israyelyan on 11/29/18.
//

import UIKit

class FoodViewController: UIViewController {

    var food: Food = Food("", "", "", "")
    var icon = ""
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topIcon: UIImageView!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var foodComment: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var StepperLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func foodStepper(_ sender: UIStepper) {
        StepperLabel.text = String(Int(sender.value))
        
        if self.StepperLabel.text! == "0"{
            removeAtCart()
        }
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        if Int(StepperLabel.text!) != 0 {
            
            addToCart()
            for index in 0..<CartViewController.products.count {
                if self.topName.text == CartViewController.products[index].name {
                    CartViewController.products[index].count = Int(StepperLabel.text!)
                    break
                }
            }
            
        }
        
        StepperLabel.text = "0"
        stepper.value = 0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topName.text = food.name!
        topImage.image = UIImage(named: food.image!)
        price.text = food.price!
        topIcon.image = UIImage(named: icon)
        
        setShadowRadius(topView, true, 1, 0.5, 0)
        setShadowRadius(foodComment, true, 1, 0.5, 0)
        setShadowRadius(bottomView, false, 1, 0.2, -2)
        
    }
    
    @IBAction func Cart(_ sender: UIBarButtonItem) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.navigationController?.pushViewController(FVC, animated: true)
    }
    
    
    func setShadowRadius(_ View: AnyObject,_ cornerRadius: Bool,_ shadowRadius: CGFloat,_ shadowOpacity: Float, _ height: Int ) {
        View.layer.shadowOffset = CGSize(width: 0, height: height)
        View.layer.shadowColor = UIColor.black.cgColor
        View.layer.masksToBounds = false
        View.layer.shadowRadius = shadowRadius
        View.layer.shadowOpacity = shadowOpacity
        if cornerRadius{
            View.layer.cornerRadius = 15
        }
        
    }
    
    func addToCart(){
        let food = cartFood(topName.text!, "1", price.text,1)
        for index in 0..<CartViewController.products.count {
            if food.name == CartViewController.products[index].name {
                return
            }
        }
        CartViewController.products.append(food)
        
    }
    
    func removeAtCart(){
        let food = cartFood(topName.text!, "1", price.text,1)
        for index in 0..<CartViewController.products.count{
            if CartViewController.products[index].name == food.name {
                CartViewController.products.remove(at: index)
                break
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
