//
//  AdminHomeViewController.swift
//  PetFit
//
//  Created by Balaji U on 20/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//
import UIKit
import FirebaseDatabase
import FirebaseFirestore


class AdminHomeViewController: UIViewController{
   
    let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    private var refPetsVM = AdminHomeViewViewModel()
    var Testimgarr = [UIImage(named: "cat1"), UIImage(named: "dog1"), UIImage(named: "dog3"), UIImage(named: "dog2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        loadPetData()
         
    }
    
    private func loadPetData() {
           refPetsVM.fetchData{ [weak self] in
               self?.tableView.dataSource = self
               self?.tableView.reloadData()
           }
    
}
    
}
extension AdminHomeViewController: UITableViewDataSource, UITableViewDelegate{
     
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowcount: Int = refPetsVM.numberOfRowsInSection(section: section)
        
        return rowcount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AdminHomeViewTableViewCell
        
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
// Mark: - ScrollView
extension AdminHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Testimgarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Imgcell", for: indexPath) as? PetsScrollCollectionViewCell
       
        //cell?.updateUI(imageName: Testimgarr[indexPath.row])
        cell?.ScrollImg.image = Testimgarr[indexPath.row]
        return cell!
    }
    
    
}

