//
//  ViewController.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 11/11/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    var firebaseStorage = Storage()

    var categories: [Category] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        //Firebase
        ref = Database.database().reference()

        ref.child("Category").observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.categories.removeAll()
                for i in snapshot.children.allObjects as![DataSnapshot]{
                    let data = i.value as? [String: AnyObject]
                    let name = data?["name"]
                    let image = data?["image"]
                    let productCategories = data?["productCategories"]
                    
                    let cat = Category(name as! String, image as! String, productCategories)
                    self.categories.append(cat)

                }
                self.tableView.reloadData()
            }
            })

   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        self.tableView.rowHeight = 180
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoriesTableViewCell

        cell1.categoryCellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell1.categoryCellView.layer.shadowColor = UIColor.black.cgColor
        cell1.categoryCellView.layer.masksToBounds = false
        cell1.categoryCellView.layer.shadowRadius = 3
        cell1.categoryCellView.layer.shadowOpacity = 0.8

        cell1.categoryCellView.layer.cornerRadius = 15
        cell1.categoryCellImage.layer.cornerRadius = 15
        cell1.categoryCellImage.layer.masksToBounds = true
        
        cell1.categoryName.text = categories[indexPath.row].name
        
        cell1.categoryView2.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell1.categoryView2.layer.opacity = 0.3
        cell1.categoryView2.layer.cornerRadius = 15
        cell1.categoryView2.layer.masksToBounds = true

        
//        let url = URL(string: categories[indexPath.row].image!)
//        let dt = try? Data(contentsOf: url!)
//        let imageView = UIImageView()
//
//        if let imageData = dt {
//            let image = UIImage(data: imageData)
//            imageView.image = image
//        }
//
//        cell?.backgroundView = imageView
        let imageName = categories[indexPath.row].image!
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)

        imageView.image = image
//        cell?.backgroundView = imageView
//        cell1.categoryCellView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.137254902, blue: 0.2941176471, alpha: 1)
        cell1.categoryCellImage.image = image
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        selectedIndex = indexPath.row
        let storyb = UIStoryboard(name: "Main", bundle: nil)
        let FVC = storyb.instantiateViewController(withIdentifier: "FoodsViewController") as! FoodsViewController
        self.navigationController?.pushViewController(FVC, animated: true)

        if categories[selectedIndex].productCategories != nil{
            FVC.productCategories = categories[selectedIndex].productCategories!
        }
        FVC.categories = categories

        FVC.currentCategoryButton.setTitle(categories[indexPath.row].name!, for: .normal)
        
    }
    

}
