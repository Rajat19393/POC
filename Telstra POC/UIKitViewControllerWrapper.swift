//
//  UIKitViewControllerWrapper.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import SwiftUI
import UIKit

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MyTableViewController
    
    func makeUIViewController(context: Context) -> MyTableViewController {
        return MyTableViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyTableViewController, context: Context) {
        // Update the view controller if needed
    }
}
