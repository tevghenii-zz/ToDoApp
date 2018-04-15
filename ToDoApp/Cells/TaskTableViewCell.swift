//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/14/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import UIKit
import SwipyCell

class TaskTableViewCell: SwipyCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    private let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.numberOfLines = 0
        descLabel.numberOfLines = 0
        
        dateFormatter.dateStyle = .long
        
        stylize()
    }
    
    func update(_ task: Task) {
        titleLabel.text = task.title
        dateLabel.text = dateFormatter.string(from: task.date)
        descLabel.text = task.text
    }
    
}

extension TaskTableViewCell: Stylized {
    func stylize() {
        let styleViewModel = StyleViewModel()
        guard let style = styleViewModel.style(at: StyleViewModel.defaultStyleIndex) else { return }
        
        let titleFont = UIFont(name: style.taskCell.title.fontName, size: CGFloat(style.taskCell.title.fontSize))
        let titleColor = UIColor.fromHEX(hex: style.taskCell.title.color)
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        
        let dateFont = UIFont(name: style.taskCell.date.fontName, size: CGFloat(style.taskCell.date.fontSize))
        let dateColor = UIColor.fromHEX(hex: style.taskCell.date.color)
        dateLabel.font = dateFont
        dateLabel.textColor = dateColor
        
        let textFont = UIFont(name: style.taskCell.text.fontName, size: CGFloat(style.taskCell.text.fontSize))
        let textColor = UIColor.fromHEX(hex: style.taskCell.text.color)
        descLabel.font = textFont
        descLabel.textColor = textColor
    }
}
