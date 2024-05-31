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
    var persistence: PersistenceRepository
    
    init(persistence: PersistenceRepository) {
        self.persistence = persistence
    }
    
    func loadActivities() async {
        isRequestInFlight = true
        do {
            activities = try await persistence.getAllTodoItems()
        } catch {
            self.error = error
        }
        isRequestInFlight = false
    }
    
    func getActivityTitle(pos: Int) -> String {
        let item = activities[pos]
        return item.activity
    }
    
    func getTodoItem(pos: Int) -> TodoItem {
        let item = activities[pos]
        return item
    }
    
    func getFormattedDate(pos: Int) -> String {
        let item = activities[pos]
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        return formatter.string(from: item.date)
    }
    
    func deleteTask(pos:Int) async {
        isRequestInFlight = true
        do {
            try await persistence.deleteTodoItem(todoItem: activities[pos])
            await loadActivities()
        } catch {
            self.error = error
        }
        isRequestInFlight = false
    }
}
