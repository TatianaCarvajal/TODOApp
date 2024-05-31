//
//  TodoItemTableViewCell.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 18/05/23.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    static let cellIdentifier = "TodoItemTableViewCell"
    
    private struct Constants {
        static let labelPadding = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
        static let dateLabelPadding = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: -10)
    }

    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLabel() {
        contentView.addSubview(taskLabel)
        
        taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.labelPadding.left).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.labelPadding.right).isActive = true
        taskLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.labelPadding.top).isActive = true
        taskLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: Constants.labelPadding.bottom).isActive = true
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.dateLabelPadding.left).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.dateLabelPadding.right).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: Constants.dateLabelPadding.top).isActive = true
    }
    
    func configureCell(task: String, date: String) {
        taskLabel.text = task
        dateLabel.text = date
        
        setupDateLabel()
        setupLabel()
    }
}

