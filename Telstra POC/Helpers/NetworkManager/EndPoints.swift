//
//  EndPoints.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import Foundation

protocol API {
    static var baseURL:URL { get }
}

enum EndPoints : String, API {
    
    static var baseURL: URL {
        URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/")!
    }
    
    case facts = "facts.json"
    
}

extension RawRepresentable where RawValue == String , Self: API {
    var url: URL { Self.baseURL.appendingPathComponent(rawValue) }
}
