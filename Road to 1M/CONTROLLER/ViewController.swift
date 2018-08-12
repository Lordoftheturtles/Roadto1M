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

//Properties stores across the Application





class ViewController: UIViewController {

    @IBOutlet weak var profileSlider: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel! //-248
    @IBOutlet weak var emailLabel: UILabel!// -248
    @IBOutlet weak var instagramLabel: UILabel! // -248
    @IBOutlet weak var facebookLabel: UILabel! // -248
    @IBOutlet weak var membershipStatusLabel: UILabel! // -248
    @IBOutlet weak var upgradeMembershipButton: UIButton! // -248
    // Membership Button Tapped
    
    
    
    @IBOutlet weak var loggedInLabel: UILabel!
    
    let bundleID = "OneMillionAPP.Road-to-1M"
    
    var Premium = RegisteredPurchase.Premium
    var PremiumAutoRenew = RegisteredPurchase.PremiumAutoRenew
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateHomeScreen()
        hideKeyboard()
        
        
        guard let username = Auth.auth().currentUser?.displayName else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
        loggedInLabel.text = "Logged in as \(username)"
        usernameLabel.text = "\(username)"
    emailLabel.text = "\(email)"
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
    
    @IBOutlet weak var returnProfileSlider: UIButton!
    

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
    
    @IBAction func returnProfileSlide(_ sender: UIButton) {

        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.profileSlider.frame.origin.x += 267})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.usernameLabel.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.emailLabel.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.instagramLabel.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.facebookLabel.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.membershipStatusLabel.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.upgradeMembershipButton.frame.origin.x += 248})
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.returnProfileSlider.frame.origin.x -= 150})
    }
    
    
//// BUTTON ACTIONS
    
    @IBAction func profileButtonTapped(_ sender: UIButton) {
         UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.profileSlider.frame.origin.x -= 267})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.usernameLabel.frame.origin.x -= 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.emailLabel.frame.origin.x -= 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.instagramLabel.frame.origin.x -= 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.facebookLabel.frame.origin.x -= 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.membershipStatusLabel.frame.origin.x -= 248})
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {self.upgradeMembershipButton.frame.origin.x -= 248})
         UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.returnProfileSlider.frame.origin.x += 150})
        
        print("Animating Profile SlideBar")
    }
    
    
@IBAction func upgradeMembershipButtonTapped(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Upgrade", bundle: nil)
    let _ = storyboard.instantiateViewController(withIdentifier: "benefitsViewController") as? UINavigationController
    performSegue(withIdentifier: "benefitSegue", sender: nil)
}


@IBAction func chatIconTapped(_ sender: UIButton) {
    // Perform Segue to chat view
    let storyboard = UIStoryboard(name: "ChatView", bundle: nil)
    let _ = storyboard.instantiateViewController(withIdentifier: "chatViewController") as? UINavigationController
    performSegue(withIdentifier: "chatViewSegue", sender: nil)
    print("Sending user to chat view controller")
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



