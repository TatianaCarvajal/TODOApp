//
//  TODOListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 18/05/23.
//

import UIKit
import Combine

class TodoListViewController: UIViewController {
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private struct Constants {
        static let tableViewPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
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
        view.backgroundColor = .cyan
        setupSuscribers()
        setupTableView()
        viewModel.loadActivities()
    }
    
    private func setupSuscribers() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [ unowned self ] state in
                switch state {
                case .idle: break
                case .fetching:
                    // TODO: show un spinner(ActivityIndicator) o una animación de Lottie
                    print("qoijeqwoje")
                case .refresh:
                    // Stop spinner animation
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
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
        return viewModel.activities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.cellIdentifier, for: indexPath) as? TodoItemTableViewCell else {
            
            return UITableViewCell()
        }
        
        let title = viewModel.getActivityTitle(pos: indexPath.row)
        let formattedDate = viewModel.getFormattedDate(pos: indexPath.row)
        cell.configureCell(task: title, date: formattedDate)
        return cell
    }
}

extension TodoListViewController: UITableViewDelegate {
    
    private func handleMoveToTrash() {
        print("Moved to trash")
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { [weak self] action, view, completionHandler in
            self?.handleMoveToTrash()
            completionHandler(true)
        }
        action.backgroundColor = .red
        let configuration = UIImage.SymbolConfiguration(pointSize: 28)
        let image = UIImage(systemName: "trash.circle.fill", withConfiguration: configuration)
        action.image = image
        return UISwipeActionsConfiguration(actions: [action])
    }
}
