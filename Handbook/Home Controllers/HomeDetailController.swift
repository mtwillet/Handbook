//
//  HomeDetailController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/2/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD



class HomeDetailController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Accept the picked cell from home
    var pastSelection = ""
    var selection = ""
    
    //Holds downloaded data
    var detailNames : [String] = []
    var detailScreenPage : [Int] = []
    var detailTitleSender : String = ""
    
    
    //Holds the segue names
    let segueNames : [String] = ["SegueToMoreDetail", "SegueToDetailPage1", "SegueToDetailPage2"]
  
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //MARK: Nav Bar setup
        //Set Nav Bar as clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        //MARK: Table Setup
        //Set tableview background to clear
        let backgroundImage = UIImage(named: "Rectangle.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView

        
        //Set row Height
        self.tableView.rowHeight = CGFloat(70)
        //Remove Extra Rows
        tableView.tableFooterView = UIView()
        //Add custom cell
        self.tableView.register(UINib(nibName: "CustomDetailCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    

        getData()
    }
    
    
    
    //MARK: Firebase download
    //Calls the download function to get Main Data from Firebase
    let documentDownloader = Data()
    func getData(){
        SVProgressHUD.show()
        documentDownloader.downloadDetailData(mainDocID: pastSelection) { docArray, page  in
            for item in docArray {
                self.detailNames.append(item.documentID)
            }
            self.detailScreenPage = page
            print("Detail Screen Page \(self.detailScreenPage)")
            SVProgressHUD.dismiss()
            self.tableView.reloadData()

        }
    }
    
    
    
    
    
    //MARK: Favorite Swipe
    //TO DO: Change the favorite bar to turn off when unFavorited
    func favoriteContextualAction(forRowAtIndexPath indexPath : IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            //Turn on favorite bar in cell
            let cell = self.tableView.cellForRow(at: indexPath) as! CustomDetailCell
            cell.favoriteBar.backgroundColor = UIColor(red: 0.118, green: 0.796, blue: 0.949, alpha: 1)
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
    
    
    
    
    
    
    //MARK: Cell Spacing setup
    let cellSpacing = CGFloat(5)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return detailNames.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacing
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    
    
    //MARK: Row Setup
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomDetailCell
        cell.label.text = detailNames[indexPath.row]
        //Change cells selection color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.188, green: 0.58, blue: 0.906, alpha: 0.65)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    
    
    
    //MARK: Segue Setup
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selection = detailNames[indexPath.row]
        self.performSegue(withIdentifier: segueNames[detailScreenPage[indexPath.row]], sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDetailPage1" {
            let detailVC = segue.destination as! DetailScreen1
            detailVC.detailTitle = detailTitleSender
        } else if segue.identifier == "SegueToDetailPage2" {
            let detailVC = segue.destination as! DetailScreen2
            detailVC.detailTitle = detailTitleSender
        } else if segue.identifier == "SegueToMoreDetail" {
            let detailVC = segue.destination as! MoreDetail
            detailVC.pastSelection = selection
            detailVC.mainSelection = pastSelection
        }
    }
    
    
}
