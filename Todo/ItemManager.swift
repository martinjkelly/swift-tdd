//
//  ItemManager.swift
//  Todo
//
//  Created by Martin Kelly on 08/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import Foundation

class ItemManager {
    
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    
    private var toDoItems: [TodoItem] = []
    private var doneItems: [TodoItem] = []
    
    func add(_ item: TodoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func item(at index: Int) -> TodoItem {
        return toDoItems[index]
    }
    
    func checkItem(at index: Int) {
        
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItem(at index: Int) -> TodoItem {
        return doneItems[index]
    }
    
    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
