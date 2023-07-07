//
//  AddOrEditTodoListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 29/05/23.
//

import UIKit
import Combine

class AddOrEditTodoListViewController: UIViewController {
    
    private struct Constants {
        static let textFieldPadding = UIEdgeInsets(top: 60, left: 10, bottom: 0, right: -10)
        static let textFieldHeight: CGFloat = 60
        static let calendarPadding = UIEdgeInsets(top: 60, left: 10, bottom: 0, right: -10)
        static let calendarHeight: CGFloat = 320
        static let buttonpadding = UIEdgeInsets(top: 10, left: 35, bottom: -30, right: -35)
        static let buttonHeight: CGFloat = 40
    }
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = viewModel.todoItem?.activity
        textField.placeholder = "New task"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var calendar: UICalendarView = {
        let calendar = UICalendarView()
        calendar.fontDesign = .rounded
        calendar.layer.cornerRadius = 12
        calendar.backgroundColor = .systemBackground
        calendar.translatesAutoresizingMaskIntoConstraints = false
        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        selectionBehavior.selectedDate = Calendar.current.dateComponents([.day, .month, .year], from: viewModel.todoItem?.date ?? .now)
        calendar.selectionBehavior = selectionBehavior
        return calendar
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    
    
    let viewModel: AddOrEditTodoListViewModel
    var cancellables = Set<AnyCancellable>()
    
    weak var delegate: AddOrEditDelegate?
    
    init(viewModel: AddOrEditTodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupTextField()
        setupCalendar()
        setupAddButton()
        setupSuscribers()
    }
    
    @objc private func textFieldChanged() {
        guard let text = textField.text else {
            return
        }
        viewModel.update(text)
    }
    
    @objc private func buttonAction() {
        viewModel.createTask()
    }
    
    private func setupSuscribers() {
        self.viewModel.$didCreateTask
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] value in
                if value == true {
                    delegate?.fetchNewTasks()
                    self.dismiss(animated: true)
                }
                
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
    
    private func setupTextField() {
        view.addSubview(self.textField)
        
        self.textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.textFieldPadding.left).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.textFieldPadding.right).isActive = true
        self.textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.textFieldPadding.top).isActive = true
        self.textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight).isActive = true
    }
    
    private func setupCalendar() {
        view.addSubview(self.calendar)
        
        self.calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.calendarPadding.left).isActive = true
        self.calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.calendarPadding.right).isActive = true
        self.calendar.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.calendarPadding.top).isActive = true
        self.calendar.heightAnchor.constraint(equalToConstant: Constants.calendarHeight).isActive = true
    }
    
    private func setupAddButton() {
        view.addSubview(self.addButton)
        
        self.addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.buttonpadding.left).isActive = true
        self.addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.buttonpadding.right).isActive = true
        self.addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonpadding.bottom).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
    }
    
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddOrEditTodoListViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let selectedDate = selection.selectedDate else {
            return
        }
        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(from: selectedDate) else {
            return
        }
        viewModel.update(date)
    }
}
