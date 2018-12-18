//
//  FoodsViewController.swift
//  
//
//  Created by Gerasim Israyelyan on 11/18/18.
//

import UIKit
import FirebaseDatabase

class FoodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories: [Category] = []
    var productCategories: [ProductCategory?]? = []
    
    @IBOutlet weak var foodsTableView: UITableView!
    @IBOutlet weak var currentCategoryButton: UIButton!
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet var foodsStackView: UIStackView!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        foodsTableView.delegate = self
        foodsTableView.dataSource = self
        setMenuItemTitles()
        currentCategoryButton.setTitle(currentCategoryButton.currentTitle! + " ⌄" as String?, for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCategories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.foodsTableView.rowHeight = 207
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodsCell", for: indexPath) as! FoodsTableViewCell

        cell.foodsCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.foodsCellView.layer.shadowColor = UIColor.black.cgColor
        cell.foodsCellView.layer.masksToBounds = false
        cell.foodsCellView.layer.shadowRadius = 1
        cell.foodsCellView.layer.shadowOpacity = 0.5
        
        cell.foodsCellView.layer.cornerRadius = 15
        
        cell.foodsCellImage1.image = UIImage(named: productCategories![indexPath.row]!.image!)
        cell.foodsCellImage1.layer.cornerRadius = 15
        cell.foodsCellImage2.image = UIImage(named: productCategories![indexPath.row]!.icon!)
        
        cell.foodsCellLabel.text = productCategories![indexPath.row]!.name
        
//        cell?.textLabel?.text = foods![indexPath.row]!.name
//        cell?.imageView?.image = UIImage(named: foods![indexPath.row]!.image!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "foods2ViewController") as! Foods2ViewController
        
        FVC.foods2toptitle = productCategories![indexPath.row]!.name!
        FVC.foods2topicon = productCategories![indexPath.row]!.icon!
        FVC.foodstopimage = productCategories![indexPath.row]!.image!
        
        FVC.products = productCategories![indexPath.row]!.products
        
//        FVC.foods2TopTitle.text = productCategories![indexPath.row]!.name
//        FVC.food.name = foods![indexPath.row]!.name
//        FVC.food.image = foods![indexPath.row]!.image
//        FVC.food.price = foods![indexPath.row]!.price


        self.navigationController?.pushViewController(FVC, animated: true)

    }
    
    @IBAction func selection(_ sender: UIButton) {

        
        categoryButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.1, animations: {
                
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
                
                    for constraint in self.mainView.constraints {
                        if constraint.identifier == "FoodsTableViewTop" {
                            if !button.isHidden {
                                constraint.constant = self.foodsStackView.frame.height
                            } else {
                                constraint.constant = 0
                            }
                        }
                    }
                
            })
            
        }
    }
    @IBAction func menuItemsAction(_ sender: UIButton) {
        for (index, value) in categoryButtons.enumerated() {
            if value.currentTitle == sender.currentTitle {
                if categories[index].productCategories != nil {
                    self.productCategories = categories[index].productCategories

                } else {
                    self.productCategories = []
                }
                break
            }
        }
        UIView.transition(with: foodsTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.foodsTableView.reloadData()}, completion: nil)
        categoryButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.1, animations: {
                
                button.isHidden = true
                self.view.layoutIfNeeded()
                
                for constraint in self.mainView.constraints {
                    if constraint.identifier == "FoodsTableViewTop" {
                        constraint.constant = 0
                    }
                }
                
            })
            
        }

    }
    
    func setMenuItemTitles() {
        var k = 0
        for i in 0..<categories.count {
            if currentCategoryButton.currentTitle == categories[i].name{
                continue
            }
            categoryButtons[k].setTitle(categories[i].name, for: .normal)
            k += 1
        }
    }
    
    @IBAction func cartButton(_ sender: UIBarButtonItem) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.navigationController?.pushViewController(FVC, animated: true)
    }
    
}


