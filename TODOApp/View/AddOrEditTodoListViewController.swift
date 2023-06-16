//
//  AddOrEditTodoListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 29/05/23.
//

import UIKit

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
        textField.placeholder = "New task"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var calendar: UICalendarView = {
        let calendar = UICalendarView()
        calendar.fontDesign = .rounded
        calendar.layer.cornerRadius = 12
        calendar.backgroundColor = .systemBackground
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    let viewModel: AddOrEditTodoListViewModel
    
    
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
    
}
