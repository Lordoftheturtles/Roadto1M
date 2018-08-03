//
//  EmailListViewController.swift
//  Road to 1M
//
//  Version 1.5v *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreData
//THINGS TO DO://////////////////////////////
// Add External Email Function
// Store Email names into List (Store Data)
// Paste the data into external email function
// Have a Pre-Made Message for the User
// Make the VC Look "Prettier"
//////////////////////////////////////////////


private let reuseIdentifier = "Cell"

class EmailListViewController: UIViewController, UITextFieldDelegate {
    
  let context = PersistenceServce.context
    
    @IBOutlet weak var tableView: UITableView!
    var emailName: [User] = []
    var deleteEmail: NSIndexPath? = nil
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    
    //MARK:- EMAIL LIST VARIABLES
    var titleTextField: UITextField!
    
    //MARK:- TITLE FUNCTION

    
    func titleTextField(textfield: UITextField!)
    {
        titleTextField = textfield.self
        titleTextField.placeholder = "email@domain.com"
        
        
    }
    //MARK:- EMAIL BUTTON ACTIONS
    @IBAction func addEmailButton(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add Email to List", message: "Insert Email Address Below", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Save", style: .default, handler: self.save)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
    
        alert.addTextField(configurationHandler: self.titleTextField)
        self.present(alert, animated: true, completion: nil)
    }
    
 
    
    
    func save(alert: UIAlertAction) {
       
        let user = User(context: PersistenceServce.context)
       let email = titleTextField.text
        let providedEmailAddress = email
        
        // Format, email@emaildomain.com
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress!)
        if isEmailAddressValid {
            user.email = email
            
        } else {
            print("Email Adress is not valid, must follow format email@domain.com")
            let alert = UIAlertController(title: "Could not add Email to list!", message: "Email does not follow the correct format! The Correct format is email@domain.com", preferredStyle: .alert)
            let addAction2 = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(addAction2)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        PersistenceServce.saveContext()
        emailName.append(user)
        self.tableView.reloadData()
       
}

    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return returnValue
    }
}

extension EmailListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let email = emailName[indexPath.row].email
        cell.textLabel?.text = email
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailName.count
    }
    
    func saveData() {
        do {
            try context.save()
            
        } catch {
            print("Error, Could not Save to Coredata!")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            emailName = try context.fetch(fetchRequest)
        } catch {
            print("Error Fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let emailToRemove = emailName[indexPath.row]
            emailName.remove(at: indexPath.row)
            context.delete(emailToRemove)
            do {
                try context.save()
                
            } catch {
                print("Errors deleting emails with \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
}




