//
//  PersistenceRepository.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 27/06/23.
//

import Foundation

protocol PersistenceRepository {
    
    func getAllTodoItems() -> [TodoItem]
    func createTodoItem(title: String, date: Date)
    func updateTodoItem(todoItem: TodoItem)
    func deleteTodoItem(todoItem: TodoItem)
}
