//
//  TodoListViewModel.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 22/05/23.
//

import Foundation
import Combine

class TodoListViewModel {
    
    enum State {
        case idle, fetching, refresh
    }
    
    private(set) var activities: [TodoItem] = []
    @Published var state: State = .idle
    
    func loadActivities() {
        state = .fetching
        Task {
            let mock  = [
                TodoItem(activity: "Estudiar", date: .now),
                TodoItem(activity: "Leer", date: .now),
                TodoItem(activity: "Comer", date: .now),
                TodoItem(activity: "Jugar", date: .now)
            ]
            activities = mock
            state = .refresh
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
}
