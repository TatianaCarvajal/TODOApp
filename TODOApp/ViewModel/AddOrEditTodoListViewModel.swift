//
//  AddOrEditTodoListViewModel.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 29/05/23.
//

import Foundation

class AddOrEditTodoListViewModel {
    
    var persistence: PersistenceRepository
    var todoItem: TodoItem?
    var taskTitle: String = ""
    var taskDate: Date = .now
    @Published var didCreateTask: Bool = false
    @Published var error: Error?
    
    init(persistence: PersistenceRepository, todoItem: TodoItem?) {
        self.persistence = persistence
        self.todoItem = todoItem
    }
    
    func update(_ title: String) {
        taskTitle = title
    }
    
    func update(_ date: Date) {
        taskDate = date
    }
    
    func createTask() {
        if todoItem == nil {
            createNewTask()
        } else {
            updateTask()
        }
    }
    
    private func createNewTask() {
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
    
    private func updateTask() {
        guard let todoItem = todoItem else {
            return
        }
        
        Task {
            do {
                try await persistence.updateTodoItem(todoItem: todoItem, newTask: taskTitle, newDate: taskDate)
                didCreateTask = true
            } catch {
                didCreateTask = false
                self.error = error
            }
        }
    }
}

