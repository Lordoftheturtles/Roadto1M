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
    }
    //MARK:- CHAT OUTLETS
   
    @IBOutlet weak var joinChatRoom: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    
    
    
    //MARK:- CHAT FUNCTIONS
    func animateUponLoad() {
        
        UIView.animate(withDuration: 0.5, delay: 0.2 , options: .curveEaseOut, animations: {self.joinChatRoom.frame.origin.x += 292})
       
        
    }
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
        performSegue(withIdentifier: "chatToHome", sender: nil)
    }
    
}

