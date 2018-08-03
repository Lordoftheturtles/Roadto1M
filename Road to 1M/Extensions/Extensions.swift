//
//  InAppPurchasesExtensions.swift
//  Road to 1M
//
//  Created by David Seymour on 4/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import StoreKit
import Firebase
import FBSDKLoginKit

//MARK:- In-App Purchases Extensions
extension IAPTableViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPre")
        if(indexPath.row == 0){
            cell?.textLabel?.text = "Premium (Beta)"
        }else if(indexPath.row == 1){
            cell?.textLabel?.text = "Premium Membership"
        }else{
            cell?.textLabel?.text = ""
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: IAPService.shared.purchase(product: .nonConsumable)
        case 1: IAPService.shared.purchase(product: .autoRenewingSubsciption)
        default: print("Restore")
        }
    }
    
}
//MARK:- Email List Extension

extension ViewController {
    //MARK:- ANIMATIONS
    func animateHomeScreen() {
        self.continueButton.isHidden = true
        self.upgradeButton.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {self.emailListButton.frame.origin.y += 282})
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {self.chatIconButton.frame.origin.y += 282})
        UIView.animate(withDuration: 1, delay: 1.2, options: .curveEaseOut, animations: {self.businessIconButton.frame.origin.y += 388})
        UIView.animate(withDuration: 1, delay: 1.4, options: .curveEaseOut, animations: {self.findNicheButton.frame.origin.y += 391})
        UIView.animate(withDuration: 1, delay: 2, options: .curveEaseOut, animations: {self.sharingText.frame.origin.y -= 275})
        UIView.animate(withDuration: 1, delay: 3, options: .curveEaseOut, animations: {self.fbSharebutton.frame.origin.y -= 236})
        UIView.animate(withDuration: 1, delay: 3.2, options: .curveEaseOut, animations: {self.twitterShareButton.frame.origin.y -= 236})
        UIView.animate(withDuration: 1, delay: 3.4, options: .curveEaseOut, animations: {self.instagramShareButton.frame.origin.y -= 236})
        print("Icons are in place!")
        
    }
    
    
    
    func loadHomeScreen () {
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {self.logoMainScreen.frame.origin.y -= 440})
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseOut, animations: {self.textFieldMainScreen.frame.origin.x += 345})
        UIView.animate(withDuration: 1.5,delay: 2, options: .curveEaseOut, animations: {self.continueButton.frame.origin.x += 300})
        UIView.animate(withDuration: 1.5, delay: 3, options: .curveEaseOut, animations: {self.upgradeButton.frame.origin.x += 300})
        
        let alert = UIAlertController(title: "Welcome!", message: "Welcome to Road to One Million Application! - Alpha Version - 1M Development Team", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue!", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
        
    }
}
