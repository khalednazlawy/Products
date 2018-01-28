//
//  ViewController.swift
//  products
//
//  Created by khaled nazlawy on 1/26/18.
//  Copyright © 2018 khaled nazlawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var productArray = [Items]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAPI ()
}
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : product = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! product
     
        
        cell.labelPrice.text = "\((String(describing: productArray[indexPath.row].price!))) $"
        cell.labelDescrption.text = productArray[indexPath.row].descrption
        cell.photo = productArray[indexPath.row]
        
        return cell
    }
func requestAPI() {
    Alamofire.request("http://grapesnberries.getsandbox.com/products?count=10&from=1")
        .responseJSON { (response) in
            switch response.result{
                    
                case .failure(let error) :
                    print(error)
                case . success(let value) :
                    let json = JSON(value)
                    
                    
                    let dataArray = json.array // [{},{},{},{}]
                    for data in dataArray!{
                        guard let data = data.dictionary else {return}
                        let price = data["price"]?.int ?? 0
                        print(price)
                        let desc = data["productDescription"]?.string ?? ""
                        print(desc)
                        let  imageUrl = data["image"]!["url"].string ?? ""
                        print(imageUrl)
                        
                        let item = Items()
                        item.price = price
                        item.descrption = desc
                        item.image = imageUrl
                       self.productArray.append(item)
                        
                    }
                    self.collectionView.reloadData()
                    
                }
                
        }
    }
}











