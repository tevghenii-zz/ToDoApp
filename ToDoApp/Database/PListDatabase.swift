//
//  PListDatabase.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/15/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation

class PListDatabase: Database {
    private let plistFileName = "database.plist"
    private let stylesFileName = "Styles.json"
    private var tasks: [Task] = []
    
    required init() {
        read()
    }
    
    func add(task: Task) {
        tasks.insert(task, at: 0)
        save()
    }
    
    func fetch() -> [Task] {
        read()
        return tasks
    }
    
    func remove(task: Task) {
        if let index = tasks.index(of: task) {
            tasks.remove(at: index)
            save()
        }
    }
    
    func swap(source: Task, destination: Task) {
        if let sourceIndex = tasks.index(of: source), let destinationIndex = tasks.index(of: destination) {
            let task = tasks.remove(at: sourceIndex)
            tasks.insert(task, at: destinationIndex)
            save()
        }
    }
    
    func styles() -> [Style] {
        
        let decoder = JSONDecoder()
        
        guard let data = try? Data(contentsOf: stylesURL) else { return [] }
        let styles: [Style] = (try? decoder.decode([Style].self, from: data)) ?? []
        
        return styles
    }
    
    private func save() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(self.tasks)
            try data.write(to: self.url)
        } catch {
            // Handle error
            print(error)
        }
    }
    
    private func read() {
        var tasks: [Task]?
        if let data = try? Data(contentsOf: self.url) {
            let decoder = PropertyListDecoder()
            tasks = try? decoder.decode([Task].self, from: data)
        }
        
        self.tasks = tasks ?? []
    }
    
    private var url: URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(plistFileName)
        let url: URL = URL(fileURLWithPath: path)
        
        return url
    }
    
    private var stylesURL: URL {
        let path = Bundle.main.path(forResource: stylesFileName, ofType: nil)!
        let url: URL = URL(fileURLWithPath: path)
        
        return url
    }
}
