//
//  Style.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/15/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation
import UIKit

protocol Stylized {
    func stylize()
}

struct Style: Codable {
    
    struct NavigationBar: Codable {
        let fontName: String
        let fontSize: Int
        let tintColor: String
    }

    struct TabBar: Codable {
        let tintColor: String
    }

    struct TaskCell: Codable {
        let title: TitleTaskCell
        let date: DateTaskCell
        let text: TextTaskCell
    }

    struct TitleTaskCell: Codable {
        let fontName: String
        let fontSize: Int
        let color: String
    }

    struct DateTaskCell: Codable {
        let fontName: String
        let fontSize: Int
        let color: String
    }

    struct TextTaskCell: Codable {
        let fontName: String
        let fontSize: Int
        let color: String
    }

    struct CreateTask: Codable {
        let fontName: String
        let fontSize: Int
        let color: String
    }

    let navigationBar: NavigationBar
    let tabBar: TabBar
    let taskCell: TaskCell
    let createTask: CreateTask
}
