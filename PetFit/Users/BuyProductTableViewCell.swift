//
//  BuyProductTableViewCell.swift
//  PetFit
//
//  Created by Balaji U on 22/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit

class BuyProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
   
    func setCellWithValuesOf(_ productdata:BuyProductData) {
       updateUI(name: productdata.name, price: productdata.price, Image: productdata.image)
   }
   private func updateUI(name: String?, price: String?, Image: String?) {
       
        self.nameLabel.text = name
         let priceVar = "$" + price!
      self.priceLabel.text = priceVar
        
        
        
        
        guard let ImageURL = URL(string: Image!) else {
            self.imageCell.image = UIImage(named: "noImageAvailable")
            return
        }
        //let urlFromStr :  URL =   URL(string: Image!)!
        
        self.imageCell.image = nil
        
        getImageDataFrom(url: ImageURL)
    }
    
    private func getImageDataFrom(url: URL){
           // print("$_____$ Inside get image Function and URl", url)
            let urlFun: URL = url
            //let strValTest = String(describing: urlFun)
            URLSession.shared.dataTask(with: urlFun) { (data, response, error) in
                if let error = error {
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
    
                guard let datat = data, datat.count != 0 else {
                    print("Empty Data")
                    return
                }
                DispatchQueue.main.async {
                    if let image = UIImage(data: datat) {
                        self.imageCell.image = image
                    }
                }
               
               
            }.resume()
            
        }
    
   
   

}

