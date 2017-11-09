//
//  ToDoItemTests.swift
//  Todo
//
//  Created by Martin Kelly on 08/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import XCTest
@testable import Todo

class ToDoItemTests: XCTestCase {
    
    func test_Init_TakesTitle() {
        let item = TodoItem(title: "Foo")
        XCTAssertEqual(item.title, "Foo", "should set title")
    }
    
    func test_Init_TakesTitleAndDescription() {
        let item = TodoItem(title: "", itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar", "should set itemDescription")
    }
    
    func test_Init_SetsTimestamp() {
        _ = TodoItem(title: "", timestamp: 0.0)
    }
    
    func test_Init_WhenGivenLocation_SetsLocation() {
        let location = Location(name: "Foo")
        let item = TodoItem(title: "", location: location)
        
        XCTAssertEqual(item.location?.name, location.name, "should set location")
    }
    
    func test_Items_WhenOneLocationIsNil_AreNotEqual() {
        let first = TodoItem(title: "", location: Location(name: "Foo"))
        let second = TodoItem(title: "", location: nil)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenTimestampsDiffer_AreNotEqual() {
        let first = TodoItem(title: "Foo",
        timestamp: 1.0)
        let second = TodoItem(title: "Foo",
            timestamp: 0.0)
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenDescriptionsDiffer_AreNotEqual() {
        let first = TodoItem(title: "Foo", itemDescription: "Bar")
        let second = TodoItem(title: "Foo", itemDescription: "Baz")
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_Items_WhenTitlesDiffer_AreNotEqual() {
        let first = TodoItem(title: "Foo")
        let second = TodoItem(title: "Bar")
        
        XCTAssertNotEqual(first, second)
    }
}
