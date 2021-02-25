//
//  BuyProductViewModel.swift
//  PetFit
//
//  Created by Balaji U on 22/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import Foundation
import FirebaseFirestore

class BuyProductViewModel: ObservableObject{
    @Published var products = [BuyProductData]()
    var imageGet: UIImage? = UIImage(named: "noImageAvailable")
    //var counter = 1
    //var testdata = [tableData(name: "bala", DOB: "8", location: "India"), tableData(name: "NMAE22", DOB: "0980", location: "aussie"), ]
    
    private var db = Firestore.firestore()
    
    func fetchData(completion: @escaping () -> ())
    {
         
        db.collection("Products").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No data to fetch")
                return
            }
            
            self.products = documents.map { (queryDocumentSnapshot) -> BuyProductData in
               
               let data = queryDocumentSnapshot.data()
                let name = data["Name"] as? String ?? ""
                let price = data["Price"] as? String ?? ""
                
                //process fetch image by api call the strint to url then image then return
                let imageurl = data["ImageURL"] as? String ?? ""
                
               
                //let ImgURL : URL = URL(string: imageurl)!
                
                return BuyProductData(name: name, price: price, image: imageurl)
                
            }
            completion()
        }
        
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if products.count != 0 {
            return products.count
        }
        return 0
    }
    
    func cellreturntest (indexPath: IndexPath) -> BuyProductData {

        return products[indexPath.row]
      
    }
    

}
