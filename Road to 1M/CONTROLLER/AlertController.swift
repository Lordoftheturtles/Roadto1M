//
//  AlertController.swift
//  Road to 1M
//
//  Created by David Seymour on 12/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import Firebase
import UIKit

class AlertController {
    
    static func showCustomAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}

