//
//  FeedBackViewModel.swift
//  PetFit
//
//  Created by Balaji U on 25/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//


import Foundation
import FirebaseFirestore

class FeedBackViewModel: ObservableObject{
    @Published var feedBackview = [FeedbackData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(completion: @escaping () -> ())
    {
         
        db.collection("FeedBack").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No data to fetch")
                return
            }
            
            self.feedBackview = documents.map { (queryDocumentSnapshot) -> FeedbackData in
               
               let data = queryDocumentSnapshot.data()
                let date = data["Date"] as? String ?? ""
                let details = data["Details"] as? String ?? ""
                let name = data["Title"] as? String ?? ""
               
                return FeedbackData(date: date, name: name, details: details)
                
            }
            completion()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if feedBackview.count != 0 {
            return feedBackview.count
        }
        return 0
    }
    
    func cellreturntest (indexPath: IndexPath) -> FeedbackData {

        return feedBackview[indexPath.row]
      
    }
    
}

