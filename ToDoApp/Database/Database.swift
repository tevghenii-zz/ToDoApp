//
//  Database.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/13/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation

protocol Database {
    func add(task: Task)
    func remove(task: Task)
    func fetch() -> [Task]
    func swap(source: Task, destination: Task)
    func styles() -> [Style]
}
