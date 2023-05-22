//
//  TODOListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 18/05/23.
//

import UIKit

class TodoListViewController: UIViewController {
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private struct Constants {
        static let tableViewPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var activitys: [TodoItem] = [TodoItem(activity: "Estudiar", date: .now), TodoItem(activity: "Leer", date: .now), TodoItem(activity: "Comer", date: .now), TodoItem(activity: "Jugar", date: .now)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupTableView()
     
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewPadding.left).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.tableViewPadding.right).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.tableViewPadding.top).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.tableViewPadding.bottom).isActive = true
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitys.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.cellIdentifier, for: indexPath) as? TodoItemTableViewCell else {
            
            return UITableViewCell()
        }
        let item = activitys[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let date = formatter.string(from: item.date)
        cell.configureCell(task: item.activity, date: date)
        return cell
    }
    
    
}
