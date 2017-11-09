//
//  ItemListViewController.swift
//  Todo
//
//  Created by Martin Kelly on 09/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
}
