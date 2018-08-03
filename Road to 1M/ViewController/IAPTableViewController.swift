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

extension IAPTableViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPre")
        if(indexPath.row == 0){
            cell?.textLabel?.text = "Premium (Beta)"
        }else if(indexPath.row == 1){
            cell?.textLabel?.text = "Premium Membership"
        }else{
            cell?.textLabel?.text = ""
        }
        return cell!
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: IAPService.shared.purchase(product: .nonConsumable)
        case 1: IAPService.shared.purchase(product: .autoRenewingSubsciption)
        default: print("Restore")
        }
    }
    
}
