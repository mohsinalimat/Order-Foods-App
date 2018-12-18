//
//  OrderViewController.swift
//  Order Foods App
//
//  Created by Gerasim Israyelyan on 12/6/18.
//  Copyright © 2018 Gerasim Israyelyan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class OrderViewController: UIViewController, UISearchBarDelegate, LocateOnTheMap {
    
    var products: [cartFood] = []
    var price = ""
    var productsStr = ""
    var dateOfDelivery = "Հիմա"
    var payMethod = "Կանխիկ"
    
    @IBOutlet weak var googleMapContainer: UIView!
    var googleMapsView: GMSMapView!
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var datePicker: UIDatePicker?
    

    @IBOutlet weak var dateSegment: UISegmentedControl!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var prices: UILabel!
    
    var textfields : [UITextField] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textfields  = [dateField, adressField, nameField, phoneNumberField]
        
        topLinear(payView)
        topLinear(timeView)
        topLinear(commentView)
        
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowRadius = 1
        bottomView.layer.shadowOpacity = 0.2
        // Do any additional setup after loading the view.
        
        datePicker = UIDatePicker()
        datePicker?.locale = NSLocale(localeIdentifier: "hy_AM") as Locale
        dateField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(OrderViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(OrderViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        prices.text = price
        
        for i in 0..<products.count {
            productsStr += "<p>\(products[i].name!) : \(products[i].price!) : \(products[i].count!) հատ</p>"
        }
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, HH:mm"
        dateFormatter.locale = NSLocale(localeIdentifier: "hy_AM") as Locale
        dateField.text = dateFormatter.string(from: datePicker.date)
        dateOfDelivery = dateField.text!
//        view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer ) {
        view.endEditing(true)
    }
    
    @IBAction func orderButton(_ sender: UIButton) {
        if dateSegment.selectedSegmentIndex == 1 {
            guard let first = textfields[0].text, first != "" else {
                alertFailed()
                return
            }
        }
        guard let second = textfields[1].text, second != "" else {
            alertFailed()
            return
        }
        guard let third = textfields[2].text, third != "" else {
            alertFailed()
            return
        }
        guard let forth = textfields[3].text, forth != "" else {
            alertFailed()
            return
        }
        
        sendMail()
        
    }
    
    func alertFailed() {
        let alert = UIAlertController(title: "Սխալ !!", message: "Խնդրում ենք լրացնել բոլոր դաշտերը", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert,animated: true,completion: nil)
    }
    
    func alertSuccesful() {
        let alert = UIAlertController(title: "Պատվերը հաջողությամբ կատարվել է", message: "Մեր օպերատորը կկապնվի Ձեզ հետ", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action) in
     
            let storyb = UIStoryboard(name: "Main", bundle: nil)
            let FVC = storyb.instantiateViewController(withIdentifier: "main") as! UINavigationController
//            self.navigationController?.pushViewController(FVC, animated: true)
            self.present(FVC,animated: true,completion: nil)
            
        }
        
        alert.addAction(okAction)
        
        self.present(alert,animated: true,completion: nil)
    }
    
    func sendMail() {
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "gerasimm1003@gmail.com"
        smtpSession.password = "aperon1003"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Օպերատոր", mailbox: "gerasim1003@mail.ru")]
        builder.header.from = MCOAddress(displayName: "Պատվիրատու", mailbox: "gerasimm1003@gmail.com")
        builder.header.subject = "Նոր Պատվեր"
        builder.htmlBody="\(productsStr)<p><b>Հասցե<b> : \(adressField.text!)</p><p><b>Անուն</b> : \(nameField.text!)</p><p><b>Հեռախոսահամար</b> : \(phoneNumberField.text!)</p><p><b>Պատվերի Ժամանակը : \(dateOfDelivery)</b></p><p><b>Վճարման Եղանակը : \(payMethod)</b></p><p><b>Մեկնաբանություն : \" \(commentField.text!) \"</b></p><p><b>Ընդհանուր Գումարը : \(prices.text!) դրամ</b></p>"
        
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
                
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let alert = UIAlertController(title: "Սխալ !!", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okAction)
                
                self.present(alert,animated: true,completion: nil)
                
                
            } else {
                NSLog("Successfully sent email!")
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.alertSuccesful()

                
            }
        }
        
        
        
    }
    
    
    @IBAction func dataSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            
            self.dateField.isEnabled = true
            self.dateField.becomeFirstResponder()
        } else {
            self.dateField.isEnabled = false
            self.dateField.text = ""
            dateOfDelivery = "Հիմա"
        }
    }
    
    @IBAction func paySegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            payMethod = "Կանխիկ"
        } else {
            payMethod = "Քարտով"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.googleMapsView = GMSMapView(frame: googleMapContainer.frame)
        self.googleMapContainer.addSubview(self.googleMapsView)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
    }
    
    @IBAction func adressEdit(_ sender: UITextField) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController,animated: true,completion: nil)
        
    }
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.googleMapsView.camera = camera
            
            marker.title = "Address : \(title)"
            marker.map = self.googleMapsView
            
        }
    }
    
    func setAdress(adress: String) {
        adressField.text = adress
    }
    
    func topLinear(_ view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 0
        view.layer.shadowOpacity = 0.1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()

        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in

            self.resultsArray.removeAll()
            if results == nil {
                return
            }

            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }

            self.searchResultController.reloadDataWithArray(self.resultsArray)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
