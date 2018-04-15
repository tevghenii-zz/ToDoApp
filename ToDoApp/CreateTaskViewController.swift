//
//  FirstViewController.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/13/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import UIKit
import SwiftForms

class CreateTaskViewController: FormViewController {
    private let viewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Create Task", comment: "Create Task")
        
        tableView.tableFooterView = UIView()
        
        createForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stylize()
    }
    
    private func createForm() {
        let form = FormDescriptor()
        form.title = NSLocalizedString("Create Task", comment: "Create Task")
        
        // Define first section
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var rowTitle = NSLocalizedString("Create Task", comment: "Create Task")
        var rowPlaceholder = NSLocalizedString("Task Title", comment: "Task Title")
        var row = FormRowDescriptor(tag: "title", type: .text, title: rowTitle)
        row.configuration.cell.placeholder = rowPlaceholder
        section1.rows.append(row)
        
        rowTitle = NSLocalizedString("Date", comment: "Date")
        rowPlaceholder = NSLocalizedString("Date", comment: "Date")
        row = FormRowDescriptor(tag: "date", type: .date, title: rowTitle)
        row.configuration.cell.placeholder = rowPlaceholder
        section1.rows.append(row)
        
        rowTitle = NSLocalizedString("Text", comment: "Text")
        rowPlaceholder = NSLocalizedString("Task details", comment: "Task details")

        row = FormRowDescriptor(tag: "text", type: .text, title: rowTitle)
        row.configuration.cell.placeholder = rowPlaceholder
        section1.rows.append(row)
        
        // Define second section
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        rowTitle = NSLocalizedString("Create", comment: "Create")
        row = FormRowDescriptor(tag: "button", type: .button, title: rowTitle)
        row.configuration.button.didSelectClosure = { [weak self] _ in
            self?.submit()
        }
        section2.rows.append(row)
        
        form.sections = [section1, section2]
        self.form = form
    }
    
    private func submit() {
        let values = self.form.formValues()
        guard let task = viewModel.task(values: values) else { return }
        
        viewModel.add(task: task)
        navigationController?.popViewController(animated: true)
    }
}

extension CreateTaskViewController: Stylized {
    func stylize() {
        let styleViewModel = StyleViewModel()
        guard let style = styleViewModel.style(at: StyleViewModel.defaultStyleIndex) else { return }
        
        let fontName = style.createTask.fontName
        let fontSize = style.createTask.fontSize
        let font = UIFont(name: fontName, size: CGFloat(fontSize))
        let color = UIColor.fromHEX(hex: style.createTask.color)
        
        for cell in self.tableView.visibleCells {
            if let textFieldCell = cell as? FormTextFieldCell {
                textFieldCell.titleLabel.font = font
                textFieldCell.titleLabel.textColor = color
            }
            if let dateCell = cell as? FormDateCell {
                dateCell.titleLabel.font = font
                dateCell.titleLabel.textColor = color
            }
            if let buttonCell = cell as? FormButtonCell {
                buttonCell.titleLabel.font = font
                buttonCell.titleLabel.textColor = color
            }
        }
    }
}
