//
//  StyleViewModel.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/15/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import Foundation

class StyleViewModel {
    
    private let database: Database = PListDatabase()
    static let defaultStyleIndex: Int = 0

    func style(at: Int) -> Style? {
        let styles = database.styles()
        guard at < styles.count else { return nil }
        
        return styles[at]
    }
}
