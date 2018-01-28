//
//  product.swift
//  products
//
//  Created by khaled nazlawy on 1/26/18.
//  Copyright © 2018 khaled nazlawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class product: UICollectionViewCell {
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelDescrption: UILabel!
    
    
    var photo: Items? {
        didSet {
            guard let photo = photo else { return }
            Alamofire.request(photo.image!).response { response in
                if let data = response.data, let image = UIImage(data: data) {
                    self.imageViewProduct.image = image
                }
            }
        }
    }
    
}
