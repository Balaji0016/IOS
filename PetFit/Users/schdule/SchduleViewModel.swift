//
//  SchduleViewModel.swift
//  PetFit
//
//  Created by Balaji U on 18/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import Foundation
import FirebaseFirestore

class SchduleViewModel: ObservableObject{
    @Published var schuduleview = [schduleData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(completion: @escaping () -> ())
    {
         
        db.collection("Schdule").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No data to fetch")
                return
            }
            
            self.schuduleview = documents.map { (queryDocumentSnapshot) -> schduleData in
               
               let data = queryDocumentSnapshot.data()
                let date = data["Date"] as? String ?? ""
                let activity = data["Activity"] as? String ?? ""
               
                return schduleData(date: date, activity: activity)
                
            }
            completion()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if schuduleview.count != 0 {
            return schuduleview.count
        }
        return 0
    }
    
    func cellreturntest (indexPath: IndexPath) -> schduleData {

        return schuduleview[indexPath.row]
      
    }
    
}
