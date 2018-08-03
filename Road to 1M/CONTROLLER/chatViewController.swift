//
//  chatViewController.swift
//  Road to 1M
//
//  Version 1.5v *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class chatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        animateUponLoad()
        
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect.init(x: 0, y: 620, width: view.frame.width, height: 50)
        
        if (FBSDKAccessToken.current()) != nil  {
            //User is logged in, do work such as go to next view controller
            print("Has Access token")
        } else {
            //Remove User from page
            let alert = UIAlertController(title: "Sorry", message: "You need to be logged in to use this function", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            print("Kicked Out out chat due to not being online")
            self.present(alert, animated: true)
            performSegue(withIdentifier: "kickedOut", sender: self)
        }
        
    }
    //MARK:- CHAT OUTLETS
   
    @IBOutlet weak var joinChatRoom: UIButton!
    
    
    
    //MARK:- CHAT FUNCTIONS
    func animateUponLoad() {
        
        UIView.animate(withDuration: 0.5, delay: 0.2 , options: .curveEaseOut, animations: {self.joinChatRoom.frame.origin.x += 292})
       
        
    }
    @IBAction func chatToHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
        performSegue(withIdentifier: "chatToHome", sender: nil)
    }
    
}

