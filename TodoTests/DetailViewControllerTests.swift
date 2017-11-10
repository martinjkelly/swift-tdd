//
//  DetailViewControllerTests.swift
//  Todo
//
//  Created by Martin Kelly on 10/11/2017.
//  Copyright © 2017 Scriptable Ltd. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Todo

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    var itemManager: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        itemManager = ItemManager()
        sut.loadViewIfNeeded()
    }
    
    func test_HasTitleLabel() {
        let titleLabelIsSubView = sut.titleLabel?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(titleLabelIsSubView)
    }
    
    func test_HasMapView() {
        let mapViewIsSubView = sut.mapView?.isDescendant(of: sut.view) ?? false
        XCTAssertTrue(mapViewIsSubView)
    }
    
    func test_SettingItemInfo_SetsTitleLabel() {
        let item = TodoItem(title: "Bar")
        
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Bar")
    }
    
    func test_SettingItemInfo_SetsDateLabel() {
        let item = TodoItem(title: "Foo", timestamp: 1456150025)
        itemManager.add(item)
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
    }
    
    func test_SettingItemInfo_SetsDescriptionLabel() {
        let item = TodoItem(title: "Foo", itemDescription: "Baz")
        itemManager.add(item)
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
    }
    
    func test_SettingItemInfo_SetsLocationLabel() {
        let location = Location(name: "Foo")
        let item = TodoItem(title: "Foo", location: location)
        
        itemManager.add(item)
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Foo")
    }
    
    func test_SettingItemInfo_SetsMapView() {
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = TodoItem(title: "Foo", location: location)
        
        itemManager.add(item)
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
    }
}
