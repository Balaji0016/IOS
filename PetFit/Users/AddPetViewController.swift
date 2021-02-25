//
//  AddPetViewController.swift
//  PetFit
//
//  Created by Balaji U on 17/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddPetViewController: UIViewController {


      @IBOutlet weak var newNameLabel: UITextField!
      @IBOutlet weak var newDOBLabel: UITextField!
      @IBOutlet weak var newLocationLabel: UITextField!
    @IBOutlet weak var newbreedLabel: UITextField!
    @IBOutlet weak var ProfilePicLabel: UIImageView!
      
      private var db = Firestore.firestore() //Firebase Database Reference
      private let refStorage = Storage.storage().reference() //Firebase Storage Reference
      
      var name = ""
      var DOB = ""
      var location = ""
      var breed = ""
      var urlImagePass = ""
      var docData: [String: Any] = [:]
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Do any additional setup after loading the view.
      }
      
      
      
      
      @IBAction func addPetTapped(_ sender: Any) {
          LoadWriteData()
          
      }
      
      // MARK: - Upload Image to FierBASE Storage
      //Returning URL For later image process
      @IBAction func uploadTapped(_ sender: Any) {
          let picker = UIImagePickerController()
          picker.sourceType = .photoLibrary
          picker.delegate = self
          picker.allowsEditing = true
          present(picker, animated:true )
          
          
      }
      
      
      
      
      // MARK: - LOAD DATABASE VARAIABLES
      func LoadWriteData()
      {
          if newDOBLabel.text != nil{
              DOB = newDOBLabel.text!
          }
          if newNameLabel.text != nil{
              name = newNameLabel.text!
          }
          if newLocationLabel.text != nil{
              location = newLocationLabel.text!
          }
        if newbreedLabel.text != nil{
            breed = newbreedLabel.text!
        }
          
          docData = [
              "Name": name,
              "DOB": DOB,
              "Location": location,
              "Breed" : breed,
              "ImageURL": urlImagePass
              ]
          writeData()
      }
      
      // MARK: - DATABASE WRITE
      
      func writeData(){
          
       db.collection("Pets").addDocument(data: docData)
       { err in
          if let err = err {
              print("Error writing document: \(err)")
          } else {
              print("Document successfully written!")
          }
      }
          newNameLabel.text = ""
          newDOBLabel.text = ""
          newLocationLabel.text = ""
          newbreedLabel.text = ""
          ProfilePicLabel.image = nil
      }
      /*
      // MARK: - Navigation

      */

  }


  // MARK: - Getting picture From USER
  extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
      
         
          func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
              picker.dismiss(animated: true, completion: nil)
              guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                  
                  return
              }
              self.ProfilePicLabel.image = image
              guard let imageData = image.pngData() else {
                  
                  return
              }
              let timeStamp = timestamp() + "image.png"
              
              refStorage.child("PetsProfile/\(timeStamp)") .putData(imageData, metadata: nil) { (storageMetadata, error) in
                    guard error == nil else{
                      print("Failed to Upload")
                      return
                  }
                  
                  self.refStorage.child("PetsProfile/\(timeStamp)").downloadURL { (url, error) in
                      guard let url = url, error == nil else{
                          return
                      }
                      let urlImage = url.absoluteURL
                      //UserDefaults.standard.set(urlImage, forKey: "url")
  //                    let a = String(describing: urlImage)
  //                    self.urlImagePass = a
                     self.urlImagePass = String(describing: urlImage)
                                      }
              }
              
      }//upload finish

      func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
          picker.dismiss(animated: true, completion: nil)
      }
      
       
      func timestamp()-> String{
          
      let date = Date()
      let formatter = DateFormatter()
          formatter.timeStyle = .short
      formatter.dateStyle = .medium
      var FullDate = formatter.string(from: date)
          FullDate = FullDate.replacingOccurrences(of: " ", with: "")
          FullDate = FullDate.replacingOccurrences(of: ":", with: "")
          FullDate = FullDate.replacingOccurrences(of: ",", with: "")
          
      return FullDate
      }
  }//extension end
