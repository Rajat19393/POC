//
//  MyTableViewController.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 04/10/24.
//

import UIKit

protocol MyTableViewOutput:AnyObject {
    func refreshUI()
}
protocol MyTableViewInput: AnyObject {
    func refreshData()
}

class MyTableViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let refreshControl = UIRefreshControl()

    private var viewModel: MyTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupViewModel()
        setupTableView()
        setupRefreshControl()
    }
    
    func setupViewModel() {
        let myTableViewModel = MyTableViewModel(view: self)
        self.viewModel = myTableViewModel
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseId)
        tableView.dataSource = self
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refreshData()
    }
}


extension MyTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.myTableModel?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseId, for: indexPath) as? MyTableViewCell else{
            return UITableViewCell()
        }
        cell.fact = self.viewModel.myTableModel?.rows[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension MyTableViewController: MyTableViewOutput {
    func refreshUI() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.navigationController?.navigationItem.title = self.viewModel.myTableModel?.title ?? "Loading Title ..."
            self.tableView.reloadData()
        }
    }
}
