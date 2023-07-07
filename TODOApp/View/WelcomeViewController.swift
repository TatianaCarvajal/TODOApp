//
//  WelcomeViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 7/07/23.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    private struct Constants {
        static let labelViewPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bienvenido a TODOAPP"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.backgroundColor = UIColor(named: "backgroundColor")
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        setupLabel()
    }
    
    private func setupLabel() {
        view.addSubview(self.label)
        
        self.label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
