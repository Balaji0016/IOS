//
//  SideMenu.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import Foundation
import UIKit

   protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItems)
}

enum SideMenuItems:  String, CaseIterable{
    case home = "Home"
    case addpet = "Add Pet"
    case feedback = "FeedBack"
}
        
    class MenuController: UITableViewController{
         
        public var delegate: MenuControllerDelegate?
        private let menuItems: [SideMenuItems]
        init(with menuItems: [SideMenuItems]){
            self.menuItems = menuItems
            super.init(nibName: nil, bundle: nil)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.backgroundColor = .darkGray
            view.backgroundColor = .darkGray
            tableView.separatorStyle = .none
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItems.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = menuItems[indexPath.row].rawValue
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .darkGray
            cell.contentView.backgroundColor = .darkGray
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedItem = menuItems[indexPath.row]
            delegate?.didSelectMenuItem(named: selectedItem)
        }
        
    }
 
