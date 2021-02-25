//
//  FeedBackViewController.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FeedBackViewController: UIViewController {


        
    
        
        @IBOutlet weak var DetailsPicker: UITextField!
        @IBOutlet weak var TitleLabel: UITextField!
    
    private var db = Firestore.firestore() //Firebase Database Reference
    
    var titlefb = ""
    var detailsfb = ""
    
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
            if TitleLabel.text != nil{
                titlefb = TitleLabel.text!
            }
            if DetailsPicker.text != nil{
                detailsfb = DetailsPicker.text!
            }
            let timeStamp = timestamp()

            docData = [
                
                "Date": timeStamp,
                "Title" : titlefb,
                "Details": detailsfb,

                ]
            writeData()
        }

        // MARK: - DATABASE WRITE

        func writeData(){

         db.collection("FeedBack").addDocument(data: docData)
         { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
            TitleLabel.text = ""
            DetailsPicker.text = ""

        }
    
    func timestamp()-> String{
        
    let date = Date()
    let formatter = DateFormatter()
        formatter.timeStyle = .short
    formatter.dateStyle = .medium
    let FullDate = formatter.string(from: date)
        
    return FullDate
    }
    

    }



