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
    var myTableModel: MyTableModel? { get set }
    
    func refreshData()
    func fetchFacts()
}

class MyTableViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let refreshControl = UIRefreshControl()
    
    var viewModel: MyTableViewModel!
    
    let navItem = UINavigationItem(title: Constants.loadingTitle)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupViewModel()
        setupTableView()
        setupRefreshControl()
        setupNavBar()
    }
    
    private func setupViewModel() {
        let myTableViewModel = MyTableViewModel(view: self)
        self.viewModel = myTableViewModel
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 44).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: Constants.TableViewIds.myTableViewCellReUseId)
        tableView.dataSource = self
    }
    
    private func setupNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        navBar.barTintColor = .white
        view.addSubview(navBar)
        navBar.setItems([navItem], animated: false)
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: Constants.pullToRefresh)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIds.myTableViewCellReUseId, for: indexPath) as? MyTableViewCell else{
            return UITableViewCell()
        }
        cell.fact = self.viewModel.myTableModel?.rows[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension MyTableViewController {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Adjust the width of the navigation bar based on the view's width
        if let navBar = view.subviews.compactMap({ $0 as? UINavigationBar }).first {
            navBar.frame.size.width = view.frame.size.width
        }
    }
}

extension MyTableViewController: MyTableViewOutput {
    func refreshUI() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.navItem.title = self.viewModel.myTableModel?.title ?? Constants.loadingTitle
            self.tableView.reloadData()
        }
    }
}


