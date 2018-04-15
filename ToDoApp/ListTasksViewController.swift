//
//  SecondViewController.swift
//  ToDoApp
//
//  Created by Evghenii Todorov on 4/13/18.
//  Copyright © 2018 Todorov Evghenii. All rights reserved.
//

import UIKit
import SwipyCell

class ListTasksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TaskViewModel = TaskViewModel()
    var period: TaskViewModel.TaskDatePeriod = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = NSLocalizedString("Tasks", comment: "Tasks")
        
        let cellNib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TaskItemIdentifier")
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.isEditing = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.period = (tabBarController?.selectedIndex == 0) ? .all : .today
        tableView.reloadSections([0], with: .automatic)
    }
}

extension ListTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count(period: period)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemIdentifier") as! TaskTableViewCell
        if let task = viewModel.task(at: indexPath, period: period) {
            cell.update(task)
            
            let imageView = UIImageView(image: UIImage(named: "TrashIcon"))
            cell.addSwipeTrigger(forState: .state(0, .right), withMode: .exit, swipeView: imageView, swipeColor: .red, completion: { [unowned self] cell, trigger, state, mode in
                
                self.viewModel.remove(at: indexPath, period: self.period)
                self.tableView.reloadSections([0], with: .automatic)
            })
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.move(source: sourceIndexPath, destination: destinationIndexPath, period: self.period)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
