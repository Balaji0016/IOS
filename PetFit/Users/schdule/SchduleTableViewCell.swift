//
//  SchduleTableViewCell.swift
//  PetFit
//
//  Created by Balaji U on 18/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit

class SchduleTableViewCell: UITableViewCell {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var ActivityLabel: UILabel!
    
     func setCellWithValuesOf(_ petdata: schduleData) {
        updateUI(Date: petdata.date, Name: petdata.activity)
    }
    
    private func updateUI(Date: String?, Name: String?) {
        
         self.DateLabel.text = Date
         self.ActivityLabel.text = Name
         
     }
    
     
}

