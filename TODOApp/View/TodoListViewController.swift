//
//  TODOListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 18/05/23.
//

import UIKit
import Combine

protocol AddOrEditDelegate: AnyObject {
    func fetchNewTasks()
}

class TodoListViewController: UIViewController {
    
    private struct Constants {
        static let tableViewPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let buttonPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNavBarButton))
        return button
    }()
    
    private let viewModel: TodoListViewModel
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupNavBar()
        setupSuscribers()
        setupTableView()
        self.viewModel.loadActivities()
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func handleNavBarButton() {
        
        let addOrEditViewController = self.getAddOrEditViewController()
        
        self.present(addOrEditViewController, animated: true)
    }
    
    private func setupSuscribers() {
        self.viewModel.$isRequestInFlight
            .receive(on: DispatchQueue.main)
            .sink { [ unowned self ] value in
                if value {
                    // TODO: show un spinner(ActivityIndicator) 
                } else {
                    // Stop spinner animation
                }
            }
            .store(in: &self.cancellables)
        
        self.viewModel.$activities
            .receive(on: DispatchQueue.main)
            .sink { [ unowned self ] _ in
                self.tableView.reloadData()
            }
            .store(in: &self.cancellables)
        
        self.viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] error in
                if error != nil {
                    showAlert()
                }
            }
            .store(in: &self.cancellables)
    }
    
    private func setupTableView() {
        view.addSubview(self.tableView)
        
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewPadding.left).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.tableViewPadding.right).isActive = true
        self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.tableViewPadding.top).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.tableViewPadding.bottom).isActive = true
    }
    
    private func getAddOrEditViewController() -> AddOrEditTodoListViewController {
        let viewModel = AddOrEditTodoListViewModel(persistence: CoreDataManager())
        let addViewController = AddOrEditTodoListViewController(viewModel: viewModel)
        addViewController.delegate = self 
        return addViewController
    }
    
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TodoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.activities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.cellIdentifier, for: indexPath) as? TodoItemTableViewCell else {
            
            return UITableViewCell()
        }
        
        let title = self.viewModel.getActivityTitle(pos: indexPath.row)
        let formattedDate = self.viewModel.getFormattedDate(pos: indexPath.row)
        cell.configureCell(task: title, date: formattedDate)
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { [weak self] action, view, completionHandler in
            self?.viewModel.deleteTask(pos: indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .red
        let configuration = UIImage.SymbolConfiguration(pointSize: 28)
        let image = UIImage(systemName: "trash.circle.fill", withConfiguration: configuration)
        action.image = image
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension TodoListViewController: AddOrEditDelegate {
    func fetchNewTasks() {
        viewModel.loadActivities()
    }
    
    
}
