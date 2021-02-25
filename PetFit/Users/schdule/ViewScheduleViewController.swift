//
//  ScheduleViewViewController.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class ViewScheduleViewController: UIViewController {

   let db = Firestore.firestore()
       @IBOutlet weak var tableView: UITableView!
       private var refPetsVM = SchduleViewModel()
      
       override func viewDidLoad() {
           super.viewDidLoad()
           loadPetData()
            
       }
       
       private func loadPetData() {
              refPetsVM.fetchData{ [weak self] in
                  self?.tableView.dataSource = self
                  self?.tableView.reloadData()
              }
       
   }
       
   }
   extension ViewScheduleViewController: UITableViewDataSource, UITableViewDelegate{
        
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 150
  }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           let rowcount: Int = refPetsVM.numberOfRowsInSection(section: section)
           
           return rowcount
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "schdulecell", for: indexPath) as? SchduleTableViewCell
           
           let dbFetchData = refPetsVM.cellreturntest(indexPath: indexPath)
           
           cell!.setCellWithValuesOf(dbFetchData)
           return cell!
       }
       
       
}
