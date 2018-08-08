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

// UIViewController
class UpgradeNowVC: ViewController {
    
    let token = FBSDKAccessToken.current()
    let currentToken = FBSDKAccessToken.currentAccessTokenIsActive()
    
    @IBOutlet weak var oneTimePay: UIButton!
    @IBOutlet weak var becomeAMember: UIButton!
    @IBOutlet weak var upgradeNow: UIButton!
    @IBOutlet weak var becomeAMemberLogo: UIImageView!
    @IBOutlet weak var oneTimePaymentLogo: UIImageView!
    @IBOutlet weak var slideUpBar: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    
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
// StoreKit Action buttons
    @IBAction func oneTimePayButtonTapped(_ sender: UIButton) {
        print("One Time Pay Button Tapped")
        purchase(purchase: Premium)
    }
    
    @IBAction func becomeAMemberButtonTapped(_ sender: UIButton) {
        print("Become a Member Button Tapped!")
        purchase(purchase: PremiumAutoRenew)
    }
    //Animation Buttons
    @IBAction func upgradeNowButtonTapped(_ sender: UIButton) {
        print("Upgrade Now Button Tapped")
        loadUpgradeBar()
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        cancelUpgradeBar()
    }
    
    
    
    // Loads the Upgrade Bar
    func loadUpgradeBar() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.slideUpBar.frame.origin.y -= 200})
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.oneTimePaymentLogo.frame.origin.y -= 200})
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.becomeAMemberLogo.frame.origin.y -= 200})
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.oneTimePay.frame.origin.y -= 200})
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {self.becomeAMember.frame.origin.y -= 200})
        UIView.animate(withDuration: 2, delay: 1.5, options: .curveEaseOut, animations: {self.cancelButton.frame.origin.x += 80})
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {self.upgradeNow.frame.origin.x -= 400})
        print("Your upgrade bar is loading!!")
    }
    // Hides Upgrade Bar
    func cancelUpgradeBar() {
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.slideUpBar.frame.origin.y += 200})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.oneTimePaymentLogo.frame.origin.y += 200})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.becomeAMemberLogo.frame.origin.y += 200})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.oneTimePay.frame.origin.y += 200})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.becomeAMember.frame.origin.y += 200})
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {self.cancelButton.frame.origin.x -= 80})
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {self.upgradeNow.frame.origin.x += 400})
        print("We are hiding your upgrade bar!")
    }
}


    

