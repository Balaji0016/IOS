//
//  PetViewModel.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import Foundation
import FirebaseFirestore

class PetViewModel: ObservableObject{
    @Published var pets = [tableData]()
    var imageGet: UIImage? = UIImage(named: "noImageAvailable")
    //var counter = 1
    //var testdata = [tableData(name: "bala", DOB: "8", location: "India"), tableData(name: "NMAE22", DOB: "0980", location: "aussie"), ]
    
    private var db = Firestore.firestore()
    
    func fetchData(completion: @escaping () -> ())
    {
         
        db.collection("Pets").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No data to fetch")
                return
            }
            
            self.pets = documents.map { (queryDocumentSnapshot) -> tableData in
               
               let data = queryDocumentSnapshot.data()
                let name = data["Name"] as? String ?? ""
                let dob = data["DOB"] as? String ?? ""
                let location = data["Location"] as? String ?? ""
                let breed = data["Breed"] as? String ?? ""
                //process fetch image by api call the strint to url then image then return
                let imageurl = data["ImageURL"] as? String ?? ""
                
               
                //let ImgURL : URL = URL(string: imageurl)!
                
                
                //let finalImage = self.getImageDataFrom(url: ImgURL)
                //print("Final Image ------", finalImage)
                //print("Calculate time happening chech before after get imag fun")
               // print("-----name, dob, location, url", name, dob, location, imageurl)
                //let try send string and fetch image from viewcontroller
                return tableData(name: name, image: imageurl, DOB: dob, location: location, breed: breed)
                
            }
            completion()
        }
        
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if pets.count != 0 {
            return pets.count
        }
        return 0
    }
    
    func cellreturntest (indexPath: IndexPath) -> tableData {

        return pets[indexPath.row]
      
    }
    

}
