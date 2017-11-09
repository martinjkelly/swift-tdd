//
//  TodoItem.swift
//  Todo
//
//  Created by Martin Kelly on 08/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import Foundation

struct TodoItem: Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: Double? = nil,
         location: Location? = nil) {
        
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    if lhs.location != rhs.location {
        return false
    }
    
    if lhs.title != rhs.title {
        return false
    }
    
    if lhs.itemDescription != rhs.itemDescription {
        return false
    }
    
    if lhs.timestamp != rhs.timestamp {
        return false
    }
    
    return true
}
