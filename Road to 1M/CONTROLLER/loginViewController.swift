//
//  loginViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 11/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth

// Implementing a login screen instead of using facebook, having it send to Firebase. Able to sign in, and sign out at homescreen, Forgot password feature
// and a register feature

class loginViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        isCurrentUserLoggedIn() // MARK:- Login, Checks to see if user is logged in
        
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK:- Login
    func isCurrentUserLoggedIn() {
        if Auth.auth().currentUser != nil {
            //Perform Segue
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
            performSegue(withIdentifier: "logInSegue", sender: nil)
            print("User has been logged in!")
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let _ = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? UINavigationController
            performSegue(withIdentifier: "signOutSegue", sender: nil)
            print("User could not be logged in!")
           
        }
        
    }
    
    
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
            guard let email = emailTextField.text,
            email != "",
            let password = passwordTextField.text,
            password != ""
            else {
            AlertController.showCustomAlert(self, title: "Missing information", message: "Please fill out the required fields!")
            return
            }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
            AlertController.showCustomAlert(self, title: "Error", message: error!.localizedDescription)
                return
        }
            guard let user = user else { return }
            print(user.user.email ?? "Missing Email")
            print(user.user.displayName ?? "Missing Display Name")
            print(user.user.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
            self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }
    )}
    

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? UINavigationController
        performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "forgotPasswordViewController") as? UINavigationController
        performSegue(withIdentifier: "forgotPasswordSegue", sender: nil)
    }
   
}

