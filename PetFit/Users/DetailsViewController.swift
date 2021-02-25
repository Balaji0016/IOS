//
//  DetailsViewController.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {


        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var imgLabel: UIImageView!
        
        @IBOutlet weak var locationLabel: UILabel!
       
        @IBOutlet weak var dobLabel: UILabel!
        
        @IBOutlet weak var breedLabel: UILabel!
    
        var image = UIImage()
        var name = ""
        var location = ""
        var dob = ""
        var breed = ""
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            nameLabel.text = name
    //        //imgLabel.image = image
           locationLabel.text = location
           dobLabel.text = dob
            breedLabel.text = breed
            // Do any additional setup after loading the view.
            
        }

        

        
        // MARK: - Try to UPdate image
        
         func getImageDataFrom(url: URL){
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
                            self.imgLabel.image = image
                        }
                    }
                   
                   
                }.resume()
                
            }

       

    }

