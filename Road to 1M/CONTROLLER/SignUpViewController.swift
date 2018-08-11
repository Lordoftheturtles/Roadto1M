//
//  SignUpViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 11/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
class SignUpViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var oneMLogo: UIImageView!
    
   
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Performs function of the register button being tapped
        guard let username = usernameTextField.text,
        username != "",
        let email = emailTextField.text,
        email != "",
        let password = passwordTextField.text,
        password != ""
        else {
            AlertController.showCustomAlert(self, title: "Missing Information", message: "Please fill in the required fields")
            return
            
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in

            guard error == nil else {
                AlertController.showCustomAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            print(user.user.email ?? "Mising Email")
            print(user.user.uid)
            let changeRequest = user.user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    AlertController.showCustomAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            }
      )  })
        
    }
    
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // Performs segue to return to home screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? UINavigationController
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    
}
