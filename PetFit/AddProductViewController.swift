//
//  AddProductViewController.swift
//  PetFit
//
//  Created by Balaji U on 20/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage


class AddProductViewController: UIViewController {

       @IBOutlet weak var priceLabel: UITextField!
       @IBOutlet weak var nameLabel: UITextField!
       
       @IBOutlet weak var desctionLabel: UITextField!
     @IBOutlet weak var ProfilePicLabel: UIImageView!
       
       private var db = Firestore.firestore() //Firebase Database Reference
       private let refStorage = Storage.storage().reference() //Firebase Storage Reference
       
       var name = ""
       var price = ""
       var desc = ""
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
           if nameLabel.text != nil{
               name = nameLabel.text!
           }
           if priceLabel.text != nil{
               price = priceLabel.text!
           }
           if desctionLabel.text != nil{
               desc = desctionLabel.text!
           }
         
           
           docData = [
               "Name": name,
               "Price": price,
               "Description": desc,
               "ImageURL": urlImagePass
               ]
           writeData()
       }
       
       // MARK: - DATABASE WRITE
       
       func writeData(){
           
        db.collection("Products").addDocument(data: docData)
        { err in
           if let err = err {
               print("Error writing document: \(err)")
           } else {
               print("Document successfully written!")
           }
       }
           nameLabel.text = ""
           priceLabel.text = ""
           desctionLabel.text = ""
           ProfilePicLabel.image = nil
       }
       /*
       // MARK: - Navigation

       */

   }


   // MARK: - Getting picture From USER
   extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
       
          
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
               
               refStorage.child("ProductsImage/\(timeStamp)") .putData(imageData, metadata: nil) { (storageMetadata, error) in
                     guard error == nil else{
                       print("Failed to Upload")
                       return
                   }
                   
                   self.refStorage.child("ProductsImage/\(timeStamp)").downloadURL { (url, error) in
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

