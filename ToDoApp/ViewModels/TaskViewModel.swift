//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/13/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation

class TaskViewModel {
    
    enum TaskDatePeriod {
        case all
        case today
    }
    
    private let database: Database = PListDatabase()
        
    func add(task: Task) {
        database.add(task: task)
    }
    
    func task(at indexPath: IndexPath, period: TaskDatePeriod) -> Task? {
        var tasks = database.fetch()
        
        switch period {
        case .today:
            tasks = tasks.filter { $0.date.isToday }
        case .all:
            break
        }

        guard indexPath.row < tasks.count else { return nil }
        
        return tasks[indexPath.row]
    }
    
    func count(period: TaskDatePeriod) -> Int {
        let tasks = database.fetch()
        
        switch period {
        case .today:
            return (tasks.filter { $0.date.isToday }).count
        case .all:
            return tasks.count
        }
    }
    
    func task(values: [String: AnyObject]) -> Task? {
        guard let date = values["date"] as? Date else { return nil }
        guard let title = values["title"] as? String else { return nil }
        guard let text = values["text"] as? String else { return nil }
        
        return Task(date: date, title: title, text: text)
    }
    
    func remove(at indexPath: IndexPath, period: TaskDatePeriod) {
        if let task = task(at: indexPath, period: period) {
            database.remove(task: task)
        }
    }
    
    func move(source: IndexPath, destination: IndexPath, period: TaskDatePeriod) {
        guard let task0 = task(at: source, period: period) else { return }
        guard let task1 = task(at: destination, period: period) else { return }
        
        database.swap(source: task0, destination: task1)
    }
}
