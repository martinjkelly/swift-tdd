//
//  ItemListDataProvider.swift
//  Todo
//
//  Created by Martin Kelly on 09/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import XCTest
@testable import Todo

class ItemListDataProviderTest: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        tableView = UITableView()
        tableView.dataSource = sut
    }
    
    func test_NumberOfSections_IsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_Section1_IsToDoCount() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(TodoItem(title: "Bar"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_NumberOfRows_Section2_IsDoneCount() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        sut.itemManager?.add(TodoItem(title: "Bar"))
        sut.itemManager?.checkItem(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
}
