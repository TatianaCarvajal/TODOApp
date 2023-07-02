//
//  AddOrEditTodoListViewModel.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 29/05/23.
//

import Foundation

class AddOrEditTodoListViewModel {
    
    var persistence: PersistenceRepository
    var taskTitle: String = ""
    var taskDate: Date = .now
    @Published var didCreateTask: Bool = false
    @Published var error: Error?
    
    init(persistence: PersistenceRepository) {
        self.persistence = persistence
    }
    
    func update(_ title: String) {
        taskTitle = title
    }
    
    func update(_ date: Date) {
        taskDate = date
    }
    
    func createTask() {
        Task {
            do {
                try await persistence.createTodoItem(title: taskTitle, date: taskDate)
                didCreateTask = true
            } catch {
                didCreateTask = false
                self.error = error
            }
        }
    }
    
  
}

