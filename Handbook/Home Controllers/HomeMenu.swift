//
//  HomeMenu.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/1/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD



class HomeMenu : UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    //Holds the data from Firebase
    var mainDownloadArray : [String] = []
    
    //Sected item
    var selectedItem = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //MARK: Nav Bar setup
        //Set Nav Bar as clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        //MARK: Table Setup
        //Set tableview background to clear
        self.tableView.backgroundColor = UIColor.clear
        let backgroundImage = UIImage(named: "Rectangle.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        //Set row Height
        self.tableView.rowHeight = CGFloat(105)
        //Remove Extra Rows
        tableView.tableFooterView = UIView()
        //Add custom cell
        self.tableView.register(UINib(nibName: "CustomMainCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    
        //Custom Seque
        self.navigationController?.delegate = self
        
        //Trigger download from Firebase
        getData()
        
    }
    
   
    
    
    
    
    //MARK: Firebase download
    //Calls the download function to get Main Data from Firebase
    let documentDownloader = Data()
    func getData(){
        SVProgressHUD.show()
        documentDownloader.downloadMainData { snapArray, error  in
            for docs in snapArray {
                //print(docs.documentSnapchot)
                let doc = docs.documentSnapchot.documentID
                self.mainDownloadArray.append(doc)
            }
            print("Home Menue Downloaded - \(self.mainDownloadArray)")
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    
    
    
    
    
    //MARK: Custom Segue
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(operation: operation)
    }
    
    
    
    //MARK: Cell Spacing setup
    let cellSpacing = CGFloat(5)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     return mainDownloadArray.count
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomMainCell
        cell.customMainCellLabel.text = mainDownloadArray[indexPath.row]
        //Change cells selection color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.188, green: 0.58, blue: 0.906, alpha: 0.65)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    
    
    
    //MARK: Segue Setup
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = mainDownloadArray[indexPath.row]
        self.performSegue(withIdentifier: "SegueToDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Prepare for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! HomeDetailController
        detailVC.pastSelection = selectedItem
    }
    
    
    
    
}





