//
//  MyTableViewController_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
import UIKit
@testable import Telstra_POC
final class MyTableViewController_Tests: XCTestCase {
    
    var viewController: MyTableViewController!
    
    
    override func setUp() {
        super.setUp()
        viewController = MyTableViewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testTableViewIsNotNil() {
        XCTAssertNotNil(viewController.tableView, "TableView should be initialized and not nil.")
    }
    
    func testViewModelInitialization() {
        XCTAssertNotNil(viewController.viewModel, "ViewModel should be initialized.")
    }
    
    func testNavigationTitle() {
        viewController.refreshUI()
        XCTAssertEqual(viewController.navItem.title, "Loading Title ...", "Navigation title should be set correctly.")
    }
    
    func testTableViewDataSourceMethods() {
        // Mock data
        let mockRows = [
            Row(title: "Row 1", description: "Description 1", imageHref: "https://example.com/image1.png"),
            Row(title: "Row 2", description: "Description 2", imageHref: "https://example.com/image2.png")
        ]
        let mockTableModel = MyTableModel(title: "Mock Title", rows: mockRows)
        viewController.viewModel.myTableModel = mockTableModel
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2, "TableView should have two rows.")
    }
    
    func testRefreshControlEndsRefreshing() {
        viewController.refreshControl.beginRefreshing()
        viewController.refreshUI() // Simulate completion of data loading
        XCTAssertFalse(viewController.refreshControl.isRefreshing, "Refresh control should end refreshing.")
    }
    
}

