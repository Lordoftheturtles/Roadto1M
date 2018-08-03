//
//  IAPTableViewController.swift
//  Road to 1M
//
//  Created by David Seymour on 4/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit

class IAPTableViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         IAPService.shared.getProducts()
        tableView.delegate = self
        tableView.dataSource = self
    }
}


