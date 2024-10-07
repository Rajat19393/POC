//
//  API_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import Foundation

import XCTest
@testable import Telstra_POC

final class API_Tests: XCTestCase {

    func testBaseURL() {
        // Verify that the base URL is correct
        let expectedBaseURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/")!
        XCTAssertEqual(EndPoints.baseURL, expectedBaseURL, "Base URL should match the expected URL")
    }

    func testFactsEndpointURL() {
        // Verify that the facts endpoint constructs the correct URL
        let expectedURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        XCTAssertEqual(EndPoints.facts.url, expectedURL, "Facts endpoint URL should match the expected URL")
    }
}
