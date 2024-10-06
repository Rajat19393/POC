//
//  UIKitViewControllerWrapper.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import SwiftUI
import UIKit

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let tableController = MyTableViewController()
        let navigationController = UINavigationController(rootViewController: tableController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // Update the view controller if needed
    }
}
