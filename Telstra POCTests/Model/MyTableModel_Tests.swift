//
//  MyTableModel_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
@testable import Telstra_POC

final class MyTableModel_Tests: XCTestCase {
    
    func testMyTableModelEncodingAndDecoding() throws {
        let rows = [Row(title: "Row Title", description: "Row Description", imageHref: "http://example.com/image.png")]
        let model = MyTableModel(title: "Table Title", rows: rows)
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(model)
        
        let decodedModel = try decoder.decode(MyTableModel.self, from: data)
        
        XCTAssertEqual(model.title, decodedModel.title)
        XCTAssertEqual(model.rows.count, decodedModel.rows.count)
        XCTAssertEqual(model.rows[0].title, decodedModel.rows[0].title)
        XCTAssertEqual(model.rows[0].description, decodedModel.rows[0].description)
        XCTAssertEqual(model.rows[0].imageHref, decodedModel.rows[0].imageHref)
    }
    
    func testMyTableModelDecodingWithNilValues() throws {
        let jsonData = """
        {
            "title": "Table Title",
            "rows": [
                {
                    "title": null,
                    "description": null,
                    "imageHref": null
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let decodedModel = try decoder.decode(MyTableModel.self, from: jsonData)
        
        XCTAssertEqual(decodedModel.title, "Table Title")
        XCTAssertEqual(decodedModel.rows.count, 1)
        XCTAssertNil(decodedModel.rows[0].title)
        XCTAssertNil(decodedModel.rows[0].description)
        XCTAssertNil(decodedModel.rows[0].imageHref)
    }
}
