//
//  NetworkManager_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
import Foundation

@testable import Telstra_POC


class MockNetworkURLProtocol: URLProtocol {
    static var stubResponse: Data?
    static var stubError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true // Capture all requests
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockNetworkURLProtocol.stubError {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let data = MockNetworkURLProtocol.stubResponse {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        // No cleanup needed for the mock
    }
}

final class NetworkManager_Tests: XCTestCase {
    
    var networkManager: NetworkManager!
    
    
    override func setUp() {
        super.setUp()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockNetworkURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        networkManager = NetworkManager(session: session)
        
        URLProtocol.registerClass(MockNetworkURLProtocol.self)
    }
    
    override func tearDown() {
        
        MockNetworkURLProtocol.stubError = nil
        MockNetworkURLProtocol.stubResponse = nil
        
        URLProtocol.unregisterClass(MockNetworkURLProtocol.self)
        
        super.tearDown()
    }
    
    func testFetchFactsSuccess() {
        let expectation = self.expectation(description: "Fetch facts successfully")
        
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
        """.data(using: .isoLatin1)!
        
        MockNetworkURLProtocol.stubResponse = jsonData
        
        networkManager.fetchFacts() { (facts: MyTableModel?, error) in
            XCTAssertNotNil(facts)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchFactsNetworkError() {
        let expectation = self.expectation(description: "Fetch facts fails due to network error")
        
        MockNetworkURLProtocol.stubError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        networkManager.fetchFacts { (facts: MyTableModel?, error) in
            XCTAssertNil(facts)
            XCTAssertNotNil(error)
            XCTAssertEqual((error as NSError?)?.code, NSURLErrorNotConnectedToInternet)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

