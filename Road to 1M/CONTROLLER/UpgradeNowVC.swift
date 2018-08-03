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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    // Action of when upgrade button has been tapped!
    @IBAction func upgradeNowButtonTapped(_ sender: UIButton) {
//        if (FBSDKAccessToken.current()) == nil {
//            let alert = UIAlertController(title: "You need to be logged in!", message: "You need to be logged in to Facebook to Upgrade!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Okay!", style: .cancel, handler: nil))
//            self.present(alert, animated: true,completion: nil)
//            //Isnt Logged in,
//            print("Not Logged in, cannot complete Purchase")
//        } else {
//            if (FBSDKAccessToken.current()) != nil {
//                print("Can Buy!")
//                // Is Logged in!
        performSegue(withIdentifier: "IAPSegue", sender: self)
        
            }
        }
    //}
    
//}
