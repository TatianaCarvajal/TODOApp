//
//  AddOrEditTodoListViewController.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 29/05/23.
//

import UIKit

class AddOrEditTodoListViewController: UIViewController {
    
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
        view.backgroundColor = .red
    }
}
