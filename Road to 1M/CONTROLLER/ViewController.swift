//
//  ViewController.swift
//  Road to 1M
//  VERSION v1.5 *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import SwiftyStoreKit
import StoreKit

//THINGS TO DO:///////////////////////////////////////////////////
// Work on Share Buttons and getting the share buttons to function
// Check for Bugs and De-Bug
// Remember to save backups to the backup folder
//
//////////////////////////////////////////////////////////////////

var sharedSecret = "a2f4003ecf084c0aab731fd415c09553"


enum RegisteredPurchase : String {
    case Premium = "premium"
    case PremiumAutoRenew = "PremiumSubscription1M"
}


class NetworkActivityIndicatorManager : NSObject {
    private static var loadingCount = 0
    
    class func NetworkOperationStarted() {
        if loadingCount == 0 {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    class func networkOperationFinished() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

class ViewController: UIViewController {

    let bundleID = "OneMillionAPP.Road-to-1M"
    
    var Premium = RegisteredPurchase.Premium
    var PremiumAutoRenew = RegisteredPurchase.PremiumAutoRenew
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
          loginButton.frame = CGRect.init(x: 0, y: 620, width: view.frame.width, height: 50)
        
        // Facebook Access Tokens
        
        
        if (FBSDKAccessToken.current()) != nil  {
            //User is logged in
            print("Has Access token")
           
            animateHomeScreen()
            userHasBeenReturnedToMenu()
        
        } else {
            loadHomeScreen()
        }
    }
    //MARK:- Load Screen Outlets
    @IBOutlet weak var logoMainScreen: UIImageView!
    @IBOutlet weak var textFieldMainScreen: UIImageView!
    @IBOutlet weak var continueButton: UIButton! // +300 2
    @IBOutlet weak var upgradeButton: UIButton! // +300 3
    
 
    /////////// CHANGE TO LOGIN WITH FACEBOOK///////////////
    //MARK:- Homescreen Outlets
    // Outlets for Icon Screen
    @IBOutlet weak var emailListButton: UIButton! // +282 0.5
    @IBOutlet weak var chatIconButton: UIButton! // +282 1
    @IBOutlet weak var businessIconButton: UIButton! // +388 1.2
    @IBOutlet weak var findNicheButton: UIButton! // +391 1.4
    @IBOutlet weak var sharingText: UIImageView! // -275 2
    @IBOutlet weak var fbSharebutton: UIButton! // -236 3
    @IBOutlet weak var twitterShareButton: UIButton! //-236 3.2
    @IBOutlet weak var instagramShareButton: UIButton! // -236 3.4
    
    // IBActions
    
    
    @IBAction func upgradeButtonTabbed(_ sender: Any) {
       
        //MARK:- SEGUE
        let storyboard = UIStoryboard(name: "Upgrade", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "benefitsViewController") as? UINavigationController
        performSegue(withIdentifier: "benefitsSegue", sender: nil)
    }
    
    
    


// Animates whats happened after the continue button has been clicked
@IBAction func continueButtonTapped(_ sender: UIButton) {
    if (FBSDKAccessToken.current()) == nil  {
        let alert = UIAlertController(title: "You must be logged in!", message: "Please login with facebook to use this application! Sending you back to the homescreen!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
        print("Home Screen is Not animating")
    } else {
        animateHomeScreen()
        //Animating if works :)
    }
}


func isUserLoggedIn() {
    if (FBSDKAccessToken.current()) != nil  {
        //User is logged in!
        print("Has Access token")
        //MARK:- SEGUE
        //Perform segue to Chat controller
        let storyboard = UIStoryboard(name: "ChatView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "chatViewController") as? UINavigationController
        performSegue(withIdentifier: "chatViewSegue", sender: nil)
    } else {
        //User is logged out
        let alert = UIAlertController(title: "Sorry", message: "You need to be logged in to use this function", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        print("Needs to be logged in")
        self.present(alert, animated: true)
    }
}
//// BUTTON ACTIONS


@IBAction func chatIconTapped(_ sender: UIButton) {
    isUserLoggedIn()
}

@IBAction func emailListButtonTapped(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "EmailList", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "emailViewController") as? UINavigationController
    performSegue(withIdentifier: "emailListSegue", sender: nil)
    //MARK:- SEGUE
    
}
//NAVIGATION
// WHEN THE RETURN BUTTON IS CALLED!
func userHasBeenReturnedToMenu() {
    if (FBSDKAccessToken.current()) != nil  {
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {self.logoMainScreen.frame.origin.y -= 440})
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseOut, animations: {self.textFieldMainScreen.frame.origin.x += 345})
        
        print("Already Logged in")
        
    }
}
    func getInfo(purchase : RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            self.showAlert(Alert: self.alertForProductRetrievalInfo(result: result))
            
        })
    }
    func purchase(purchase: RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            if case.success(let product) = result {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.showAlert(Alert: self.alertForPurchaseResult(result: result))
            }
            
        })
    }
    func restorePurchases() {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            self.showAlert(Alert: self.alertForRestorePurchases(result: result))
        })
    }
    func verifyReceipt() {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: sharedSecret as! ReceiptValidator, completion: {
        result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            self.showAlert(Alert: self.alertForVerifyReceipt(result: result))
            
            if case .error(let error) = result {
                if case .noReceiptData = error {
                    self.refreshReceipt()
                    
                }
            }
    })
    }
    func verifyPurchase(product: RegisteredPurchase) {
            NetworkActivityIndicatorManager.NetworkOperationStarted()
            SwiftyStoreKit.verifyReceipt(using: sharedSecret as! ReceiptValidator, completion: {
                result in
                NetworkActivityIndicatorManager.networkOperationFinished()
                switch result {
                    
                case .success(let receipt):
                    let productID = self.bundleID + "." + product.rawValue
                    if product == .PremiumAutoRenew {
                        let purchaseResult = SwiftyStoreKit.verifySubscription(ofType: .autoRenewable, productId: productID, inReceipt: receipt, validUntil: Date())
                        self.showAlert(Alert: self.alertForVerifySubscription(result: purchaseResult))
                    } else {
                        let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
                        self.showAlert(Alert: self.alertForVerifyPurchase(result: purchaseResult))
                    }
                case .error(let error):
                self.showAlert(Alert: self.alertForVerifyReceipt(result: result))
                if case .noReceiptData = error {
                    self.refreshReceipt()
                    }
                }
        }
)}
    
    func refreshReceipt() {
        SwiftyStoreKit.fetchReceipt(forceRefresh: true, completion: {
        result in
        self.showAlert(Alert: self.alertForRefreshReceipt(result: result))
    })
}
    
    
    
}
extension ViewController {
    
    func alertWithTitle(title : String, message : String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        return alert
    }
    func showAlert(Alert : UIAlertController) {
        guard let _ = self.presentedViewController else {
            self.present(Alert, animated: true, completion: nil)
            return
        }
        
    }
    func alertForProductRetrievalInfo(result : RetrieveResults) -> UIAlertController {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        }
        else if let invalidProductID = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could not retrieve product info", message: "Invalid product indentifier \(invalidProductID)")
            }
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown Error, please contact support"
            return alertWithTitle(title: "Could not retrieve product info", message: errorString)
            //Fail-Safe
        }
    }
    
        func alertForPurchaseResult(result : PurchaseResult) -> UIAlertController {
            switch result {
            case .success(let product):
                print("Purchase Successful: \(product.productId)")
                /////////////////////////////////////////////////////////////////////////////
                return alertWithTitle(title: "Thank you!", message: "Purchas has been completed!")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                return alertWithTitle(title: "Unknown Error", message: "Contact Support")
                case .clientInvalid: print("Not allowed to make the payment")
                    return alertWithTitle(title: "Error", message: "Not allowed to make the payment")
                case .paymentCancelled: break
                   
                case .paymentInvalid: print("The purchase identifier was invalid")
                    return alertWithTitle(title: "Invalid ID, Purchase Failed", message: "Purchase identifer is invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                    return alertWithTitle(title: "Payment not allowed", message: "This device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                return alertWithTitle(title: "Product not Available", message: "This product is not currently available!")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                    return alertWithTitle(title: "Access Denied", message: "Access to the cloud service is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                    return alertWithTitle(title: "Connection Failed", message: "Could not connect to the network")
                case .cloudServiceRevoked: print("Services Revoked")
                return alertWithTitle(title: "Services Revoked!", message: "Servies have been revoked!")
                }
            }
            return alertWithTitle(title: "Restore Failed", message: "Unknown Error. Please Contact Support")
    }
    
    func alertForRestorePurchases(result : RestoreResults) -> UIAlertController {
        if result.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(result.restoreFailedPurchases)")
        return alertWithTitle(title: "Restore Failed", message: "Unknown Error. Please Contact Support")
    } else if result.restoredPurchases.count > 0 {
    return alertWithTitle(title: "Purchases Restored", message: "All Purchases have been successfully Restored!")
        } else {
    return alertWithTitle(title: "Nothing to Restore", message: "There has been no previous Purchases")
    
}
}
    func alertForVerifyReceipt(result : VerifyReceiptResult) -> UIAlertController {
        switch result {
        case.success(let receipt):
            return alertWithTitle(title: "Receipt Verified", message: "Receipt Verified Remotely")
        case .error(let Error):
            switch Error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data Found!, Application will try get a new one. Try again!")
            default:
                return alertWithTitle(title: "Receipt Verification", message: "Receipt Verification Failed")
            }
            
        }
        
    }
    
    func alertForVerifySubscription(result: VerifySubscriptionResult) -> UIAlertController {
        
        switch result {
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is purchased!", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Not Purchased!", message: "This product has never been purchased!")
        case .expired(let expiryDate):
            return alertWithTitle(title: "Product Expired!", message: "Produc is expired since \(expiryDate)")
        }
    }
    
    func alertForVerifyPurchase(result: VerifyPurchaseResult) -> UIAlertController {
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is purchased!", message: "Product will not expire!")
        case .notPurchased:
            return alertWithTitle(title: "Product is not purchased!", message: "Product has never been purchased!")
        }
    }
    
    func alertForRefreshReceipt(result : FetchReceiptResult) -> UIAlertController {
        
        switch result {
        case .success(let receiptData):
            print(receiptData)
            return alertWithTitle(title: "Receipt Refreshed!", message: "Your receipt has been refreshed!")
        case .error(let error):
            return alertWithTitle(title: "Receipt Refresh Failed!", message: "Your receipt could not be refreshed!")
        }
        
    }
    
    
}
