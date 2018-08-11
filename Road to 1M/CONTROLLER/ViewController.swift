//
//  ViewController.swift
//  Road to 1M
//  VERSION v1.5 *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftyStoreKit
import StoreKit
import FirebaseAuth

//THINGS TO DO:///////////////////////////////////////////////////
// Work on Share Buttons and getting the share buttons to function
// Check for Bugs and De-Bug
// Remember to save backups to the backup folder
//
//////////////////////////////////////////////////////////////////
// Upgrade Button
//let storyboard = UIStoryboard(name: "Upgrade", bundle: nil)
//let vc = storyboard.instantiateViewController(withIdentifier: "benefitsViewController") as? UINavigationController
//performSegue(withIdentifier: "benefitSegue", sender: nil)
//}




class ViewController: UIViewController {

    
    
    @IBOutlet weak var loggedInLabel: UILabel!
    
    let bundleID = "OneMillionAPP.Road-to-1M"
    
    var Premium = RegisteredPurchase.Premium
    var PremiumAutoRenew = RegisteredPurchase.PremiumAutoRenew
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateHomeScreen()
        hideKeyboard()
        guard let username = Auth.auth().currentUser?.displayName else { return }
        
        loggedInLabel.text = "Logged in as \(username)"
        
        }
    
    @IBOutlet weak var logoMainScreen: UIImageView!
    @IBOutlet weak var textFieldMainScreen: UIImageView!
 //MARK:- Homescreen Outlets
    // Outlets for Icon Screen
    @IBOutlet weak var emailListButton: UIButton! // +282 0.5
    @IBOutlet weak var chatIconButton: UIButton! // +282 1
    @IBOutlet weak var businessIconButton: UIButton! // +388 1.2
    @IBOutlet weak var findNicheButton: UIButton! // +391 1.4
    @IBOutlet weak var sharingText: UIImageView! // -275 2
    @IBOutlet weak var fbSharebutton: UIButton! // -236 3
    @IBOutlet weak var twitterShareButton: UIButton! //-236 3.2
    @IBOutlet weak var instagramShareButton: UIButton! // -236 3.4
    


    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        //Performs function when signout has been tapped
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let _ = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? UINavigationController
            performSegue(withIdentifier: "signOutSegue", sender: nil)
        } catch {
            print(error)
        }
    }
    

func isUserLoggedIn() {
    if Auth.auth().currentUser != nil {
        //User is logged in!
        print("Has Access token")
        //MARK:- SEGUE
        //Perform segue to Chat controller
        let storyboard = UIStoryboard(name: "ChatView", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "chatViewController") as? UINavigationController
        performSegue(withIdentifier: "chatViewSegue", sender: nil)
    } else {
        //User is logged out
        let alert = UIAlertController(title: "Sorry", message: "You need to be logged in to use this function", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        print("Needs to be logged in")
        self.present(alert, animated: true)
    }
}
//// BUTTON ACTIONS


@IBAction func chatIconTapped(_ sender: UIButton) {
    isUserLoggedIn()
}

@IBAction func emailListButtonTapped(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "EmailList", bundle: nil)
    let _ = storyboard.instantiateViewController(withIdentifier: "emailViewController") as? UINavigationController
    performSegue(withIdentifier: "emailListSegue", sender: nil)
    //MARK:- SEGUE
    
}
//NAVIGATION
    //MARK:- ANIMATIONS
    func animateHomeScreen() {
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {self.emailListButton.frame.origin.y += 282})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.chatIconButton.frame.origin.y += 282})
        UIView.animate(withDuration: 1, delay: 1.2, options: .curveEaseOut, animations: {self.businessIconButton.frame.origin.y += 388})
        UIView.animate(withDuration: 1, delay: 1.4, options: .curveEaseOut, animations: {self.findNicheButton.frame.origin.y += 391})
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {self.sharingText.frame.origin.y -= 275})
        UIView.animate(withDuration: 1, delay: 3, options: .curveEaseOut, animations: {self.fbSharebutton.frame.origin.y -= 236})
        UIView.animate(withDuration: 1, delay: 3.2, options: .curveEaseOut, animations: {self.twitterShareButton.frame.origin.y -= 236})
        UIView.animate(withDuration: 1, delay: 3.4, options: .curveEaseOut, animations: {self.instagramShareButton.frame.origin.y -= 236})
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {self.logoMainScreen.frame.origin.y -= 440})
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseOut, animations: {self.textFieldMainScreen.frame.origin.x += 345})
         print("Icons are in place!")
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
