//
//  ItemManagerTests.swift
//  Todo
//
//  Created by Martin Kelly on 08/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import XCTest
@testable import Todo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        self.sut = ItemManager()
    }
    
    func test_ToDoCount_Initially_IsZero() {
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreasesTodoCountToOne() {
        sut.add(TodoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_ReturnsAddedItem() {
        let item = TodoItem(title: "Foo")
        sut.add(item)
        
        let returnedItem = sut.item(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCounts() {
        sut.add(TodoItem(title: ""))
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func test_CheckItemAt_RemovesItFromToDoItems() {
        let first = TodoItem(title: "First")
        let second = TodoItem(title: "Second")
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Second")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = TodoItem(title: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func test_EqualItems_AreEqual() {
        let first = TodoItem(title: "Foo")
        let second = TodoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Items_WhenLocationDiffers_AreNotEqual() {
        let first = TodoItem(title: "", location: Location(name: "Foo"))
        let second = TodoItem(title: "", location: Location(name: "Bar"))
        
        XCTAssertNotEqual(first, second)
    }
    
    func test_RemoveAll_ResultsInCountBeZero() {
        sut.add(TodoItem(title: "Foo"))
        sut.add(TodoItem(title: "Bar"))
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_Add_WhenItemIsAlreadyAdded_DoesNothing() {
        sut.add(TodoItem(title: "Foo"))
        sut.add(TodoItem(title: "Foo"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
}
