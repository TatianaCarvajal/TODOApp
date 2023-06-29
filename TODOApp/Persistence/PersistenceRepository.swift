//
//  PersistenceRepository.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 27/06/23.
//

import Foundation

protocol PersistenceRepository {
    
    func getAllTodoItems() async throws -> [TodoItem]
    func createTodoItem(title: String, date: Date) async throws
    func updateTodoItem(todoItem: TodoItem, newTask: String, newDate: Date) async throws
    func deleteTodoItem(todoItem: TodoItem) async throws
}
