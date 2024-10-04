//
//  MyTableModel.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import Foundation

import Foundation

// MARK: - MyTableModel
struct MyTableModel: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
struct Row: Codable {
    let title, description: String?
    let imageHref: String?
}
