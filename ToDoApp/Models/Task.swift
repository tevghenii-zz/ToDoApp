//
//  Task.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/13/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation

struct Task: Codable {
    let id: String = String.random(length: 10)
    let date: Date
    let title: String
    let text: String
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
