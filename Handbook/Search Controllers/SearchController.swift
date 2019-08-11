//
//  SearchController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 8/1/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import Foundation
import UIKit


class Search : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    //Search Bar Variables
    var offset = UIOffset()
    let placeholderWidth : CGFloat = 110
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
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
//        let backgroundImage = UIImage(named: "Rectangle.png")
//        let imageView = UIImageView(image: backgroundImage)
//        self.tableView.backgroundView = imageView
//        
        
        
        //Set row Height
        self.tableView.rowHeight = CGFloat(70)
        //Remove Extra Rows
        tableView.tableFooterView = UIView()
        //Add custom cell
        self.tableView.register(UINib(nibName: "CustomDetailCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        
        //MARK: Search Field Set Up
        // TextField Color Customization
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        // Placeholder Customization
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        // Glass Icon Customization
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
        
    
        //Search Bar placeholder setup
        searchBar.delegate = self
        let searchBarWidth = searchBar.frame.width
        let offset = UIOffset(horizontal: (searchBarWidth - placeholderWidth) / 2, vertical: 0)
        searchBar.setPositionAdjustment(offset, for: .search)
    
    }
    
    
    
    //MARK: Search Bar placeholder setup
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let noOffset = UIOffset(horizontal: 0, vertical: 0)
        searchBar.setPositionAdjustment(noOffset, for: .search)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setPositionAdjustment(offset, for: .search)
        return true
    }
    
    
    
    
    //MARK: Cell Spacing setup
    let cellSpacing = CGFloat(5)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        
        //Change cells selection color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.188, green: 0.58, blue: 0.906, alpha: 0.65)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
    //    //MARK: Segue Setup
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        self.performSegue(withIdentifier: "SegueToDetail", sender: self)
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    
    
}
