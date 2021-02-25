//
//  RegisterViewController.swift
//  PetFit
//
//  Created by Balaji U on 12/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var SignUpUsernameLabel: UITextField!
    
    @IBOutlet weak var SignUpEmailLabel: UITextField!
    
    @IBOutlet weak var SignUpPasswordLabel: UITextField!
    
    @IBOutlet weak var SignUpConfirmPasswordLabel: UITextField!
    
    @IBOutlet weak var SignUpErrorLabel: UILabel!
    
    let db = Firestore.firestore()
    var username = ""
    var email = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        SignUpErrorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUpRegsiterButtonTapped(_ sender: Any) {
        guard let usernameG = SignUpUsernameLabel.text, SignUpUsernameLabel.text?.count != 0 else
              {
                  SignUpErrorLabel.text = "Please Enter the Username"
                  SignUpErrorLabel.isHidden = false
              return
                  
              }
        self.username = usernameG
              guard let emailG = SignUpEmailLabel.text, SignUpEmailLabel.text?.count != 0 else
              {
                  SignUpErrorLabel.text = "Please Enter the Email"
                  SignUpErrorLabel.isHidden = false
              return
                  
              }
        self.email = emailG
              guard let passwordG = SignUpPasswordLabel.text, SignUpPasswordLabel.text?.count != 0 else
              {
                  SignUpErrorLabel.text = "Please Enter the password"
                  SignUpErrorLabel.isHidden = false
              return
                  
              }
              guard let _ = SignUpConfirmPasswordLabel.text, SignUpConfirmPasswordLabel.text?.count != 0 else
              {
                  SignUpErrorLabel.text = "Please Confirm Your password"
                  SignUpErrorLabel.isHidden = false
              return
                  
              }
              
              guard SignUpPasswordLabel != SignUpConfirmPasswordLabel else{
                  SignUpErrorLabel.text = "Password Mismatch Check again"
                  SignUpErrorLabel.isHidden = false
                  return
              }
        self.password = passwordG
              SignUpConfirmPasswordLabel.text = ""
              SignUpPasswordLabel.text = ""
              SignUpUsernameLabel.text = ""
              SignUpEmailLabel.text = ""
              SignUpErrorLabel.isHidden = true
        UpdateFirebase(user: username, email: email, password: password)
      
        
    }
    
    
    // MARK: - Upoad User data to Firenbase and collection User details
    func UpdateFirebase(user: String, email: String, password: String)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let err = error{
                print(err)
            }
            else{
                //Store All data into DB
                                var ref: DocumentReference? = nil
                ref = self.db.collection("users").addDocument(data: [
                                    "Username": user,
                                    "Email": email,
                                    "UserID": result!.user.uid
                                ]) { err in
                                    if let err = err {
                                        print("Error adding document: \(err)")
                                    } else {
                                        print("Document added with ID: \(ref!.documentID)")
                                    }
                                }
                 }
            
           
        }// Auth complete
    }//Upadte Fun over
    
    
    /*
    // MARK: - Navigation

    */

}
