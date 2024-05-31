//
//  CoreDataManager.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 27/06/23.
//

import Foundation
import UIKit

class CoreDataManager: PersistenceRepository {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    func getAllTodoItems() async throws -> [TodoItem] {
        let items = try context.fetch(TodoItem.fetchRequest())
        return items
    }
    
    func createTodoItem(title: String, date: Date) async throws {
        let newItem = TodoItem(context: context)
        newItem.activity = title
        newItem.date = date
        try context.save()
    }
    
    func updateTodoItem(todoItem: TodoItem, newTask: String, newDate: Date) async throws {
        todoItem.activity = newTask
        todoItem.date = newDate
        try context.save()
    }
    
    func deleteTodoItem(todoItem: TodoItem) async throws {
        context.delete(todoItem)
        try context.save()
    }
    
     private func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
