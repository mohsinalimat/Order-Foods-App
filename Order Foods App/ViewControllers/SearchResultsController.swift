//
//  SearchResultsController.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/16/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit

protocol LocateOnTheMap{
    func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
    func setAdress(adress: String)
}

class SearchResultsController: UITableViewController {
    
    var searchResults: [String]!
    var delegate: LocateOnTheMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResults = Array()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        cell.textLabel?.text = self.searchResults[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){

        self.delegate.setAdress(adress: searchResults[indexPath.row])
        // 1
        self.dismiss(animated: true, completion: nil)
        // 2
        let urlpath = "https://maps.googleapis.com/maps/api/geocode/json?address=\(self.searchResults[indexPath.row])&sensor=false&key=AIzaSyDiwZBRagHN-kSuV5Y2X9PjoXVWGxNH8w0".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let url = URL(string: urlpath!)
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
            // 3
            
            do {
                if data != nil {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                    if (dic.value(forKey: "status") as! String) != "OVER_QUERY_LIMIT"{
                        
                        let lat =   (((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "lat")) as! Double
                        
                        let lon =   (((((dic.value(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "geometry") as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "lng")) as! Double
                        // 4
                        self.delegate.locateWithLongitude(lon, andLatitude: lat, andTitle: self.searchResults[indexPath.row])
                    } else {
                        print("OVER_QUERY_LIMIT")
                    }
                } else {
                    print("!!!!  not Data  !!!!!")
                }
                
            }catch {
                print("Error")
            }
        }
        // 5
        task.resume()
    }
    
    
    func reloadDataWithArray(_ array:[String]){
        self.searchResults = array
        self.tableView.reloadData()
    }
    
}
