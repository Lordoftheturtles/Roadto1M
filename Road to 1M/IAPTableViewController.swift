//
//  IAPTableViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 3/8/18.
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
        case 0: print("non-consumeable")
        case 1: print("auto-renewable-sub")
        default:
            print("Restore")
        }
    }
    
}
