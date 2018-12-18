//
//  Foods2ViewController.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/3/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

class Foods2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var foods2TableView: UITableView!
    @IBOutlet weak var foods2TopView: UIView!
    @IBOutlet weak var foods2TopIcon: UIImageView!
    @IBOutlet weak var foods2TopTitle: UILabel!
    @IBOutlet weak var foodsTopImage: UIImageView!
    
    var products: [Food]?

    var foods2toptitle: String = ""
    var foodstopimage = ""
    var foods2topicon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foods2TableView.delegate = self
        foods2TableView.dataSource = self

        // Do any additional setup after loading the view.
        
        setShadowRadius(foods2TopView)
        foods2TopTitle.text = foods2toptitle
        foodsTopImage.image = UIImage(named: foodstopimage)
        foods2TopIcon.image = UIImage(named: foods2topicon)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        foods2TableView.rowHeight = 152
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foods2Cell", for: indexPath) as! Foods2TableViewCell
        
        cell.foods2CellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.foods2CellView.layer.shadowColor = UIColor.black.cgColor
        cell.foods2CellView.layer.masksToBounds = false
        cell.foods2CellView.layer.shadowRadius = 1
        cell.foods2CellView.layer.shadowOpacity = 0.5
        cell.foods2CellView.layer.cornerRadius = 15
        
        cell.foods2CellImage.layer.masksToBounds = true
        cell.foods2CellImage.layer.cornerRadius = 10
        
        cell.foods2CellName.text = products![indexPath.row].name
        cell.foods2CellImage.image = UIImage(named: products![indexPath.row].image!)
        cell.foods2CellPrice.text = products![indexPath.row].price! + " դրամ"
        cell.foods2CellDescription.text = products![indexPath.row].description
                
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "FoodView") as! FoodViewController
        FVC.food = products![indexPath.row]
        FVC.icon = foods2topicon
        self.navigationController?.pushViewController(FVC, animated: true)
    }
    
    @IBAction func Cart(_ sender: UIBarButtonItem) {
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController

        self.navigationController?.pushViewController(FVC, animated: true)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setShadowRadius(_ View: AnyObject) {
        View.layer.shadowOffset = CGSize(width: 0, height: 0)
        View.layer.shadowColor = UIColor.black.cgColor
        View.layer.masksToBounds = false
        View.layer.shadowRadius = 1
        View.layer.shadowOpacity = 0.5
        View.layer.cornerRadius = 15
        
    }

}

