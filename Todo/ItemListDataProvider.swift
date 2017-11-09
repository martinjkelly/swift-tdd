//
//  ItemListDataProvider.swift
//  Todo
//
//  Created by Martin Kelly on 09/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import UIKit

enum Section: Int {
    case toDo
    case done
}

class ItemListDataProvider: NSObject, UITableViewDataSource {

    var itemManager: ItemManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else {
            fatalError()
        }
        
        switch itemSection {
        case .toDo:
            return itemManager.toDoCount
        case .done:
            return itemManager.doneCount
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
