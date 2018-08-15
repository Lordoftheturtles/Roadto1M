//
//  businessHomePage.swift
//  Road to 1M
//
//  Created by David Seymour on 15/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftyStoreKit
import StoreKit
import FirebaseAuth


class businessHomePage: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loggedInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = Auth.auth().currentUser?.displayName else { return }
        guard let titleUserName = Auth.auth().currentUser?.displayName else { return }
        titleLabel.text = "\(titleUserName)'s Business"
 loggedInLabel.text = "Logged in as \(username)"
        
        
        
    }
    //MARK:- OUTLETS
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bronzeCourseButton: UIButton!
    @IBOutlet weak var silverCourseButton: UIButton!
    @IBOutlet weak var goldCourseButton: UIButton!
    @IBOutlet weak var platinumCourseButton: UIButton!
   
    
    //MARK:- Button function Actions
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        //Performs Segue to Main View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
        performSegue(withIdentifier: "businessToHome", sender: nil)
        print("Sending user back to home!")
    }
    
    @IBAction func bronzeButtonTapped(_ sender: UIButton) {
        //All user can use the bronze course!
        //Performs segue to bronze course view controller
        print("Bronze Button Tapped")
    }
    
    @IBAction func silverButtonTapped(_ sender: UIButton) {
        //All users can use the silver course
        // Checks to see if bronze course has been completed
        // Performs segue to silver course controller
        print("Silver Button Tapped")
    }
    
    
    @IBAction func goldButtonTapped(_ sender: UIButton) {
        //Only "Gold Users" can use the gold course
        //CHecks to see if silver and bronze course has been completed
        // Checks if user is a gold user / Has purchased Gold Premium
        //Performs segue to Gold Course
        print("Gold Button Tapped")
    }
    
    @IBAction func platinumButtonTapped(_ sender: UIButton) {
        //Only Platinum users can use the platinum course
        //Checks to see if Gold silver and bronze courses have been completed
        //Checks if user is platinum user / Has purchased Platinum
        //Performs segue to Platinum course
        print("Platinum Button Tapped")
    }
    
    //MARK:- Functions
    
    
    
    
}
