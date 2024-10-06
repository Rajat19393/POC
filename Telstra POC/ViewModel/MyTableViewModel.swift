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
                let rows = [Row(title: "Link", description: "LinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLinkLink", imageHref: "Link"),
                 Row(title: "Zelda", description: "ZeldaZeldaZeldaZeldaZeldaZelda", imageHref: "Link"),
                 Row(title: "Ganondorf", description: "GanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorfGanondorf", imageHref: "Link"),
                 Row(title: "Midna", description: "MidnaMidnaMidnaMidnaMidnaMidna", imageHref: "Link")]
                
                self.myTableModel = MyTableModel(title: "", rows: rows)
                self.view?.refreshUI()
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
