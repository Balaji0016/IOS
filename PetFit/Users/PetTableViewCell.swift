//
//  PetTableViewCell.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit

class PetTableViewCell: UITableViewCell {


     @IBOutlet weak var imageCell: UIImageView!
     
     @IBOutlet weak var titlelbl: UILabel!
     
     @IBOutlet weak var locationLabel: UILabel!
     @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    
     func setCellWithValuesOf(_ petdata:tableData) {
        updateUI(name: petdata.name, Image:petdata.image, DOB: petdata.DOB, Location: petdata.location, Breed: petdata.breed)
    }
    private func updateUI(name: String?, Image: String?, DOB: String?, Location: String?, Breed: String?) {
        
         self.titlelbl.text = name
         
         self.dobLabel.text = DOB
         self.locationLabel.text = Location
         self.breedLabel.text = Breed
         
         
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

