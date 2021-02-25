//
//  BuyProductsViewController.swift
//  PetFit
//
//  Created by Balaji U on 20/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class BuyProductsViewController: UIViewController {
let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    private var refPetsVM = BuyProductViewModel()
    //var Testimgarr = [UIImage(named: "cat1"), UIImage(named: "dog1"), UIImage(named: "dog3"), UIImage(named: "dog2")]
    
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
extension BuyProductsViewController: UITableViewDataSource, UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowcount: Int = refPetsVM.numberOfRowsInSection(section: section)
        
        return rowcount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath) as? BuyProductTableViewCell
        
        let dbFetchData = refPetsVM.cellreturntest(indexPath: indexPath)
        
//        cell?.titlelbl.text = dbFetchData.name
 //Image not from db           //cell?.imageCell.image = UIImage(named: list[indexPath.row])
        
//        cell?.locationLabel.text = dbFetchData.location
//        cell?.dobLabel.text = dbFetchData.DOB
        
        cell!.setCellWithValuesOf(dbFetchData)
        //funcell.settitle(with: list[indexPath.row])
        //cell.textLabel?.text = list[indexPath.row]
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
//        let dbFetchData = refPetsVM.cellreturntest(indexPath: indexPath)
//        //vc?.image = dbFetchData.image
//        //vc?.image = getImageDataFrom()
//        let Image = URL(string: dbFetchData.image)
//
//        //let urlFromStr :  URL =   URL(string: Image!)!
//        vc?.getImageDataFrom(url: Image!)
//        vc?.name = dbFetchData.name
//      vc?.location = dbFetchData.location
//       vc?.dob = dbFetchData.DOB
//        vc?.breed = dbFetchData.breed
//
//        self.navigationController?.pushViewController(vc!, animated: true)
//
//    }
    
    
}
