//
//  IAPTableViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 4/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit

class IAPTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         IAPService.shared.getProducts()
    }

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0: IAPService.shared.purchase(product: .nonConsumable)
    case 1: IAPService.shared.purchase(product: .autoRenewingSubsciption)
    default: print("Restore")
        
    }
}
}
