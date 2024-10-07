//
//  MyTableViewModel_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
@testable import Telstra_POC

class MockViewModel: MyTableViewInput {
    var myTableModel: MyTableModel?

    func refreshData() {
        myTableModel = getRefreshedObject()
    }
    
    func fetchFacts() {
        myTableModel = getfetchedObject()
    }
    
    func getfetchedObject() -> MyTableModel {
        let title = "Sample Title"
        let row1 = Row(title: "Fact 1", description: "Description 1", imageHref: "Link1")
        let row2 = Row(title: "Fact 2", description: "Description 2", imageHref: "Link2")

        return MyTableModel(title: title, rows: [row1,row2])
    }
    
    func getRefreshedObject() -> MyTableModel {
        let title = "Refreshed Title"
        let row1 = Row(title: "Refreshed Fact 1", description: "Refreshed Description 1", imageHref: "Refreshed Link1")
        let row2 = Row(title: "Refreshed Fact 2", description: "Refreshed Description 2", imageHref: "Refreshed Link2")

        return MyTableModel(title: title, rows: [row1,row2])
    }
    
}


final class MyTableViewModel_Tests: XCTestCase {
    var viewModel: MyTableViewInput!

    override func setUp() {
        super.setUp()
        viewModel = MockViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchFactsSuccess() {

        // Call fetchFacts
        viewModel.fetchFacts()
        let expectation = self.expectation(description: "Wait for fetch facts completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.myTableModel)
            XCTAssertEqual(self.viewModel.myTableModel?.title, "Sample Title")
            XCTAssertEqual(self.viewModel.myTableModel?.rows.count, 2)
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].title, "Fact 1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].description, "Description 1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].imageHref, "Link1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].title, "Fact 2")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].description, "Description 2")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].imageHref, "Link2")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchFactsFailure() {
        // Set up mock response for failure
        viewModel.refreshData()
        let expectation = self.expectation(description: "Wait for refreshed facts ")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.myTableModel)
            XCTAssertEqual(self.viewModel.myTableModel?.title, "Refreshed Title")
            XCTAssertEqual(self.viewModel.myTableModel?.rows.count, 2)
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].title, "Refreshed Fact 1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].description, "Refreshed Description 1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[0].imageHref, "Refreshed Link1")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].title, "Refreshed Fact 2")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].description, "Refreshed Description 2")
            XCTAssertEqual(self.viewModel.myTableModel?.rows[1].imageHref, "Refreshed Link2")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

}
