//
//  ViewController.swift
//  Theatre Suite - Handbook
//
//  Created by Mathew Willett on 7/29/18.
//  Copyright © 2018 Mathew Willett. All rights reserved.
//

import UIKit
import RevealingSplashView

class ViewController: UIViewController {
  
    
    @IBAction func logInScreen(_ sender: UIButton) {
        UserDefaults.standard.set("LogInVC", forKey: "InitialVC")
        print(UserDefaults.standard.string(forKey: "InitialVC")!)
    }
    
    
    @IBAction func mainscreen(_ sender: UIButton) {
         UserDefaults.standard.set("MainVC", forKey: "InitialVC")
        print(UserDefaults.standard.string(forKey: "LogInVC")!)
    }
    

    
    
    
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    let headerLabelArray : [String] = ["", "Home", "Favorites", "Settings"]
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
    //Bar Button View Controllers
    var searchViewController: UIViewController!
    var homeViewController: UIViewController!
    var favoriteViewController: UIViewController!
    var settingsViewController: UIViewController!
    var viewControllers: [UIViewController]!
    // Default tab on open when user settings have not ben defined
    var selectedIndex: Int = 1
    

    
    
    //Tab Bar
    @IBAction func didPressTab(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)
        //Header Bar Label
        headerLabel.text = headerLabelArray[selectedIndex]
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //MARK: Custom Tab Bar
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeNavController")
        favoriteViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteNavController")
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsVC")
        viewControllers = [searchViewController, homeViewController, favoriteViewController, settingsViewController]

        
        //User Defaults - Checks what tab to open
        let defaults = UserDefaults.standard
        if let MVCIndex = defaults.string(forKey: "MVCIndex") {
            selectedIndex = Int(MVCIndex)!
        //    print(MVCIndex)
        } else {
            selectedIndex = 1
        //    print(selectedIndex)
        }
        //Opens tab and adds button selection image
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
        
    
     
        
        //TEST -------
        //Good to go. Just clean up the extra code when animation is decided
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        if let launchview = defaults.string(forKey: "InitialVC") {
            if launchview == "MainVC" {
                let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "3xLaunchScreenLogo(V2)")!,iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:0.1529, green:0.1569, blue:0.2275, alpha:1.0))
                
                //Adds the revealing splash view as a sub view
                self.view.addSubview(revealingSplashView)
                
                revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
                //Starts animation
                revealingSplashView.startAnimation(){
                    print("Completed")
                }
            }
        }
        


        

    }

    
   
    

}

