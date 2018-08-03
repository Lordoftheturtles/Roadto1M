//
//  IAPVC.swift
//  Road to 1M
//
//  Created by David Seymour on 3/8/18.
//  Copyright © 2018 1M. All rights reserved.
//

import UIKit

class IAPVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPService.shared.getProducts()
        
    
}


