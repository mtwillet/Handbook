//
//  LogInViewController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/3/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit
import Firebase
//import GoogleSignIn
import SVProgressHUD

class LogInViewController: UIViewController {
    

//    var handle: AuthStateDidChangeListenerHandle?

//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//
//        }
//
//    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings

        
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                // User is signed in.
                // ...
                print("User is signed in")
                self.performSegue(withIdentifier: "SegueToHome", sender: self)
            } else {
                // No user is signed in.
                // ...
                print("No user signed in")
            }
        }

    }

    
    
    @IBAction func NewSignIn(_ sender: Any) {
        let email = "test@test.com"
        let password = "testtest"
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                print (error!)
            } else {
                print("Login Successfull")
                self.performSegue(withIdentifier: "SegueToHome", sender: self)
            }
        }
    }
    
    
    
    
    @IBAction func signIn(_ sender: Any) {
        SVProgressHUD.show()
        let email = "test@test.com"
        let password = "testtest"
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print (error!)
            } else {
                print("Login Successfull")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "SegueToHome", sender: self)
            }
        }
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    
    
 
    override func viewWillDisappear(_ animated: Bool) {
  //      Auth.auth().removeStateDidChangeListener(handle!)

    }
 
    override func viewDidDisappear(_ animated: Bool) {
  
    }
    
    
}
