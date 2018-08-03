
// Products In-App Purchases

import Foundation
import StoreKit


public struct Roadto1MProducts {
  
  public static let premium = "OneMillionAPP.Roadto1M.premium"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [Roadto1M.premium]

  public static let store = IAPHelper(productIds: RazeFaceProducts.productIdentifiers)
}



func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
