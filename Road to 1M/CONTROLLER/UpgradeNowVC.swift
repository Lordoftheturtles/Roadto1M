//
//  UpgradeNowVC.swift
//  Road to 1M
// Version 1.5v *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import StoreKit
import FBSDKLoginKit
import Firebase
//THINGS TO DO://///////////////////////////////////////////
// 
// Test it works (y)
// Maybe work on making the text field look better
//
////////////////////////////////////////////////////////////


class UpgradeNowVC: UIViewController {
    
    let token = FBSDKAccessToken.current()
    let currentToken = FBSDKAccessToken.currentAccessTokenIsActive()
    
    //MARK:- Upgrade Now Outlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    // Action of when upgrade button has been tapped!
  
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
        performSegue(withIdentifier: "benefitsToHome", sender: nil)
    }

    
}


    

