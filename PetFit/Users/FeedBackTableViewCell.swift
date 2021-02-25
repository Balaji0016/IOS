//
//  FeedBackTableViewCell.swift
//  PetFit
//
//  Created by Balaji U on 25/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit

class FeedBackTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DetailsLabel: UILabel!
    
    
     func setCellWithValuesOf(_ fbdata: FeedbackData) {
        updateUI(Date: fbdata.date, Name: fbdata.name, Details: fbdata.details)
    }
    
    private func updateUI(Date: String?, Name: String?, Details: String?) {
        
         self.dateLabel.text = Date
         self.NameLabel.text = Name
        self.DetailsLabel.text = Details
        
         
     }
    
     
}
