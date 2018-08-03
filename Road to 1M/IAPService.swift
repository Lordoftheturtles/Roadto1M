//
//  IAPService.swift
//  Road to 1M
//
//  Created by David Seymour on 3/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import Foundation
import StoreKit


class IAPService: NSObject {
    
    private override init() {}
    static let shared = IAPService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    //Get the products we have, get information back from product (StoreKit Product)
    
    func getProducts() {
        let products: Set =
        [IAPProduct.nonConsumable.rawValue,
        IAPProduct.autoRenewingSubsciption.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
        //Starts request and trys to get information
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({  $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
}


extension IAPService: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState)
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
            case.deferred: return("deferred")
            case.failed: return("failed")
            case.purchased: return("purchased")
            case.purchasing: return("purchasing")
            case.restored: return("restored")
        }
    }
}






