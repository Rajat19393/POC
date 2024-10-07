//
//  MyTableViewModel.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import Foundation

class MyTableViewModel {
    var myTableModel: MyTableModel?
    weak var view: MyTableViewOutput?
    
    init(view: MyTableViewOutput) {
        self.view = view
        self.fetchFacts()
    }
    
    func fetchFacts() {
        NetworkManager.shared.fetchFacts { myData, error in
            if error == nil {                
                self.myTableModel = myData
                self.view?.refreshUI()
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
}

extension MyTableViewModel: MyTableViewInput {
    func refreshData() {
        self.fetchFacts()
    }
}
