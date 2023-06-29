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
    
    init(persistence: PersistenceRepository) {
        self.persistence = persistence
    }
    
    func update(_ title: String) {
        taskTitle = title
        print("current title", taskTitle)
    }
    
    func update(_ date: Date) {
        taskDate = date
        print("current date", taskDate)
    }
    
    func createTask() {
        Task {
            do {
                try await persistence.createTodoItem(title: taskTitle, date: taskDate)
                print("agregó tarea")
            } catch {
                print(error)
            }
        }
    }
    
  
}

