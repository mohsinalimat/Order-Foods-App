//
//  CartViewController.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/6/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate  {
 
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartBottomView: UIView!
    @IBOutlet weak var sumOfPrices: UILabel!
    static var products: [cartFood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        setShadowRadius(cartBottomView, false, 1, 0.2, -2)
        
        sumOfPricesfunc()
        // Do any additional setup after loading the view.

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewController.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cartTableView.rowHeight = 120
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.delegate = self
        cell.cartCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.cartCellView.layer.shadowColor = UIColor.black.cgColor
        cell.cartCellView.layer.masksToBounds = false
        cell.cartCellView.layer.shadowRadius = 1
        cell.cartCellView.layer.shadowOpacity = 0.5
        cell.cartCellView.layer.cornerRadius = 15
        
        cell.stepperView.text = String(CartViewController.products[indexPath.row].count!)
        cell.stepper.value = Double(CartViewController.products[indexPath.row].count!)
        cell.name.text = CartViewController.products[indexPath.row].name
        
        cell.price.text = CartViewController.products[indexPath.row].price
        
        return cell
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "order") as! OrderViewController
        
        FVC.products = CartViewController.products
        FVC.price = sumOfPrices.text!
        
        if !CartViewController.products.isEmpty {
            self.navigationController?.pushViewController(FVC, animated: true)
        }
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
    
    func reloadTabViewData() {
        cartTableView.reloadData()
    }
    func reloadSum(){
        sumOfPricesfunc()
    }
    
    func sumOfPricesfunc()  {
        var sum = 0
        for i in 0..<CartViewController.products.count {
            let string: String = CartViewController.products[i].price!
            let strArray = string.components(separatedBy: CharacterSet.decimalDigits.inverted)
            var s = ""
            for item in strArray {
                if Int(item) != nil {
                    s += item
                }
            }
            sum += Int(s)! * CartViewController.products[i].count!
        }
        sumOfPrices.text = String(sum)
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
