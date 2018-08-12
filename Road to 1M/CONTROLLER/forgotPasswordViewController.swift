//
//  forgotPasswordViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 11/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import CoreData

class forgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()

}
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBAction func recoverButtonTapped(_ sender: UIButton) {
        // What happens after Recover button has been tapped
       guard let email = emailTextField.text,
        email != ""
    else {
        AlertController.showCustomAlert(self, title: "Missing Information", message: "Please fill out the required fields")
                return
        }
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        // Sends the password reset form
        let alert = UIAlertController(title: "Password Reset", message: "A password recovery form has been sent to the email you have provided!", preferredStyle: .alert)
        let addaction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(addaction)
        self.present(alert, animated: true, completion: nil)
        return
}
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let _ = storyboard.instantiateViewController(withIdentifier: "loginViewController") as? UINavigationController
        performSegue(withIdentifier: "returnToLogIn", sender: nil)
    
}
}
