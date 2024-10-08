//
//  UIImageView_Tests.swift
//  Telstra POCTests
//
//  Created by Rajat Kumar on 07/10/24.
//

import XCTest
@testable import Telstra_POC

final class UIImageView_Tests: XCTestCase {
    
    var networkManager: NetworkManager!
    var imageLoader: ImageLoader!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockNetworkURLProtocol.self]
        let session = URLSession(configuration: configuration)
        networkManager = NetworkManager(session: session)
        
        URLProtocol.registerClass(MockNetworkURLProtocol.self)
        
        imageLoader = ImageLoader()
    }
    
    override func tearDown() {
        MockNetworkURLProtocol.stubError = nil
        MockNetworkURLProtocol.stubResponse = nil
        URLProtocol.unregisterClass(MockNetworkURLProtocol.self)
        imageLoader = nil
        super.tearDown()
    }
    
    func testLoadImageSuccess() {
        let expectation = self.expectation(description: "Image should be loaded successfully")
        
        guard let url = URL(string: "https://example.com/image.png") else {
            XCTFail("Invalid URL")
            return
        }
        let mockData = UIImage(systemName: "star")!.pngData()!
        
        MockNetworkURLProtocol.stubResponse = mockData
        
        let token = imageLoader.loadImage(url) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure(let error):
                XCTFail("Expected success, got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(token, "Expected a token for the image load operation")
    }
    
    func testLoadImageFailure() {
        let expectation = self.expectation(description: "Image load should fail")
        
        guard let url = URL(string: "https://example.com/nonexistent.png") else {
            XCTFail("Invalid URL")
            return
        }
        MockNetworkURLProtocol.stubError = NetworkError.invalidData
        
        let _ = imageLoader.loadImage(url) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCancelImageLoad() {
        let expectation = self.expectation(description: "Image load should be cancelled")
        
        guard let url = URL(string: "https://example.com/image.png") else {
            XCTFail("Invalid URL")
            return
        }
        
        let token = imageLoader.loadImage(url) { result in
            XCTFail("Image load should have been cancelled")
        }
        
        imageLoader.cancelLoad(token!)
        
        // Wait a bit to ensure the cancel operation is processed
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
