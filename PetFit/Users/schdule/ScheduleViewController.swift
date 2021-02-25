//
//  ScheduleViewController.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ScheduleViewController: UIViewController {


        @IBOutlet weak var activityLabel: UITextField!
    
        @IBOutlet weak var txtDatePicker: UITextField!
    
    
    private var db = Firestore.firestore() //Firebase Database Reference
    
    var Date = ""
    var Activity = ""
    
    var docData: [String: Any] = [:]
    
         let datePicker = UIDatePicker()//Implement to textField
    
         override func viewDidLoad() {
         super.viewDidLoad()
         
            
         }
    
        
        @IBAction func addPetTapped(_ sender: Any) {
            
            LoadWriteData()
            
        }
        
    
        // MARK: - LOAD DATABASE VARAIABLES
        func LoadWriteData()
        {
            if activityLabel.text != nil{
                Activity = activityLabel.text!
            }
            if txtDatePicker.text != nil{
                Date = txtDatePicker.text!
            }


            docData = [
                "Date": Date,
                "Activity": Activity,

                ]
            writeData()
        }

        // MARK: - DATABASE WRITE

        func writeData(){

         db.collection("Schdule").addDocument(data: docData)
         { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
            activityLabel.text = ""
            txtDatePicker.text = ""

        }

    }



