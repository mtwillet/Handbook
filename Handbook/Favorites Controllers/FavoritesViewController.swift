//
//  FavoritesViewController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/5/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Data Storage Variables
    var documentIDs : [String] = []
    var dbids : [Int] = []
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //MARK: Nav Bar setup
        //Set Nav Bar as clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        //MARK: Table Setup
        //Set tableview background to clear
        //       self.tableView.backgroundColor = UIColor.clear
        let backgroundImage = UIImage(named: "Rectangle.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        
        
        //Set row Height
        self.tableView.rowHeight = CGFloat(70)
        //Remove Extra Rows
        tableView.tableFooterView = UIView()
        //Add custom cell
        self.tableView.register(UINib(nibName: "CustomFavoritesCell", bundle: nil), forCellReuseIdentifier: "CustomCell")

        
        //Download core data
        //downloadData()

       
    }
    
    
//    //MARK: Cell Spacing setup
//    let cellSpacing = CGFloat(5)
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacing
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
//
    
    
    
    //MARK: Row Setup
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return documentIDs.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return documentIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomFavoritesCell
        //Change cells favorite indicator to blue
        cell.indicator.backgroundColor = UIColor(red: 0.118, green: 0.796, blue: 0.949, alpha: 1)
        //Change cells selection color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.188, green: 0.58, blue: 0.906, alpha: 0.65)
        cell.selectedBackgroundView = backgroundView
        //print(indexPath.row)
        //print(documentIDs[indexPath.row])
        cell.label.text = documentIDs[indexPath.row]
        
        return cell
    }
    
    
    //    //MARK: Segue Setup
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        self.performSegue(withIdentifier: "SegueToDetail", sender: self)
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    
    
    
    //MARK: Test
    //---------------------------
    
    //MARK: Remove Single Favorite
    func favoriteContextualAction(forRowAtIndexPath indexPath : IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            //do actions here
            
            
            //Complete action and delete row (does not update the data, just visually deletes the row)
            completionHandler(true)
        }
        //Change the "Remove" color
        action.backgroundColor = UIColor(red: 0.118, green: 0.796, blue: 0.949, alpha: 1)
        return action
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeConfig = UISwipeActionsConfiguration(actions: [self.favoriteContextualAction(forRowAtIndexPath: indexPath)])
        return swipeConfig
        
    }
    
  //--------------

    
    
    
    //MARK: Core Data Download Setup
    func downloadData() {
        documentIDs = []
        dbids = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorites")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)

            for data in result as! [NSManagedObject] {
                dbids.append(data.value(forKey: "dbid") as! Int)
                documentIDs.append(data.value(forKey: "documentID") as! String)
                print(data.value(forKey: "documentID") as! String)
            }
            
            self.tableView.reloadData()
            //print("!!")
            //print(documentIDs)
        } catch {
            
            print("Favorites Core Data Download Failed")
        }
    }
    
    
    
    
    @IBAction func clearData(_ sender: Any) {
       deleate()
    }
    
    
    //MARK: Delete All Favorites
    func deleate() {
        //MARK: Core Data Setup
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDFavorites")
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        print(appDelegate, "____", context, "____", request, "____", delete)
        
        request.returnsObjectsAsFaults = false
        
        //MARK: Download Favorites from Core Data
        do {
            try context.execute(delete)
            
            print("Deleted all Favorites")
        } catch {
            print("Error deleting Favorites")
        }
        
        do {
            try context.save()
            print("Save after delete")
        } catch {
            print("Error saving after deleting favorites")
        }
        //downloadData()
    }
    
    
    

    @IBAction func reload(_ sender: Any) {
        downloadData()
    //    print(documentIDs)
    }
    
    
    
    
}

