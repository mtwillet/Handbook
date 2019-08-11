//
//  SettingsViewController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/6/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreData


class Settings : UITableViewController {
    
    
    @IBOutlet weak var favoriteIsHomeSwitch: UISwitch!
    
    @IBAction func favoriteIsHomeToggle(_ sender: UISwitch) {
        if favoriteIsHomeSwitch.isOn == true {
            UserDefaults.standard.set("True", forKey: "FIHDefault")
            UserDefaults.standard.set(2, forKey: "MVCIndex")
        } else {
            UserDefaults.standard.set("False", forKey: "FIHDefault")
            UserDefaults.standard.set(1, forKey: "MVCIndex")
        }
        
        
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteIsHomeSwitch.addTarget(self, action:  #selector(favoriteIsHomeToggle(_:)), for: UIControl.Event.valueChanged)
        
        
        let favIsHomeDefault = UserDefaults.standard
        if let FISDefault = favIsHomeDefault.string(forKey: "FIHDefault") {
            if FISDefault == "True" {
                favoriteIsHomeSwitch.isOn = true
            } else {
                favoriteIsHomeSwitch.isOn = false
            }
        } else {
            favoriteIsHomeSwitch.isOn = false
        }
        
  
        //MARK: Nav Bar setup
        //Set Nav Bar as clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        //MARK: Table Setup
//        //Set tableview background to clear
               self.tableView.backgroundColor = UIColor.clear
//        let backgroundImage = UIImage(named: "Rectangle.png")
//        let imageView = UIImageView(image: backgroundImage)
//        self.tableView.backgroundView = imageView
        
        
        
    
        
    }
    
 
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        tableView.headerView(forSection: section)?.backgroundColor = UIColor.blue
//    }

    
    
    //MARK: Clear Favorites
    @IBAction func clearFavorites(_ sender: Any) {
        
        //MARK: Core Data Setup
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext


        
        //MARK: Download Favorites from Core Data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StoredFavorites")
        let deleate = NSBatchDeleteRequest(fetchRequest: request)
        
        

                do {
                    try context.execute(deleate)
                    print("Deleted Favorites")
                } catch {
                    print("Error deleting Favorites")
                }

        let _ : NSError! = nil
        do {
            try context.save()
            print("Saved"   )
        } catch {
            print("error : \(error)")
        }
        
    }
    
    
    
    
    
    
    //MARK: Sign Out
    @IBAction func signOut(_ sender: Any) {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
    }
    
    
    
    
    
    
    
}
