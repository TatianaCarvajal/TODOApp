//
//  TodoListViewModel.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 22/05/23.
//

import Foundation
import Combine

class TodoListViewModel {
    @Published private(set) var activities: [TodoItem] = []
    @Published var isRequestInFlight: Bool = false
    @Published var error: Error? = nil
    
    func loadActivities() {
        isRequestInFlight = true
        Task {
            // self.activities = datos que vengan de tu clase que sirva para usar coredata
            isRequestInFlight = false
        }
    }
    
    func getActivityTitle(pos: Int) -> String {
        let item = activities[pos]
        return item.activity
    }
    
    func getFormattedDate(pos: Int) -> String {
        let item = activities[pos]
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        return formatter.string(from: item.date)
    }
    
    func deleteTask(pos:Int) {
        isRequestInFlight = true
        Task {
            // llamar a la clase de coredata que te remueve un elemento
            isRequestInFlight = false
        }
    }
    
    func getAddOrEditViewController() -> AddOrEditTodoListViewController {
        let viewModel = AddOrEditTodoListViewModel()
        var addViewController = AddOrEditTodoListViewController(viewModel: viewModel)
        return addViewController
    }
}
