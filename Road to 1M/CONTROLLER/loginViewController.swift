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



class loginViewController: UIViewController {
    let context = PersistenceServce.context
    var user: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // IS THE USER LOGGED IN??
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let _ = storyboard.instantiateViewController(withIdentifier: "homeViewController") as? UINavigationController
            performSegue(withIdentifier: "logInSegue", sender: nil)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            storyboard.instantiateInitialViewController()
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK:- Login
    
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

