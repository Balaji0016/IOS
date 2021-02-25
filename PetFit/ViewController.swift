//
//  ViewController.swift
//  PetFit
//
//  Created by Balaji U on 12/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var VideoView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setVideo()
        self.errorLabel.isHidden = true
        // Do any additional setup after loading the view.
       
        
    }
    
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        
        guard let username = usernameLabel.text, usernameLabel.text?.count != 0 else
        {
            errorLabel.text = "Please Enter the Username"
            errorLabel.isHidden = false
        return
            
        }
        guard let password = passwordLabel.text, passwordLabel.text?.count != 0 else
        {
            errorLabel.text = "Please Enter the password"
            errorLabel.isHidden = false
        return
            
        }
       
        self.usernameLabel.text = ""
        self.passwordLabel.text = ""
        errorLabel.isHidden = true
        
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
          
            if error  != nil{
                self?.errorLabel.text = "Incorrect Username or Password"
                self?.errorLabel.isHidden = false
            }
            else{
                
                self?.transitiontoHomeView(Id: "gotoUserHome")
                
            }
       
        }
    }
    
   
    
    @IBAction func LogInAdminTapped(_ sender: Any) {
        guard let username = usernameLabel.text, usernameLabel.text?.count != 0 else
         {
             errorLabel.text = "Please Enter the Username"
             errorLabel.isHidden = false
         return
             
         }
         guard let password = passwordLabel.text, passwordLabel.text?.count != 0 else
         {
             errorLabel.text = "Please Enter the password"
             errorLabel.isHidden = false
         return
             
         }
        
         self.usernameLabel.text = ""
         self.passwordLabel.text = ""
         errorLabel.isHidden = true
        let adminname = "admin" + username
         
         Auth.auth().signIn(withEmail: adminname, password: password) { [weak self] authResult, error in
           
             if error  != nil{
                 self?.errorLabel.text = "Incorrect Username or Password"
                 self?.errorLabel.isHidden = false
             }
             else{
                self?.transitiontoHomeView(Id: "gotoAdminHome")
                 
             }
        
         }
    }
    
    @IBAction func SignUPTapped(_ sender: Any) {
    }
    
    
    func setVideo() {
        self.navigationController?.isNavigationBarHidden = true
        guard let path = Bundle.main.path(forResource:"dogVideo", ofType: "mp4") else{
            return
        }
        
        let player =  AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.VideoView.layer.addSublayer(playerLayer)
        player.play()
        player.isMuted = true
        
    }
 
    func transitiontoHomeView(Id: String) {
//           let homevc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.UsersHomevc) as? UserHomeViewController
//
//           view.window?.rootViewController = homevc
//           view.window?.makeKeyAndVisible()
//       }
        
        performSegue(withIdentifier: Id, sender: self)
    }
}

  


