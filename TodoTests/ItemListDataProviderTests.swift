//
//  ItemListDataProvider.swift
//  Todo
//
//  Created by Martin Kelly on 09/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import XCTest
@testable import Todo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
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
    
    func test_CellForRow_ReturnsItemCell() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)        
        sut.itemManager?.add(TodoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_CellForRow_CallsConfigCell() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let item = TodoItem(title: "Foo")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.cachedItem, item)
    }
    
    func test_CellForRow_Section2_CellsConfigCellWithDoneItem() {
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let item = TodoItem(title: "Foo")
        sut.itemManager?.add(item)
        
        let second = TodoItem(title: "Bar")
        sut.itemManager?.add(second)
        sut.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.cachedItem, second)
    }
    
    func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(
            tableView,
            titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0)
        )
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_DeleteButton_InSecondSection_ShowsTitleUncheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(
            tableView,
            titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1)
        )
        
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func test_CheckingAnItem_ChecksItInTheItemManager() {
        sut.itemManager?.add(TodoItem(title: "Foo"))
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func test_UncheckingAnItem_UnchecksItInTheItemManager() {
        sut.itemManager?.add(TodoItem(title: "First"))
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
    }
}

extension ItemListDataProviderTests {
    
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView(withDataSource datasource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
            mockTableView.dataSource = datasource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
    }
    
    class MockItemCell: ItemCell {
        var cachedItem: TodoItem?
        
        override func configCell(with item: TodoItem, checked: Bool = false) {
            cachedItem = item
        }
    }
}
