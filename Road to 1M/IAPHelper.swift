

import StoreKit



public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

extension Notification.Name {
  static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}

open class IAPHelper: NSObject  {
    
    public init(productIds: Set<ProductIdentifier>){
    super.init()
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
    completionHandler(false, [])
  }

  public func buyProduct(_ product: SKProduct) {
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return false
  }
  
  public class func canMakePayments() -> Bool {
    return true
  }
  
  public func restorePurchases() {
  }
}
