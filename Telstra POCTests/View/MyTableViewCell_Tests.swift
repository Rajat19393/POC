//
//  MyTableViewCell_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
@testable import Telstra_POC

final class MyTableViewCell_Tests: XCTestCase {

    var cell: MyTableViewCell!

    override func setUp() {
        super.setUp()
        cell = MyTableViewCell(style: .default, reuseIdentifier: Constants.TableViewIds.myTableViewCellReUseId)
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testCellConfiguration() {
        
        let mockRow = Row(title: "Sample Title", description: "Sample Description", imageHref: "")
        cell.fact = mockRow
        XCTAssertEqual(cell.factTitleLabel.text, "Sample Title")
        XCTAssertEqual(cell.factDescriptionLabel.text, "Sample Description")
    }

    func testPrepareForReuse() {
        let mockRow = Row(title: "Sample Title", description: "Sample Description", imageHref: "https://example.com/image.png")
        cell.fact = mockRow
        cell.prepareForReuse()
        XCTAssertNil(cell.factTitleLabel.text, "Title label should be nil after prepareForReuse.")
        XCTAssertNil(cell.factDescriptionLabel.text, "Description label should be nil after prepareForReuse.")
        XCTAssertNil(cell.factImageView.image, "Image view should be nil after prepareForReuse.")
    }


}




