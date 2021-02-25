//
//  UserHomeViewController.swift
//  PetFit
//
//  Created by Balaji U on 13/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import SideMenu
import FirebaseDatabase
import FirebaseFirestore


class UserHomeViewController: UIViewController{
   
    let db = Firestore.firestore()
    @IBOutlet weak var tableView: UITableView!
    private var refPetsVM = PetViewModel()
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
extension UserHomeViewController: UITableViewDataSource, UITableViewDelegate{
     
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowcount: Int = refPetsVM.numberOfRowsInSection(section: section)
        
        return rowcount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PetTableViewCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
        let dbFetchData = refPetsVM.cellreturntest(indexPath: indexPath)
        //vc?.image = dbFetchData.image
        //vc?.image = getImageDataFrom()
        let Image = URL(string: dbFetchData.image)
        
        //let urlFromStr :  URL =   URL(string: Image!)!
        vc?.getImageDataFrom(url: Image!)
        vc?.name = dbFetchData.name
      vc?.location = dbFetchData.location
       vc?.dob = dbFetchData.DOB
        vc?.breed = dbFetchData.breed

        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
}
// Mark: - ScrollView
extension UserHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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




   // MARK: - SideMenu
//    func SideMenuTask()
//    {
//        let menu = MenuController(with: SideMenuItems.allCases)
//        menu.delegate = self
//        sideMenu = SideMenuNavigationController(rootViewController: menu)
//        sideMenu?.leftSide = true
//        SideMenuManager.default.leftMenuNavigationController = sideMenu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//        addChildController()
//    }
//    private func addChildController(){
//        addChild(self.AddPetController)
//        addChild(self.FeedBackController)
//
////        view.addSubview(AddPetController.view)
////        view.addSubview(FeedBackController.view)
//
////        AddPetController.view.frame = view.bounds
////       FeedBackController.view.frame = view.bounds
//
//       AddPetController.didMove(toParent: self)
//        FeedBackController.didMove(toParent: self)
//
//        AddPetController.view.isHidden = true
//        FeedBackController.view.isHidden = true
//    }
//
//
//    @IBAction func menutapped(_ sender: Any) {
//       present(sideMenu!, animated: true)
//
//    }
//
//
//    func didSelectMenuItem(named: SideMenuItems) {
//        sideMenu?.dismiss(animated: true, completion: {
//            self.title = named.rawValue
//
//            switch named {
//            case .home:
//                 self.AddPetController.view.isHidden = true
//                 self.FeedBackController.view.isHidden = true
//            case .addpet:
//                 self.AddPetController.view.isHidden = false
//                 self.FeedBackController.view.isHidden = true
//            case .feedback:
//                 self.AddPetController.view.isHidden = true
//                 self.FeedBackController.view.isHidden = false
//            }
//
//        })
//    }//End DidSelect
//
    
    




    


